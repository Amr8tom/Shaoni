import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/core/local_storage/cache_keys.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/study/study_destination.dart';
import 'package:shaoni/features/human_resoures/domain/entity/study/study_type.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/study/create_study_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/study/get_study_destinations_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/study/get_study_types_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/study/update_study_use_case.dart';
import 'package:shaoni/generated/l10n.dart';

part 'study_state.dart';

class StudyCubit extends Cubit<StudyState> {
  final GetStudyTypesUseCase _getStudyTypesUseCase;
  final GetStudyDestinationsUseCase _getStudyDestinationsUseCase;
  final CreateStudyUseCase _createStudyUseCase;
  final UpdateStudyUseCase _updateStudyUseCase;

  /// Form key
  final requestFormKey = GlobalKey<FormState>();

  /// ── Applicant & date controllers ────────────────────────────────────────
  final todayDateController = TextEditingController();
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();
  final officeIdController = TextEditingController();

  /// ── Request-specific controllers ────────────────────────────────────────
  final studyTypeController = TextEditingController();
  final requiredStudyController = TextEditingController();
  final studyDestinationController = TextEditingController();
  final courseStartDateController = TextEditingController();
  final courseStartHijriController = TextEditingController();
  final courseEndDateController = TextEditingController();
  final courseEndHijriController = TextEditingController();
  final durationController = TextEditingController(); // computed display
  final noteController = TextEditingController();
  final reasonController = TextEditingController();

  /// ── Attachment controllers ───────────────────────────────────────────────
  final attachmentFileController = TextEditingController();
  final attachmentFileNameController = TextEditingController();

  /// Dropdown items for the UI
  List<DropdownMenuItem<String>> studyTypeItems = [];
  List<DropdownMenuItem<String>> studyDestinationItems = [];

  /// Raw lists for ID resolution
  List<StudyType> _studyTypes = [];
  List<StudyDestination> _studyDestinations = [];

  StudyCubit(
    this._getStudyTypesUseCase,
    this._getStudyDestinationsUseCase,
    this._createStudyUseCase,
    this._updateStudyUseCase,
  ) : super(const StudyState()) {
    _loadLookups();
  }

  /// ── Lookups ──────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: StudyStatus.lookupsLoading));
    await Future.wait([_fetchStudyTypes(), _fetchStudyDestinations()]);
    emit(state.copyWith(status: StudyStatus.lookupsLoaded));
  }

  Future<void> _fetchStudyTypes() async {
    final result =
        await _getStudyTypesUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: StudyStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (types) {
        _studyTypes = types;
        studyTypeItems = types
            .map((t) => DropdownMenuItem<String>(
                  value: _localizedName(t.nameAr, t.nameEn),
                  child: Text(
                    _localizedName(t.nameAr, t.nameEn),
                    style: const TextStyle(fontSize: 12),
                  ),
                ))
            .toList();
      },
    );
  }

  Future<void> _fetchStudyDestinations() async {
    final result =
        await _getStudyDestinationsUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: StudyStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (destinations) {
        _studyDestinations = destinations;
        studyDestinationItems = destinations
            .map((d) => DropdownMenuItem<String>(
                  value: d.name,
                  child: Text(d.name, style: const TextStyle(fontSize: 12)),
                ))
            .toList();
      },
    );
  }

  /// ── Helpers: resolve selected name → ID ──────────────────────────────────

  int? get _selectedStudyTypeId {
    if (studyTypeController.text.isEmpty) return null;
    final match = _studyTypes.where(
      (t) => _localizedName(t.nameAr, t.nameEn) == studyTypeController.text,
    );
    return match.isEmpty ? null : match.first.id;
  }

  String get _selectedStudyTypeCode {
    if (studyTypeController.text.isEmpty) return '';
    final match = _studyTypes.where(
      (t) => _localizedName(t.nameAr, t.nameEn) == studyTypeController.text,
    );
    return match.isEmpty ? '' : match.first.code;
  }

  int? get _selectedDestinationId {
    if (studyDestinationController.text.isEmpty) return null;
    final match = _studyDestinations.where(
      (d) => d.name == studyDestinationController.text,
    );
    return match.isEmpty ? null : match.first.id;
  }

  /// ── Create ───────────────────────────────────────────────────────────────

  Future<void> createStudyRequest() async {
    emit(state.copyWith(status: StudyStatus.createStudyRequestLoading));

    final result = await _createStudyUseCase.call(
      params: CreateStudyParams(
        employeeId: int.tryParse(
                CacheHelper.getString(key: CacheKeys.employeeId) ?? '1') ??
            1,
        officeId: int.tryParse(officeIdController.text) ?? 0,
        requestType: _selectedStudyTypeCode,
        study: requiredStudyController.text.trim(),
        studyDestinationId: _selectedDestinationId ?? 0,
        studyStartDate: courseStartDateController.text.trim(),
        studyEndDate: courseEndDateController.text.trim(),
        note: noteController.text.trim(),
        reason: reasonController.text.trim(),
        attachmentName: attachmentFileNameController.text.isEmpty
            ? ''
            : attachmentFileNameController.text.trim(),
        attachment: attachmentFileController.text.isEmpty
            ? ''
            : attachmentFileController.text.trim(),
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: StudyStatus.createStudyRequestError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: StudyStatus.createStudyRequestLoaded,
        requestNumber: response.requestId.toString(),
      )),
    );
  }

  /// ── Reset ────────────────────────────────────────────────────────────────

  /// ── Update ───────────────────────────────────────────────────────────────

  Future<void> updateStudyRequest({required int requestId}) async {
    emit(state.copyWith(status: StudyStatus.createStudyRequestLoading));

    final result = await _updateStudyUseCase.call(
      params: UpdateStudyParams(
        requestId: requestId,
        data: CreateStudyParams(
          employeeId: int.tryParse(
                  CacheHelper.getString(key: CacheKeys.employeeId) ?? '1') ??
              1,
          officeId: int.tryParse(officeIdController.text) ?? 0,
          requestType: _selectedStudyTypeCode,
          study: requiredStudyController.text.trim(),
          studyDestinationId: _selectedDestinationId ?? 0,
          studyStartDate: courseStartDateController.text.trim(),
          studyEndDate: courseEndDateController.text.trim(),
          note: noteController.text.trim(),
          reason: reasonController.text.trim(),
          attachmentName: attachmentFileNameController.text.isEmpty
              ? ''
              : attachmentFileNameController.text.trim(),
          attachment: attachmentFileController.text.isEmpty
              ? ''
              : attachmentFileController.text.trim(),
        ),
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: StudyStatus.createStudyRequestError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: StudyStatus.createStudyRequestLoaded,
        requestNumber: response.requestId.toString(),
      )),
    );
  }

  /// ── Reset ────────────────────────────────────────────────────────────────

  void deleteStudyRequest() {
    todayDateController.clear();
    applicantNameController.clear();
    organizationalUnitController.clear();
    officeIdController.clear();
    studyTypeController.clear();
    requiredStudyController.clear();
    studyDestinationController.clear();
    courseStartDateController.clear();
    courseStartHijriController.clear();
    courseEndDateController.clear();
    courseEndHijriController.clear();
    durationController.clear();
    noteController.clear();
    reasonController.clear();
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
    todayDateController.dispose();
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    officeIdController.dispose();
    studyTypeController.dispose();
    requiredStudyController.dispose();
    studyDestinationController.dispose();
    courseStartDateController.dispose();
    courseStartHijriController.dispose();
    courseEndDateController.dispose();
    courseEndHijriController.dispose();
    durationController.dispose();
    noteController.dispose();
    reasonController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
    return super.close();
  }
}
