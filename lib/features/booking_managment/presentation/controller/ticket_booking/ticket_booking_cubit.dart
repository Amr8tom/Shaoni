import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/domain/entity/ticket_booking/create_ticket_booking_response.dart';
import 'package:shaoni/features/booking_managment/domain/entity/ticket_booking/ticket_class.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_employee.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/ticket_booking/create_ticket_booking_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/ticket_booking/get_ticket_employees_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/ticket_booking/get_ticket_types_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/ticket_booking/update_ticket_booking_use_case.dart';

part 'ticket_booking_state.dart';

class TicketBookingCubit extends Cubit<TicketBookingState> {
  final GetTicketTypesUseCase _getTicketTypesUseCase;
  final GetTicketEmployeesUseCase _getTicketEmployeesUseCase;
  final CreateTicketBookingUseCase _createTicketBookingUseCase;
  final UpdateTicketBookingUseCase _updateTicketBookingUseCase;
  final SessionStorage _sessionStorage;

  final requestFormKey = GlobalKey<FormState>();

  final officeIdController = TextEditingController();
  final taskTypeController = TextEditingController();
  final directionController = TextEditingController();
  final noteController = TextEditingController();

  int _lineCounter = 0;

  TicketBookingCubit(
    this._getTicketTypesUseCase,
    this._getTicketEmployeesUseCase,
    this._createTicketBookingUseCase,
    this._updateTicketBookingUseCase,
    this._sessionStorage,
  ) : super(const TicketBookingState()) {
    _loadLookups();
    _addLine();
  }

  // ── Lookups ────────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: TicketBookingStatus.lookupsLoading));

    final results = await Future.wait([
      _getTicketTypesUseCase.call(params: NoParams()),
      _getTicketEmployeesUseCase.call(params: NoParams()),
    ]);

    if (isClosed) return;

    final classesResult = results[0];
    final employeesResult = results[1];

    List<TicketClass> ticketClasses = [];
    List<VisaEmployee> employees = [];
    String? error;

    classesResult.fold(
      (f) => error = f.message,
      (data) => ticketClasses = data as List<TicketClass>,
    );
    employeesResult.fold(
      (f) => error ??= f.message,
      (data) => employees = data as List<VisaEmployee>,
    );

    emit(state.copyWith(
      status: error != null
          ? TicketBookingStatus.lookupsError
          : TicketBookingStatus.lookupsLoaded,
      ticketClasses: ticketClasses,
      employees: employees,
      errorMessage: error,
    ));
  }

  // ── Header fields ──────────────────────────────────────────────────────────

  void selectTicketType(String value) =>
      emit(state.copyWith(selectedTicketType: value));

  void setTravelDate(DateTime date) => emit(state.copyWith(travelDate: date));

  void setAttachment(String? name, String? base64) {
    emit(state.copyWith(
      attachmentName: name ?? '',
      attachmentBase64: base64 ?? '',
    ));
  }

  // ── Line management ──────────────────────────────────────────────────────

  void _addLine() {
    final id = 'line_${_lineCounter++}';
    final lines = List<TicketLineState>.from(state.lines)
      ..add(TicketLineState(localId: id));
    emit(state.copyWith(lines: lines));
  }

  void addLine() => _addLine();

  void removeLine(String localId) {
    final lines = state.lines.where((l) => l.localId != localId).toList();
    emit(state.copyWith(lines: lines));
  }

  void setLineEmployee(String localId, VisaEmployee employee) {
    final lines = state.lines
        .map((l) => l.localId == localId
            ? l.copyWith(
                employeeId: employee.id, employeeName: employee.displayName)
            : l)
        .toList();
    emit(state.copyWith(lines: lines));
  }

  void setLineTravelDate(String localId, DateTime date) {
    final lines = state.lines
        .map((l) => l.localId == localId ? l.copyWith(travelDate: date) : l)
        .toList();
    emit(state.copyWith(lines: lines));
  }

  void setLineTicketClass(String localId, int classId) {
    final lines = state.lines
        .map((l) =>
            l.localId == localId ? l.copyWith(ticketClassId: classId) : l)
        .toList();
    emit(state.copyWith(lines: lines));
  }

  void setLineAttachment(String localId, String? name, String? base64) {
    final lines = state.lines
        .map((l) => l.localId == localId
            ? l.copyWith(
                attachmentName: name ?? '', attachmentBase64: base64 ?? '')
            : l)
        .toList();
    emit(state.copyWith(lines: lines));
  }

  // ── Build params ─────────────────────────────────────────────────────────

  CreateTicketBookingParams _buildParams() {
    final empId = int.tryParse(_sessionStorage.employeeId ?? '0') ?? 0;
    final today = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());

    final lineParams = state.lines
        .where((l) => l.employeeId != null)
        .map((l) => TicketBookingLineParams(
              employeeId: l.employeeId!,
              travelDate: _apiDate(l.travelDate ?? state.travelDate),
              ticketType: l.ticketClassId ?? 0,
              attachment: l.attachmentBase64,
            ))
        .toList();

    return CreateTicketBookingParams(
      responsibleEmployee: empId,
      officeId: int.tryParse(officeIdController.text) ?? 0,
      date: today,
      travelDate: _apiDate(state.travelDate),
      ticketType: state.selectedTicketType,
      taskType: taskTypeController.text.trim(),
      direction: directionController.text.trim(),
      note: noteController.text.trim(),
      lineIds: lineParams,
      attachmentIds: state.attachmentBase64.isEmpty
          ? const []
          : [
              TicketBookingAttachmentParams(
                name: state.attachmentName,
                attachment: state.attachmentBase64,
              ),
            ],
    );
  }

  // ── Create / Update ───────────────────────────────────────────────────────

  Future<void> createTicketBooking() async {
    emit(state.copyWith(status: TicketBookingStatus.createLoading));
    final result =
        await _createTicketBookingUseCase.call(params: _buildParams());
    if (isClosed) return;
    _handleSubmitResult(result);
  }

  Future<void> updateTicketBooking({required int requestId}) async {
    emit(state.copyWith(status: TicketBookingStatus.createLoading));
    final result = await _updateTicketBookingUseCase.call(
      params: UpdateTicketBookingParams(
        requestId: requestId,
        data: _buildParams(),
      ),
    );
    if (isClosed) return;
    _handleSubmitResult(result);
  }

  void _handleSubmitResult(
      Either<Failure, CreateTicketBookingResponse> result) {
    result.fold(
      (failure) => emit(state.copyWith(
        status: TicketBookingStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: TicketBookingStatus.createLoaded,
        requestNumber: response.requestName.isNotEmpty
            ? response.requestName
            : (response.requestId?.toString() ?? ''),
      )),
    );
  }

  // ── Reset ────────────────────────────────────────────────────────────────

  void resetForm() {
    officeIdController.clear();
    taskTypeController.clear();
    directionController.clear();
    noteController.clear();
    _lineCounter = 0;
    emit(state.copyWith(
      selectedTicketType: '',
      travelDate: null,
      lines: const [],
      attachmentName: '',
      attachmentBase64: '',
    ));
    _addLine();
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  String _apiDate(DateTime? date) =>
      date == null ? '' : DateFormat('yyyy-MM-dd', 'en').format(date);

  @override
  Future<void> close() {
    officeIdController.dispose();
    taskTypeController.dispose();
    directionController.dispose();
    noteController.dispose();
    return super.close();
  }
}
