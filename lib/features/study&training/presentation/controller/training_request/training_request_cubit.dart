import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/study&training/domain/entities/training_request/course.dart';
import 'package:shaoni/features/study&training/domain/use_cases/training_request/get_courses_use_case.dart';
import 'package:shaoni/features/study&training/domain/use_cases/training_request/get_training_for_edit_use_case.dart';
import 'package:shaoni/features/study&training/domain/use_cases/training_request/create_training_request_use_case.dart';
import 'package:shaoni/features/study&training/domain/use_cases/training_request/update_training_request_use_case.dart';

part 'training_request_state.dart';

class TrainingRequestCubit extends Cubit<TrainingRequestState> {
  final GetCoursesUseCase _getCoursesUseCase;
  final CreateTrainingRequestUseCase _createTrainingRequestUseCase;
  final UpdateTrainingRequestUseCase _updateTrainingRequestUseCase;
  final GetTrainingForEditUseCase _getTrainingForEditUseCase;
  final SessionStorage _sessionStorage;

  /// Form key
  final requestFormKey = GlobalKey<FormState>();

  /// Applicant & date controllers
  final officeIdController = TextEditingController();
  final todayDateController = TextEditingController();
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();

  /// Request-specific controllers
  final courseController = TextEditingController();
  final noteController = TextEditingController();

  /// Attachment controllers
  final attachmentFileController = TextEditingController();
  final attachmentFileNameController = TextEditingController();

  /// Dropdown items
  List<DropdownMenuItem<String>> courseItems = [];

  /// Raw courses list for ID resolution
  List<Course> _courses = [];

  /// Date of the request being edited; blank when creating (uses today).
  String _editDate = '';

  TrainingRequestCubit(
    this._getCoursesUseCase,
    this._createTrainingRequestUseCase,
    this._updateTrainingRequestUseCase,
    this._getTrainingForEditUseCase,
    this._sessionStorage,
  ) : super(const TrainingRequestState());

  /// Loads courses, then prefills from the existing request when editing.
  Future<void> init({int? requestId}) async {
    await _loadCourses();
    if (requestId != null) await _prefill(requestId);
  }

  /// Populates the form from an existing training request so an update does
  /// not overwrite untouched fields with blanks.
  Future<void> _prefill(int requestId) async {
    final result = await _getTrainingForEditUseCase.call(
      params: GetTrainingForEditParams(requestId: requestId),
    );
    if (isClosed) return;

    result.fold((_) {}, (data) {
      courseController.text = data.courseName;
      noteController.text = data.note;
      _editDate = data.date;
      if (data.officeId != null) {
        officeIdController.text = data.officeId.toString();
      }
      // Already normalised: the API's "false" sentinel becomes ''.
      attachmentFileController.text = data.attachment;

      final match = _courses.where((c) => c.id == data.courseId);
      emit(state.copyWith(
        status: TrainingRequestStatus.lookupsLoaded,
        selectedCourse: match.isEmpty ? null : match.first,
      ));
    });
  }

  // ── Lookups ──────────────────────────────────────────────────────────────

  Future<void> _loadCourses() async {
    emit(state.copyWith(status: TrainingRequestStatus.lookupsLoading));
    final result = await _getCoursesUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: TrainingRequestStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (courses) {
        _courses = courses;
        courseItems = courses
            .map((c) => DropdownMenuItem<String>(
                  value: c.name,
                  child: Text(c.name, style: const TextStyle(fontSize: 12)),
                ))
            .toList();
        emit(state.copyWith(status: TrainingRequestStatus.lookupsLoaded));
      },
    );
  }

  // ── Course selection ─────────────────────────────────────────────────────

  void selectCourse(String? courseName) {
    if (courseName == null) {
      emit(state.copyWith(clearSelectedCourse: true));
      return;
    }
    final match = _courses.where((c) => c.name == courseName);
    if (match.isNotEmpty) {
      emit(state.copyWith(selectedCourse: match.first));
    }
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  int? get _selectedCourseId {
    if (courseController.text.isEmpty) return null;
    final match = _courses.where((c) => c.name == courseController.text);
    return match.isEmpty ? null : match.first.id;
  }

  CreateTrainingRequestParams _buildParams() {
    final empId = int.tryParse(_sessionStorage.employeeId ?? '0') ?? 0;
    return CreateTrainingRequestParams(
      employeeId: empId,
      officeId: int.tryParse(officeIdController.text) ?? 0,
      // Keep the original request date when editing; new requests use today.
      date: _editDate.isNotEmpty
          ? _editDate
          : DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
      courseId: _selectedCourseId ?? 0,
      note: noteController.text.trim(),
      attachmentIds: [],
    );
  }

  // ── Create ───────────────────────────────────────────────────────────────

  Future<void> createTrainingRequest() async {
    emit(state.copyWith(status: TrainingRequestStatus.createLoading));
    final result =
        await _createTrainingRequestUseCase.call(params: _buildParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: TrainingRequestStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: TrainingRequestStatus.createLoaded,
        requestNumber: response.trainingRequestName ??
            response.trainingRequestId?.toString() ??
            '',
      )),
    );
  }

  // ── Update ───────────────────────────────────────────────────────────────

  Future<void> updateTrainingRequest({required int requestId}) async {
    emit(state.copyWith(status: TrainingRequestStatus.createLoading));
    final result = await _updateTrainingRequestUseCase.call(
      params: UpdateTrainingRequestParams(
        requestId: requestId,
        data: _buildParams(),
        attachment: attachmentFileController.text,
      ),
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: TrainingRequestStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: TrainingRequestStatus.createLoaded,
        requestNumber: response.trainingRequestName ?? '',
      )),
    );
  }

  // ── Reset ────────────────────────────────────────────────────────────────

  void resetForm() {
    officeIdController.clear();
    todayDateController.clear();
    applicantNameController.clear();
    organizationalUnitController.clear();
    courseController.clear();
    noteController.clear();
    attachmentFileController.clear();
    attachmentFileNameController.clear();
    emit(state.copyWith(clearSelectedCourse: true));
  }

  @override
  Future<void> close() {
    officeIdController.dispose();
    todayDateController.dispose();
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    courseController.dispose();
    noteController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
    return super.close();
  }
}
