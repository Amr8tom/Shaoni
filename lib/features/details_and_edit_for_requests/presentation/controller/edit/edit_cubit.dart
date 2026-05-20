import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/edit/edit_response.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_attendance_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_car_permission_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_exit_permission_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_study_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_start_work_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_experience_certificate_edit_use_case.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  final GetCarPermissionEditUseCase _getCarPermissionEditUseCase;
  final GetExitPermissionEditUseCase _getExitPermissionEditUseCase;
  final GetAttendanceEditUseCase _getAttendanceEditUseCase;
  final GetStudyEditUseCase _getStudyEditUseCase;
  final GetStartWorkEditUseCase _getStartWorkEditUseCase;
  final GetExperienceCertificateEditUseCase _getExperienceCertificateEditUseCase;
  final editNotesController = TextEditingController();

  EditCubit(
    this._getCarPermissionEditUseCase,
    this._getExitPermissionEditUseCase,
    this._getAttendanceEditUseCase,
    this._getStudyEditUseCase,
    this._getStartWorkEditUseCase,
    this._getExperienceCertificateEditUseCase,
  ) : super(const EditState());

  Future<void> editRequest({
    required int requestId,
    required String serviceCode,
  }) async {
    switch (serviceCode.toLowerCase().trim()) {
      case 'car.permission':
        await _getCarPermissionEdit(requestId: requestId);
        break;
      case 'hr.exit.permission':
        await _getExitPermissionEdit(requestId: requestId);
        break;
      case 'attendance.update':
        await _getAttendanceEdit(requestId: requestId);
        break;
      case 'study.request':
        await _getStudyEdit(requestId: requestId);
        break;
      case 'start.working':
        await _getStartWorkEdit(requestId: requestId);
        break;
      case 'experience.certificate':
        await _getExperienceCertificateEdit(requestId: requestId);
        break;
      default:
        emit(state.copyWith(
          status: EditStatus.error,
          errorMessage: 'Edit not supported for service: $serviceCode',
        ));
    }
  }

  /// ── Car Permission ─────────────────────────────────────────────────────────

  Future<void> _getCarPermissionEdit({required int requestId}) async {
    emit(state.copyWith(status: EditStatus.loading));
    final result = await _getCarPermissionEditUseCase.call(
      params: GetCarPermissionEditParams(
        requestId: requestId,
        notes: editNotesController.text,
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

  /// ── Exit Permission ────────────────────────────────────────────────────────

  Future<void> _getExitPermissionEdit({required int requestId}) async {
    emit(state.copyWith(status: EditStatus.loading));
    final result = await _getExitPermissionEditUseCase.call(
      params: GetExitPermissionEditParams(
        requestId: requestId,
        editReasons: editNotesController.text,
        notes: editNotesController.text,
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

  /// ── Study Request ──────────────────────────────────────────────────────────

  Future<void> _getStudyEdit({required int requestId}) async {
    emit(state.copyWith(status: EditStatus.loading));
    final result = await _getStudyEditUseCase.call(
      params: GetStudyEditParams(
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

  /// ── Attendance ────────────────────────────────────────────────────────────

  Future<void> _getAttendanceEdit({required int requestId}) async {
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

  /// ── Start Work ────────────────────────────────────────────────────────────

  Future<void> _getStartWorkEdit({required int requestId}) async {
    emit(state.copyWith(status: EditStatus.loading));
    final result = await _getStartWorkEditUseCase.call(
      params: GetStartWorkEditParams(
        requestId: requestId,
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

  /// ── Experience Certificate ────────────────────────────────────────────────

  Future<void> _getExperienceCertificateEdit({required int requestId}) async {
    emit(state.copyWith(status: EditStatus.loading));
    final result = await _getExperienceCertificateEditUseCase.call(
      params: GetExperienceCertificateEditParams(
        requestId: requestId,
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
