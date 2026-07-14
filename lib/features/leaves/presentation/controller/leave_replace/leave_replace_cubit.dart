import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/employee_leave.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/leave_type.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_replace/create_leave_replace_response.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/get_leave_types_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/search_employee_leaves_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_replace/create_leave_replace_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_replace/update_leave_replace_use_case.dart';

part 'leave_replace_state.dart';

class LeaveReplaceCubit extends Cubit<LeaveReplaceState> {
  final GetLeaveTypesUseCase _getLeaveTypesUseCase;
  final SearchEmployeeLeavesUseCase _searchEmployeeLeavesUseCase;
  final CreateLeaveReplaceUseCase _createLeaveReplaceUseCase;
  final UpdateLeaveReplaceUseCase _updateLeaveReplaceUseCase;
  final SessionStorage _sessionStorage;

  final requestFormKey = GlobalKey<FormState>();

  final officeIdController = TextEditingController();

  LeaveReplaceCubit(
    this._getLeaveTypesUseCase,
    this._searchEmployeeLeavesUseCase,
    this._createLeaveReplaceUseCase,
    this._updateLeaveReplaceUseCase,
    this._sessionStorage,
  ) : super(const LeaveReplaceState()) {
    _loadLookups();
  }

  // ── Lookups ────────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: LeaveReplaceStatus.lookupsLoading));
    final result = await _getLeaveTypesUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: LeaveReplaceStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (leaveTypes) => emit(state.copyWith(
        status: LeaveReplaceStatus.lookupsLoaded,
        leaveTypes: leaveTypes,
      )),
    );
  }

  // ── Selections ─────────────────────────────────────────────────────────────

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
        status: LeaveReplaceStatus.createError,
        errorMessage: failure.message,
      )),
      (leaves) => emit(state.copyWith(
        leavesLoading: false,
        employeeLeaves: leaves,
      )),
    );
  }

  void selectLeave(int id) => emit(state.copyWith(selectedLeaveId: id));

  void setStartDate(DateTime date) => emit(state.copyWith(startDate: date));

  void setEndDate(DateTime date) => emit(state.copyWith(endDate: date));

  // ── Build params ─────────────────────────────────────────────────────────

  CreateLeaveReplaceParams _buildParams() {
    final empId = int.tryParse(_sessionStorage.employeeId ?? '0') ?? 0;
    final today = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());

    return CreateLeaveReplaceParams(
      employeeId: empId,
      requestDate: today,
      leaveStartDate: _apiDate(state.startDate),
      leaveEndDate: _apiDate(state.endDate),
      leaveTypeId: state.selectedLeaveTypeId ?? 0,
      leaveId: state.selectedLeaveId ?? 0,
    );
  }

  // ── Create / Update ───────────────────────────────────────────────────────

  Future<void> createLeaveReplace() async {
    emit(state.copyWith(status: LeaveReplaceStatus.createLoading));
    final result =
        await _createLeaveReplaceUseCase.call(params: _buildParams());
    if (isClosed) return;
    _handleSubmitResult(result);
  }

  Future<void> updateLeaveReplace({required int requestId}) async {
    emit(state.copyWith(status: LeaveReplaceStatus.createLoading));
    final result = await _updateLeaveReplaceUseCase.call(
      params: UpdateLeaveReplaceParams(
        requestId: requestId,
        data: _buildParams(),
      ),
    );
    if (isClosed) return;
    _handleSubmitResult(result);
  }

  void _handleSubmitResult(Either<Failure, CreateLeaveReplaceResponse> result) {
    result.fold(
      (failure) => emit(state.copyWith(
        status: LeaveReplaceStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: LeaveReplaceStatus.createLoaded,
        requestNumber: response.requestName.isNotEmpty
            ? response.requestName
            : (response.requestId?.toString() ?? ''),
      )),
    );
  }

  // ── Reset ────────────────────────────────────────────────────────────────

  void resetForm() {
    officeIdController.clear();
    emit(state.copyWith(
      selectedLeaveTypeId: null,
      clearSelectedLeave: true,
      employeeLeaves: const [],
      startDate: null,
      endDate: null,
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
