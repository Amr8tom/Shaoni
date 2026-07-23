import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/study&training/domain/entities/study/study_destination.dart';
import 'package:shaoni/features/study&training/domain/entities/study/study_type.dart';
import 'package:shaoni/features/study&training/domain/use_cases/study/create_study_use_case.dart';
import 'package:shaoni/features/study&training/domain/use_cases/study/get_study_destinations_use_case.dart';
import 'package:shaoni/features/study&training/domain/use_cases/study/get_study_for_edit_use_case.dart';
import 'package:shaoni/features/study&training/domain/use_cases/study/get_study_types_use_case.dart';
import 'package:shaoni/features/study&training/domain/use_cases/study/update_study_use_case.dart';
import 'package:shaoni/generated/l10n.dart';

part 'study_state.dart';

class StudyCubit extends Cubit<StudyState> {
  final GetStudyTypesUseCase _getStudyTypesUseCase;
  final GetStudyDestinationsUseCase _getStudyDestinationsUseCase;
  final CreateStudyUseCase _createStudyUseCase;
  final UpdateStudyUseCase _updateStudyUseCase;
  final GetStudyForEditUseCase _getStudyForEditUseCase;
  final SessionStorage _sessionStorage;

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
  final durationController = TextEditingController();
  final noteController = TextEditingController();
  final reasonController = TextEditingController();
  final commentController = TextEditingController();

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
    this._getStudyForEditUseCase,
    this._sessionStorage,
  ) : super(const StudyState());

  /// Loads lookups, then prefills from the existing request when editing.
  Future<void> init({int? requestId}) async {
    await _loadLookups();
    if (requestId != null) await _prefill(requestId);
  }

  /// Populates the form controllers from an existing study request so an
  /// update does not overwrite untouched fields with blanks.
  Future<void> _prefill(int requestId) async {
    final result = await _getStudyForEditUseCase.call(
      params: GetStudyForEditParams(requestId: requestId),
    );
    if (isClosed) return;

    result.fold((_) {}, (data) {
      requiredStudyController.text = data.study;
      courseStartDateController.text = data.studyStartDate;
      courseEndDateController.text = data.studyEndDate;
      noteController.text = data.note;
      reasonController.text = data.reason;
      commentController.text = data.comment;
      attachmentFileController.text = data.attachmentBase64;
      attachmentFileNameController.text = data.attachmentName;

      // The selected code/id is resolved by matching the controller text back
      // against the loaded lookups, so seed the display name, not the raw id.
      // `requestType` is the study type's `code` (that is what create sends).
      final type =
          _studyTypes.where((t) => t.code == data.requestType).firstOrNull;
      if (type != null) {
        studyTypeController.text = _localizedName(type.nameAr, type.nameEn);
      }
      final destination = _studyDestinations
          .where((d) => d.id == data.studyDestinationId)
          .firstOrNull;
      if (destination != null) {
        studyDestinationController.text = destination.name;
      }

      emit(state.copyWith(status: StudyStatus.lookupsLoaded));
    });
  }

  // ── Lookups ──────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: StudyStatus.lookupsLoading));
    await Future.wait([_fetchStudyTypes(), _fetchStudyDestinations()]);
    if (isClosed) return;
    emit(state.copyWith(status: StudyStatus.lookupsLoaded));
  }

  Future<void> _fetchStudyTypes() async {
    final result = await _getStudyTypesUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: StudyStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (types) {
        _studyTypes = types;
        studyTypeItems = types
            .map((t) => DropdownMenuItem<String>(
                  value: t.nameEn.toString(),
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
    final result = await _getStudyDestinationsUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: StudyStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (destinations) {
        _studyDestinations = destinations;
        studyDestinationItems = destinations
            .map((d) => DropdownMenuItem<String>(
                  value: d.id.toString(),
                  child: Text(d.name, style: const TextStyle(fontSize: 12)),
                ))
            .toList();
      },
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

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

  // ── Create ───────────────────────────────────────────────────────────────

  Future<void> createStudyRequest() async {
    emit(state.copyWith(status: StudyStatus.createStudyRequestLoading));
    final result = await _createStudyUseCase.call(
      params: CreateStudyParams(
        employeeId: int.tryParse(_sessionStorage.employeeId ?? '1') ?? 1,
        officeId: int.tryParse(officeIdController.text) ?? 0,
        requestType: _selectedStudyTypeCode,
        study: requiredStudyController.text.trim(),
        studyDestinationId: _selectedDestinationId ?? 0,
        studyStartDate: courseStartDateController.text.trim(),
        studyEndDate: courseEndDateController.text.trim(),
        note: noteController.text.trim(),
        reason: reasonController.text.trim(),
        comment: commentController.text.trim(),
        attachmentName: attachmentFileNameController.text.trim(),
        attachment: attachmentFileController.text.trim(),
      ),
    );
    if (isClosed) return;
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

  // ── Update ───────────────────────────────────────────────────────────────

  Future<void> updateStudyRequest({required int requestId}) async {
    emit(state.copyWith(status: StudyStatus.createStudyRequestLoading));
    final result = await _updateStudyUseCase.call(
      params: UpdateStudyParams(
        requestId: requestId,
        data: CreateStudyParams(
          employeeId: int.tryParse(_sessionStorage.employeeId ?? '1') ?? 1,
          officeId: int.tryParse(officeIdController.text) ?? 0,
          requestType: _selectedStudyTypeCode,
          study: requiredStudyController.text.trim(),
          studyDestinationId: _selectedDestinationId ?? 0,
          studyStartDate: courseStartDateController.text.trim(),
          studyEndDate: courseEndDateController.text.trim(),
          note: noteController.text.trim(),
          reason: reasonController.text.trim(),
          comment: commentController.text.trim(),
          attachmentName: attachmentFileNameController.text.trim(),
          attachment: attachmentFileController.text.trim(),
        ),
      ),
    );
    if (isClosed) return;
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

  // ── Reset ────────────────────────────────────────────────────────────────

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
    commentController.clear();
    attachmentFileController.clear();
    attachmentFileNameController.clear();
  }

  void updateDuration() {
    final start = courseStartDateController.text;
    final end = courseEndDateController.text;
    if (start.isEmpty || end.isEmpty) {
      durationController.clear();
      return;
    }
    try {
      final startDate = DateTime.parse(start);
      final endDate = DateTime.parse(end);
      if (endDate.isBefore(startDate)) {
        durationController.text = S.current.error;
        return;
      }
      final diff = endDate.difference(startDate);
      final days = diff.inDays;
      final months = (days / 30).floor();
      final remDays = days % 30;

      String result = '';
      if (months > 0) {
        result = '$months ${months == 1 ? S.current.month : S.current.months}';
        if (remDays > 0) {
          result +=
              ' ${S.current.and} $remDays ${remDays == 1 ? S.current.day : S.current.days}';
        }
      } else {
        result = '$days ${days == 1 ? S.current.day : S.current.days}';
      }
      durationController.text = result;
    } catch (_) {
      durationController.clear();
    }
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
    commentController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
    return super.close();
  }
}
