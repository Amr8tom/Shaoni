import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/create_leave_interruption_response.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/employee_leave.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/interruption_type.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/leave_type.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/create_leave_interruption_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/get_interruption_types_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/get_leave_types_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/search_employee_leaves_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/update_leave_interruption_use_case.dart';

part 'leave_interruption_state.dart';

class LeaveInterruptionCubit extends Cubit<LeaveInterruptionState> {
  final GetInterruptionTypesUseCase _getInterruptionTypesUseCase;
  final GetLeaveTypesUseCase _getLeaveTypesUseCase;
  final SearchEmployeeLeavesUseCase _searchEmployeeLeavesUseCase;
  final CreateLeaveInterruptionUseCase _createLeaveInterruptionUseCase;
  final UpdateLeaveInterruptionUseCase _updateLeaveInterruptionUseCase;
  final SessionStorage _sessionStorage;

  final requestFormKey = GlobalKey<FormState>();

  final officeIdController = TextEditingController();
  final reasonsController = TextEditingController();

  LeaveInterruptionCubit(
    this._getInterruptionTypesUseCase,
    this._getLeaveTypesUseCase,
    this._searchEmployeeLeavesUseCase,
    this._createLeaveInterruptionUseCase,
    this._updateLeaveInterruptionUseCase,
    this._sessionStorage,
  ) : super(const LeaveInterruptionState()) {
    _loadLookups();
  }

  // ── Lookups ────────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: LeaveInterruptionStatus.lookupsLoading));

    final results = await Future.wait([
      _getInterruptionTypesUseCase.call(params: NoParams()),
      _getLeaveTypesUseCase.call(params: NoParams()),
    ]);

    if (isClosed) return;

    final interruptionResult = results[0];
    final leaveTypesResult = results[1];

    List<InterruptionType> interruptionTypes = [];
    List<LeaveType> leaveTypes = [];
    String? error;

    interruptionResult.fold(
      (f) => error = f.message,
      (data) => interruptionTypes = data as List<InterruptionType>,
    );
    leaveTypesResult.fold(
      (f) => error ??= f.message,
      (data) => leaveTypes = data as List<LeaveType>,
    );

    emit(state.copyWith(
      status: error != null
          ? LeaveInterruptionStatus.lookupsError
          : LeaveInterruptionStatus.lookupsLoaded,
      interruptionTypes: interruptionTypes,
      leaveTypes: leaveTypes,
      errorMessage: error,
    ));
  }

  // ── Selections ─────────────────────────────────────────────────────────────

  void selectInterruptionType(int id) =>
      emit(state.copyWith(selectedInterruptionTypeId: id));

  void selectLeaveType(int id) {
    emit(state.copyWith(
      selectedLeaveTypeId: id,
      clearSelectedLeave: true,
      employeeLeaves: const [],
    ));
    _loadEmployeeLeaves(id);
  }

  Future<void> _loadEmployeeLeaves(int leaveTypeId) async {
    emit(state.copyWith(leavesLoading: true));
    final result = await _searchEmployeeLeavesUseCase.call(
      params: SearchEmployeeLeavesParams(leaveTypeId: leaveTypeId),
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        leavesLoading: false,
        status: LeaveInterruptionStatus.createError,
        errorMessage: failure.message,
      )),
      (leaves) => emit(state.copyWith(
        leavesLoading: false,
        employeeLeaves: leaves,
      )),
    );
  }

  void selectLeave(int id) => emit(state.copyWith(selectedLeaveId: id));

  void setInterruptionDate(DateTime date) =>
      emit(state.copyWith(interruptionDate: date));

  void setAttachment(String? name, String? base64) {
    emit(state.copyWith(
      attachmentName: name ?? '',
      attachmentBase64: base64 ?? '',
    ));
  }

  // ── Build params ─────────────────────────────────────────────────────────

  CreateLeaveInterruptionParams _buildParams() {
    final empId = int.tryParse(_sessionStorage.employeeId ?? '0') ?? 0;
    final today = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());

    return CreateLeaveInterruptionParams(
      employeeId: empId,
      requestDate: today,
      leaveInterruptionTypeId: state.selectedInterruptionTypeId ?? 0,
      leaveTypeId: state.selectedLeaveTypeId ?? 0,
      leaveId: state.selectedLeaveId ?? 0,
      leaveInterruptionDate: _apiDate(state.interruptionDate),
      reasons: reasonsController.text.trim(),
      attachmentIds: state.attachmentBase64.isEmpty
          ? const []
          : [
              LeaveAttachmentParams(
                name: state.attachmentName,
                attachment: state.attachmentBase64,
              ),
            ],
    );
  }

  // ── Create / Update ───────────────────────────────────────────────────────

  Future<void> createLeaveInterruption() async {
    emit(state.copyWith(status: LeaveInterruptionStatus.createLoading));
    final result =
        await _createLeaveInterruptionUseCase.call(params: _buildParams());
    if (isClosed) return;
    _handleSubmitResult(result);
  }

  Future<void> updateLeaveInterruption({required int requestId}) async {
    emit(state.copyWith(status: LeaveInterruptionStatus.createLoading));
    final result = await _updateLeaveInterruptionUseCase.call(
      params: UpdateLeaveInterruptionParams(
        requestId: requestId,
        data: _buildParams(),
      ),
    );
    if (isClosed) return;
    _handleSubmitResult(result);
  }

  void _handleSubmitResult(
      Either<Failure, CreateLeaveInterruptionResponse> result) {
    result.fold(
      (failure) => emit(state.copyWith(
        status: LeaveInterruptionStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: LeaveInterruptionStatus.createLoaded,
        requestNumber: response.requestName.isNotEmpty
            ? response.requestName
            : (response.requestId?.toString() ?? ''),
      )),
    );
  }

  // ── Reset ────────────────────────────────────────────────────────────────

  void resetForm() {
    officeIdController.clear();
    reasonsController.clear();
    emit(state.copyWith(
      selectedInterruptionTypeId: null,
      selectedLeaveTypeId: null,
      clearSelectedLeave: true,
      employeeLeaves: const [],
      interruptionDate: null,
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
    reasonsController.dispose();
    return super.close();
  }
}
