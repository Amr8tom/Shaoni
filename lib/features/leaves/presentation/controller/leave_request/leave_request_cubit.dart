import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/leave_type.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_request/create_leave_request_response.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_request/leave_appointment.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_request/leave_employee.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_request/leave_request_edit_data.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/get_leave_request_for_edit_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/get_leave_types_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/create_leave_request_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/get_leave_appointments_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/get_leave_employees_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/update_leave_request_use_case.dart';

part 'leave_request_state.dart';

class LeaveRequestCubit extends Cubit<LeaveRequestState> {
  final GetLeaveTypesUseCase _getLeaveTypesUseCase;
  final GetLeaveEmployeesUseCase _getLeaveEmployeesUseCase;
  final GetLeaveAppointmentsUseCase _getLeaveAppointmentsUseCase;
  final CreateLeaveRequestUseCase _createLeaveRequestUseCase;
  final UpdateLeaveRequestUseCase _updateLeaveRequestUseCase;
  final GetLeaveRequestForEditUseCase _getLeaveRequestForEditUseCase;
  final SessionStorage _sessionStorage;

  final requestFormKey = GlobalKey<FormState>();
  final officeIdController = TextEditingController();

  LeaveRequestCubit(
    this._getLeaveTypesUseCase,
    this._getLeaveEmployeesUseCase,
    this._getLeaveAppointmentsUseCase,
    this._createLeaveRequestUseCase,
    this._updateLeaveRequestUseCase,
    this._getLeaveRequestForEditUseCase,
    this._sessionStorage,
  ) : super(const LeaveRequestState());

  /// Loads lookups, then prefills from the existing request when editing.
  Future<void> init({int? requestId}) async {
    await _loadLookups();
    if (requestId != null) await _prefill(requestId);
  }

  int get _employeeId => int.tryParse(_sessionStorage.employeeId ?? '0') ?? 0;

  // ── Lookups ────────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: LeaveRequestStatus.lookupsLoading));

    final results = await Future.wait([
      _getLeaveTypesUseCase.call(params: NoParams()),
      _getLeaveEmployeesUseCase.call(params: NoParams()),
      _getLeaveAppointmentsUseCase.call(
        params: GetLeaveAppointmentsParams(employeeId: _employeeId),
      ),
    ]);
    if (isClosed) return;

    List<LeaveType> leaveTypes = [];
    List<LeaveEmployee> employees = [];
    List<LeaveAppointment> appointments = [];
    String? error;

    (results[0] as Either<Failure, List<LeaveType>>).fold(
      (f) => error = f.message,
      (d) => leaveTypes = d,
    );
    (results[1] as Either<Failure, List<LeaveEmployee>>).fold(
      (f) => error ??= f.message,
      (d) => employees = d,
    );
    (results[2] as Either<Failure, List<LeaveAppointment>>).fold(
      (_) {},
      (d) => appointments = d,
    );

    emit(state.copyWith(
      status: error != null
          ? LeaveRequestStatus.lookupsError
          : LeaveRequestStatus.lookupsLoaded,
      leaveTypes: leaveTypes,
      employees: employees,
      appointments: appointments,
      errorMessage: error,
    ));
  }

  Future<void> _prefill(int requestId) async {
    final result = await _getLeaveRequestForEditUseCase.call(
      params: GetLeaveRequestForEditParams(requestId: requestId),
    );
    if (isClosed) return;
    result.fold(
      (_) {},
      (data) => emit(state.copyWith(
        selectedLeaveTypeId: data.holidayStatusId,
        selectedAlternativeEmployeeId: data.alternativeEmployeeId,
        startDate: DateTime.tryParse(data.requestDateFrom),
        endDate: DateTime.tryParse(data.requestDateTo),
        existingAttachments: data.attachments,
        sequenceNumber: data.sequenceNumber,
        requestUnitHours: data.requestUnitHours,
        requestUnitHalf: data.requestUnitHalf,
      )),
    );
  }

  // ── Selections ─────────────────────────────────────────────────────────────

  void selectLeaveType(int id) => emit(state.copyWith(selectedLeaveTypeId: id));

  /// Remove an already-stored attachment so it is dropped on update.
  void removeExistingAttachment(int? id) {
    emit(state.copyWith(
      existingAttachments:
          state.existingAttachments.where((a) => a.id != id).toList(),
    ));
  }

  void selectAlternativeEmployee(int id) =>
      emit(state.copyWith(selectedAlternativeEmployeeId: id));

  void setStartDate(DateTime date) => emit(state.copyWith(startDate: date));

  void setEndDate(DateTime date) => emit(state.copyWith(endDate: date));

  void setAttachment(String? name, String? base64) => emit(state.copyWith(
        attachmentName: name ?? '',
        attachmentBase64: base64 ?? '',
      ));

  LeaveType? get selectedLeaveType {
    final id = state.selectedLeaveTypeId;
    if (id == null) return null;
    for (final t in state.leaveTypes) {
      if (t.id == id) return t;
    }
    return null;
  }

  // ── Build params ───────────────────────────────────────────────────────────

  CreateLeaveRequestParams _buildParams() {
    final type = selectedLeaveType;
    return CreateLeaveRequestParams(
      employeeId: _employeeId,
      alternativeEmployee: state.selectedAlternativeEmployeeId,
      holidayStatusId: state.selectedLeaveTypeId ?? 0,
      validationType: type?.leaveValidationType ?? '',
      requestDateFrom: _apiDate(state.startDate),
      requestDateTo: _apiDate(state.endDate),
      supportedAttachmentIds: [
        // Keep the already-uploaded attachments (sent as {id, name, url}).
        ...state.existingAttachments.map(
          (a) => LeaveRequestAttachmentParams(
            id: a.id,
            name: a.name,
            url: a.url,
          ),
        ),
        // Plus the newly picked file (sent as {name, attachment}).
        if (state.attachmentBase64.isNotEmpty)
          LeaveRequestAttachmentParams(
            name: state.attachmentName,
            attachment: state.attachmentBase64,
          ),
      ],
    );
  }

  // ── Create / Update ──────────────────────────────────────────────────────

  Future<void> createLeaveRequest() async {
    emit(state.copyWith(status: LeaveRequestStatus.createLoading));
    final result =
        await _createLeaveRequestUseCase.call(params: _buildParams());
    if (isClosed) return;
    _handleSubmitResult(result);
  }

  Future<void> updateLeaveRequest({required int requestId}) async {
    emit(state.copyWith(status: LeaveRequestStatus.createLoading));
    final result = await _updateLeaveRequestUseCase.call(
      params: UpdateLeaveRequestParams(
        requestId: requestId,
        data: _buildParams(),
        sequenceNumber: state.sequenceNumber,
        requestUnitHours: state.requestUnitHours,
        requestUnitHalf: state.requestUnitHalf,
      ),
    );
    if (isClosed) return;
    _handleSubmitResult(result);
  }

  void _handleSubmitResult(Either<Failure, CreateLeaveRequestResponse> result) {
    result.fold(
      (failure) => emit(state.copyWith(
        status: LeaveRequestStatus.createError,
        errorMessage: failure.message,
      )),
      (response) {
        if (!response.success) {
          emit(state.copyWith(
            status: LeaveRequestStatus.createError,
            errorMessage: response.message,
          ));
          return;
        }
        emit(state.copyWith(
          status: LeaveRequestStatus.createLoaded,
          requestNumber: response.requestName.isNotEmpty
              ? response.requestName
              : (response.requestId?.toString() ?? ''),
        ));
      },
    );
  }

  // ── Reset ────────────────────────────────────────────────────────────────

  void resetForm() {
    officeIdController.clear();
    emit(state.copyWith(
      selectedLeaveTypeId: null,
      clearAlternativeEmployee: true,
      startDate: null,
      endDate: null,
      attachmentName: '',
      attachmentBase64: '',
    ));
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  String _apiDate(DateTime? date) =>
      date == null ? '' : DateFormat('yyyy-MM-dd', 'en').format(date);

  @override
  Future<void> close() {
    officeIdController.dispose();
    return super.close();
  }
}
