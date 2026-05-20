import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/core/local_storage/cache_keys.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/experience_certificate/certificate_reason.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/experience_certificate/get_certificate_reasons_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/experience_certificate/create_experience_certificate_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/experience_certificate/update_experience_certificate_use_case.dart';
import 'package:shaoni/generated/l10n.dart';

part 'experience_certificate_state.dart';

class ExperienceCertificateCubit extends Cubit<ExperienceCertificateState> {
  final GetCertificateReasonsUseCase _getCertificateReasonsUseCase;
  final CreateExperienceCertificateUseCase _createExperienceCertificateUseCase;
  final UpdateExperienceCertificateUseCase _updateExperienceCertificateUseCase;

  /// Form key
  final requestFormKey = GlobalKey<FormState>();

  /// Applicant & date controllers
  final officeIdController = TextEditingController();
  final todayDateController = TextEditingController();
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();

  /// Request-specific controllers
  final certificateReasonController = TextEditingController();
  final reasonController = TextEditingController();
  final noteController = TextEditingController();

  /// Attachment controllers
  final attachmentFileController = TextEditingController();
  final attachmentFileNameController = TextEditingController();

  /// Dropdown items for the UI
  List<DropdownMenuItem<String>> certificateReasonItems = [];

  /// Raw list for ID resolution
  List<CertificateReason> _certificateReasons = [];

  ExperienceCertificateCubit(
    this._getCertificateReasonsUseCase,
    this._createExperienceCertificateUseCase,
    this._updateExperienceCertificateUseCase,
  ) : super(const ExperienceCertificateState()) {
    _loadLookups();
  }

  // ── Lookups ──────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: ExperienceCertificateStatus.lookupsLoading));
    await _fetchCertificateReasons();
    emit(state.copyWith(status: ExperienceCertificateStatus.lookupsLoaded));
  }

  Future<void> _fetchCertificateReasons() async {
    final result =
        await _getCertificateReasonsUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: ExperienceCertificateStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (reasons) {
        _certificateReasons = reasons;
        certificateReasonItems = reasons
            .map((r) => DropdownMenuItem<String>(
                  value: _localizedName(r.nameAr, r.nameEn),
                  child: Text(
                    _localizedName(r.nameAr, r.nameEn),
                    style: const TextStyle(fontSize: 12),
                  ),
                ))
            .toList();
      },
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  int? get _selectedReasonId {
    if (certificateReasonController.text.isEmpty) return null;
    final match = _certificateReasons.where(
      (r) =>
          _localizedName(r.nameAr, r.nameEn) ==
          certificateReasonController.text,
    );
    return match.isEmpty ? null : match.first.id;
  }

  CreateExperienceCertificateParams _buildParams() {
    return CreateExperienceCertificateParams(
      employee: int.tryParse(
              CacheHelper.getString(key: CacheKeys.employeeId) ?? '0') ??
          0,
      officeId: int.tryParse(officeIdController.text) ?? 0,
      certificateReasonId: _selectedReasonId ?? 0,
      reason: reasonController.text.trim(),
      note: noteController.text.trim(),
      date: DateFormat('yyyy-MM-dd',"en").format(DateTime.now()),
      attachmentIds: [],
    );
  }

  // ── Create ───────────────────────────────────────────────────────────────

  Future<void> createExperienceCertificate() async {
    emit(state.copyWith(status: ExperienceCertificateStatus.createLoading));
    final result = await _createExperienceCertificateUseCase.call(
      params: _buildParams(),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: ExperienceCertificateStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: ExperienceCertificateStatus.createLoaded,
        requestNumber: response.requestId.toString(),
      )),
    );
  }

  // ── Update ───────────────────────────────────────────────────────────────

  Future<void> updateExperienceCertificate({required int requestId}) async {
    emit(state.copyWith(status: ExperienceCertificateStatus.createLoading));
    final result = await _updateExperienceCertificateUseCase.call(
      params: UpdateExperienceCertificateParams(
        requestId: requestId,
        data: _buildParams(),
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: ExperienceCertificateStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: ExperienceCertificateStatus.createLoaded,
        requestNumber: response.requestId.toString(),
      )),
    );
  }

  // ── Reset ────────────────────────────────────────────────────────────────

  void resetForm() {
    officeIdController.clear();
    todayDateController.clear();
    applicantNameController.clear();
    organizationalUnitController.clear();
    certificateReasonController.clear();
    reasonController.clear();
    noteController.clear();
    attachmentFileController.clear();
    attachmentFileNameController.clear();
  }

  String _localizedName(String ar, String en) {
    return S.current.localeee == 'en'
        ? (en.isEmpty ? ar : en)
        : (ar.isEmpty ? en : ar);
  }

  @override
  Future<void> close() {
    officeIdController.dispose();
    todayDateController.dispose();
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    certificateReasonController.dispose();
    reasonController.dispose();
    noteController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
    return super.close();
  }
}
