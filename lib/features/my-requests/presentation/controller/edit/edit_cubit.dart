import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shaoni/features/my-requests/domain/entities/edit/edit_response.dart';
import 'package:shaoni/features/my-requests/domain/use_cases/get_attendance_edit_use_case.dart';
import 'package:shaoni/features/my-requests/domain/use_cases/get_car_permission_edit_use_case.dart';
import 'package:shaoni/features/my-requests/domain/use_cases/get_exit_permission_edit_use_case.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  final GetCarPermissionEditUseCase _getCarPermissionEditUseCase;
  final GetExitPermissionEditUseCase _getExitPermissionEditUseCase;
  final GetAttendanceEditUseCase _getAttendanceEditUseCase;
  final editNotesController = TextEditingController();

  EditCubit(
    this._getCarPermissionEditUseCase,
    this._getExitPermissionEditUseCase,
    this._getAttendanceEditUseCase,
  ) : super(const EditState());

  /// Single entry point called from the UI.
  /// Notes are read from [editNotesController] which the UI sets via callback.
  /// Switches on [serviceCode] and fires the matching use case.
  Future<void> editRequest({
    required int requestId,
    required String serviceCode,
  }) async {
    switch (serviceCode.toLowerCase().trim()) {
      case 'car.permission':
        await _getCarPermissionEdit(
          requestId: requestId,
        );
        break;
      case 'hr.exit.permission':
        await _getExitPermissionEdit(
          requestId: requestId,
        );
        break;
      case 'attendance.update':
        await _getAttendanceEdit(
          requestId: requestId,
        );
        break;
      // New services are added here as new cases.
      default:
        emit(state.copyWith(
          status: EditStatus.error,
          errorMessage: 'Edit not supported for service: $serviceCode',
        ));
    }
  }

  /// ── Car Permission ──────────────────────────────────────────────────────────

  Future<void> _getCarPermissionEdit({
    required int requestId,
  }) async {
    emit(state.copyWith(status: EditStatus.loading));
    final result = await _getCarPermissionEditUseCase.call(
      params: GetCarPermissionEditParams(
          requestId: requestId,
          notes: editNotesController.text,
          editReasons: editNotesController.text),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: EditStatus.error,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: EditStatus.editRequestLoaded,
        editResponse: response,
      )),
    );
  }

  /// ── Exit Permission ─────────────────────────────────────────────────────────

  Future<void> _getExitPermissionEdit({
    required int requestId,
  }) async {
    emit(state.copyWith(status: EditStatus.loading));
    final result = await _getExitPermissionEditUseCase.call(
      params: GetExitPermissionEditParams(
          requestId: requestId,
      editReasons: editNotesController.text,
        notes: editNotesController.text
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: EditStatus.error,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: EditStatus.editRequestLoaded,
        editResponse: response,
      )),
    );
  }

  /// ── Attendance ──────────────────────────────────────────────────────────────

  Future<void> _getAttendanceEdit({
    required int requestId,
  }) async {
    emit(state.copyWith(status: EditStatus.loading));
    final result = await _getAttendanceEditUseCase.call(
      params: GetAttendanceEditParams(
        requestId: requestId,
        note: editNotesController.text,
         editReasons: editNotesController.text,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: EditStatus.error,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: EditStatus.editRequestLoaded,
        editResponse: response,
      )),
    );
  }
}
