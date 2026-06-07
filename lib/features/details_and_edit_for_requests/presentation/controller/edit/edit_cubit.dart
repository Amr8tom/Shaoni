import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/constants/service_codes.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/edit/edit_response.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_attendance_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_car_permission_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_exit_permission_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_study_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_start_work_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_experience_certificate_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_id_document_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_medical_insurance_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_training_request_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_product_order_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_outside_working_edit_use_case.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  final GetCarPermissionEditUseCase _getCarPermissionEditUseCase;
  final GetExitPermissionEditUseCase _getExitPermissionEditUseCase;
  final GetAttendanceEditUseCase _getAttendanceEditUseCase;
  final GetStudyEditUseCase _getStudyEditUseCase;
  final GetStartWorkEditUseCase _getStartWorkEditUseCase;
  final GetExperienceCertificateEditUseCase
      _getExperienceCertificateEditUseCase;
  final GetIDDocumentEditUseCase _getIDDocumentEditUseCase;
  final GetMedicalInsuranceEditUseCase _getMedicalInsuranceEditUseCase;
  final GetTrainingRequestEditUseCase _getTrainingRequestEditUseCase;
  final GetProductOrderEditUseCase _getProductOrderEditUseCase;
  final GetOutsideWorkingEditUseCase _getOutsideWorkingEditUseCase;
  final editNotesController = TextEditingController();

  EditCubit(
    this._getCarPermissionEditUseCase,
    this._getExitPermissionEditUseCase,
    this._getAttendanceEditUseCase,
    this._getStudyEditUseCase,
    this._getStartWorkEditUseCase,
    this._getExperienceCertificateEditUseCase,
    this._getIDDocumentEditUseCase,
    this._getMedicalInsuranceEditUseCase,
    this._getTrainingRequestEditUseCase,
    this._getProductOrderEditUseCase,
    this._getOutsideWorkingEditUseCase,
  ) : super(const EditState());

  Future<void> editRequest({
    required int requestId,
    required String serviceCode,
  }) async {
    switch (ServiceCode.fromCode(serviceCode)) {
      case ServiceCode.carPermission:
        await _getCarPermissionEdit(requestId: requestId);
        break;
      case ServiceCode.exitPermission:
        await _getExitPermissionEdit(requestId: requestId);
        break;
      case ServiceCode.attendanceUpdate:
        await _getAttendanceEdit(requestId: requestId);
        break;
      case ServiceCode.studyRequest:
        await _getStudyEdit(requestId: requestId);
        break;
      case ServiceCode.startWork:
        await _getStartWorkEdit(requestId: requestId);
        break;
      case ServiceCode.experienceCertificate:
        await _getExperienceCertificateEdit(requestId: requestId);
        break;
      case ServiceCode.idRenewalRequest:
        await _getIDDocumentEdit(requestId: requestId);
        break;
      case ServiceCode.medicalInsuranceUpgrade:
        await _getMedicalInsuranceEdit(requestId: requestId);
        break;
      case ServiceCode.trainingRequest:
        await _getTrainingRequestEdit(requestId: requestId);
        break;
      case ServiceCode.productRequest:
        await _getProductOrderEdit(requestId: requestId);
        break;
      case ServiceCode.outsideWorking:
        await _getOutsideWorkingEdit(requestId: requestId);
        break;
      case ServiceCode.complaintRequest:
      case ServiceCode.loan:
      case ServiceCode.visaRequest:
      case ServiceCode.scrapRequest:
      case ServiceCode.salaryTransfer:
      case ServiceCode.employeeTicketBooking:
      case ServiceCode.leaveReplace:
      case ServiceCode.leave:
      case ServiceCode.leaveInterruptionRequest:
      case null:
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

  /// ── ID Document ───────────────────────────────────────────────────────────

  Future<void> _getIDDocumentEdit({required int requestId}) async {
    emit(state.copyWith(status: EditStatus.loading));
    final result = await _getIDDocumentEditUseCase.call(
      params: GetIDDocumentEditParams(
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

  /// ── Training Request ──────────────────────────────────────────────────────

  Future<void> _getTrainingRequestEdit({required int requestId}) async {
    emit(state.copyWith(status: EditStatus.loading));
    final result = await _getTrainingRequestEditUseCase.call(
      params: GetTrainingRequestEditParams(
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

  /// ── Product Order ─────────────────────────────────────────────────────────

  Future<void> _getProductOrderEdit({required int requestId}) async {
    emit(state.copyWith(status: EditStatus.loading));
    final result = await _getProductOrderEditUseCase.call(
      params: GetProductOrderEditParams(
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

  /// ── Medical Insurance ─────────────────────────────────────────────────────

  Future<void> _getMedicalInsuranceEdit({required int requestId}) async {
    emit(state.copyWith(status: EditStatus.loading));
    final result = await _getMedicalInsuranceEditUseCase.call(
      params: GetMedicalInsuranceEditParams(
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

  /// ── Outside Working ───────────────────────────────────────────────────────

  Future<void> _getOutsideWorkingEdit({required int requestId}) async {
    emit(state.copyWith(status: EditStatus.loading));
    final result = await _getOutsideWorkingEditUseCase.call(
      params: GetOutsideWorkingEditParams(
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

  @override
  Future<void> close() {
    editNotesController.dispose();
    return super.close();
  }
}
