import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/create_visa_response.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_employee.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_language.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_type.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/create_visa_request_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/get_active_languages_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/get_visa_employees_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/get_visa_types_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/update_visa_request_use_case.dart';
import 'package:shaoni/generated/l10n.dart';

part 'visa_request_state.dart';

class VisaRequestCubit extends Cubit<VisaRequestState> {
  final GetVisaTypesUseCase _getVisaTypesUseCase;
  final GetActiveLanguagesUseCase _getActiveLanguagesUseCase;
  final GetVisaEmployeesUseCase _getVisaEmployeesUseCase;
  final CreateVisaRequestUseCase _createVisaRequestUseCase;
  final UpdateVisaRequestUseCase _updateVisaRequestUseCase;
  final SessionStorage _sessionStorage;

  final requestFormKey = GlobalKey<FormState>();

  final officeIdController = TextEditingController();
  final directionController = TextEditingController();
  final reasonController = TextEditingController();
  final noteController = TextEditingController();
  final searchController = TextEditingController();

  /// Maps each visa type backend code to the `isSaudi` flag used by the
  /// employees lookup (GET /Integration/sync-employees?isSaudi=...).
  static const Map<String, bool> _isSaudiByVisaType = {
    'exit_return': true,
    'foreign_country': false,
    'kingdom_entry': true,
  };

  VisaRequestCubit(
    this._getVisaTypesUseCase,
    this._getActiveLanguagesUseCase,
    this._getVisaEmployeesUseCase,
    this._createVisaRequestUseCase,
    this._updateVisaRequestUseCase,
    this._sessionStorage,
  ) : super(const VisaRequestState()) {
    _loadLookups();
  }

  // ── Lookups ────────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: VisaRequestStatus.lookupsLoading));

    final results = await Future.wait([
      _getVisaTypesUseCase.call(params: NoParams()),
      _getActiveLanguagesUseCase.call(params: NoParams()),
    ]);

    if (isClosed) return;

    final typesResult = results[0];
    final languagesResult = results[1];

    List<VisaType> visaTypes = [];
    List<VisaLanguage> languages = [];
    String? error;

    typesResult.fold(
      (f) => error = f.message,
      (data) => visaTypes = data as List<VisaType>,
    );
    languagesResult.fold(
      (f) => error ??= f.message,
      (data) => languages = data as List<VisaLanguage>,
    );

    emit(state.copyWith(
      status: error != null
          ? VisaRequestStatus.lookupsError
          : VisaRequestStatus.lookupsLoaded,
      visaTypes: visaTypes,
      languages: languages,
      errorMessage: error,
    ));
  }

  // ── Visa type / employees ────────────────────────────────────────────────

  void selectVisaType(VisaType type) {
    emit(state.copyWith(
      selectedVisaTypeId: type.id,
      selectedVisaTypeCode: type.code,
      selectedVisaTypeName: _localizedName(type.nameAr, type.nameEn),
      // selecting a new visa type resets the employee selection
      lines: const [],
    ));
    final isSaudi = _isSaudiByVisaType[type.code] ?? true;
    _loadEmployees(isSaudi);
  }

  Future<void> _loadEmployees(bool isSaudi) async {
    emit(state.copyWith(employeesLoading: true));
    final result = await _getVisaEmployeesUseCase.call(
      params: GetVisaEmployeesParams(isSaudi: isSaudi),
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        employeesLoading: false,
        status: VisaRequestStatus.createError,
        errorMessage: failure.message,
      )),
      (employees) => emit(state.copyWith(
        employeesLoading: false,
        employees: employees,
      )),
    );
  }

  void selectLanguage(VisaLanguage language) {
    emit(state.copyWith(
      selectedLangId: language.id,
      selectedLangName: language.name,
    ));
  }

  // ── Dates ──────────────────────────────────────────────────────────────────

  void setDateFrom(DateTime date) => emit(state.copyWith(dateFrom: date));

  void setDateTo(DateTime date) => emit(state.copyWith(dateTo: date));

  // ── Employee selection ───────────────────────────────────────────────────

  void setSearchQuery(String query) => emit(state.copyWith(searchQuery: query));

  void toggleEmployee(VisaEmployee employee) {
    final lines = List<VisaLineState>.from(state.lines);
    final index = lines.indexWhere((l) => l.employee.id == employee.id);
    if (index >= 0) {
      lines.removeAt(index);
    } else {
      lines.add(VisaLineState(
        employee: employee,
        dateFrom: state.dateFrom,
        dateTo: state.dateTo,
      ));
    }
    emit(state.copyWith(lines: lines));
  }

  void setLineDateFrom(int employeeId, DateTime date) {
    final lines = state.lines
        .map(
            (l) => l.employee.id == employeeId ? l.copyWith(dateFrom: date) : l)
        .toList();
    emit(state.copyWith(lines: lines));
  }

  void setLineDateTo(int employeeId, DateTime date) {
    final lines = state.lines
        .map((l) => l.employee.id == employeeId ? l.copyWith(dateTo: date) : l)
        .toList();
    emit(state.copyWith(lines: lines));
  }

  // ── Attachment ─────────────────────────────────────────────────────────────

  void setAttachment(String? name, String? base64) {
    emit(state.copyWith(
      attachmentName: name ?? '',
      attachmentBase64: base64 ?? '',
    ));
  }

  // ── Create ───────────────────────────────────────────────────────────────

  CreateVisaRequestParams _buildParams() {
    final empId = int.tryParse(_sessionStorage.employeeId ?? '0') ?? 0;
    final today = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());

    final lineParams = state.lines
        .map((l) => VisaRequestLineParams(
              employeeId: l.employee.id,
              dateFrom: _apiDate(l.dateFrom ?? state.dateFrom),
              dateTo: _apiDate(l.dateTo ?? state.dateTo),
            ))
        .toList();

    return CreateVisaRequestParams(
      responsibleEmployee: empId,
      officeId: int.tryParse(officeIdController.text) ?? 0,
      langId: state.selectedLangId ?? 0,
      date: today,
      dateFrom: _apiDate(state.dateFrom),
      dateTo: _apiDate(state.dateTo),
      direction: directionController.text.trim(),
      reason: reasonController.text.trim(),
      note: noteController.text.trim(),
      visaType: state.selectedVisaTypeCode,
      attachment: state.attachmentBase64,
      visaRequestLineIds: lineParams,
    );
  }

  Future<void> createVisaRequest() async {
    emit(state.copyWith(status: VisaRequestStatus.createLoading));
    final result = await _createVisaRequestUseCase.call(params: _buildParams());
    if (isClosed) return;
    _handleSubmitResult(result);
  }

  // ── Update ───────────────────────────────────────────────────────────────

  Future<void> updateVisaRequest({required int requestId}) async {
    emit(state.copyWith(status: VisaRequestStatus.createLoading));
    final result = await _updateVisaRequestUseCase.call(
      params: UpdateVisaRequestParams(
        requestId: requestId,
        data: _buildParams(),
      ),
    );
    if (isClosed) return;
    _handleSubmitResult(result);
  }

  void _handleSubmitResult(Either<Failure, CreateVisaResponse> result) {
    result.fold(
      (failure) => emit(state.copyWith(
        status: VisaRequestStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: VisaRequestStatus.createLoaded,
        requestNumber: response.visaRequestName.isNotEmpty
            ? response.visaRequestName
            : (response.visaRequestId?.toString() ?? ''),
      )),
    );
  }

  // ── Reset ────────────────────────────────────────────────────────────────

  void resetForm() {
    officeIdController.clear();
    directionController.clear();
    reasonController.clear();
    noteController.clear();
    searchController.clear();
    emit(state.copyWith(
      selectedVisaTypeId: null,
      selectedVisaTypeCode: '',
      selectedVisaTypeName: '',
      selectedLangId: null,
      selectedLangName: '',
      dateFrom: null,
      dateTo: null,
      attachmentName: '',
      attachmentBase64: '',
      lines: const [],
      employees: const [],
      searchQuery: '',
    ));
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  String _apiDate(DateTime? date) =>
      date == null ? '' : DateFormat('yyyy-MM-dd', 'en').format(date);

  String _localizedName(String ar, String en) {
    return S.current.localeee == 'en'
        ? (en.isEmpty ? ar : en)
        : (ar.isEmpty ? en : ar);
  }

  @override
  Future<void> close() {
    officeIdController.dispose();
    directionController.dispose();
    reasonController.dispose();
    noteController.dispose();
    searchController.dispose();
    return super.close();
  }
}
