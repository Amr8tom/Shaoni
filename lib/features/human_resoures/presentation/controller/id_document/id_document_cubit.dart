import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/core/local_storage/cache_keys.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/id_document/department.dart';
import 'package:shaoni/features/human_resoures/domain/entity/id_document/id_renewal_request_type.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/id_document/get_departments_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/id_document/get_id_renewal_request_types_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/id_document/create_id_document_use_case.dart';
import 'package:shaoni/generated/l10n.dart';

part 'id_document_state.dart';

class IDDocumentCubit extends Cubit<IDDocumentState> {
  final GetDepartmentsUseCase _getDepartmentsUseCase;
  final GetIDRenewalRequestTypesUseCase _getIDRenewalRequestTypesUseCase;
  final CreateIDDocumentUseCase _createIDDocumentUseCase;

  /// Form key
  final requestFormKey = GlobalKey<FormState>();

  /// Applicant & date controllers
  final officeIdController = TextEditingController();
  final todayDateController = TextEditingController();
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();

  /// Attachment controllers
  final attachmentFileController = TextEditingController();
  final attachmentFileNameController = TextEditingController();

  // ── Request section controllers ──────────────────────────────────────────

  /// نوع الطلب (request type: إضافة وثيقة جديدة / تحديث الوثائق الثبوتية)
  final requestTypeController = TextEditingController();

  /// النوع — stores the document type CODE (national_id / residency / passport / family_card / driving_license)
  final documentTypeController = TextEditingController();

  // ── Document data section controllers ────────────────────────────────────

  /// دولة الإصدار
  final issuingCountryController = TextEditingController();

  /// رقم المستند
  final documentNumberController = TextEditingController();

  /// رقم الإصدار
  final issueNumberController = TextEditingController();

  /// تاريخ الإصدار م
  final issueDateController = TextEditingController();

  /// النهاية م
  final endDateController = TextEditingController();

  /// اسم الكفيل (shown only when kafala == true)
  final kafeelNameController = TextEditingController();

  // ── Type-specific extras ─────────────────────────────────────────────────

  /// Passport: رقم جواز السفر
  final passportNumberController = TextEditingController();

  /// Passport: عنوان جواز السفر
  final passportAddressController = TextEditingController();

  /// Family Card: رقم بطاقة عائلية
  final familyCardNumberController = TextEditingController();

  /// Driving License: رقم رخصة سياقة
  final drivingLicenseNumberController = TextEditingController();

  /// طبق checkbox
  bool tabaq = false;

  /// هل علي كفالة checkbox
  bool kafala = false;

  // ── Dropdown items ───────────────────────────────────────────────────────

  List<DropdownMenuItem<String>> requestTypeItems = [];
  List<DropdownMenuItem<String>> issuingCountryItems = [];

  // ── Raw lookup lists ─────────────────────────────────────────────────────

  List<IDRenewalRequestType> _requestTypes = [];
  List<Department> _departments = [];

  IDDocumentCubit(
    this._getDepartmentsUseCase,
    this._getIDRenewalRequestTypesUseCase,
    this._createIDDocumentUseCase,
  ) : super(const IDDocumentState()) {
    _loadLookups();
  }

  // ── Document type items (hardcoded, navigated by code) ───────────────────

  /// Returns dropdown items whose VALUE is the document type CODE.
  /// The dispatcher widget reads this code to pick the correct sub-widget.
  List<DropdownMenuItem<String>> get documentTypeItems {
    final isEn = S.current.localeee == 'en';
    return [
      DropdownMenuItem(
        value: 'national_id',
        child: Text(isEn ? 'National ID' : 'رقم الهوية',
            style: const TextStyle(fontSize: 12)),
      ),
      DropdownMenuItem(
        value: 'residency',
        child: Text(isEn ? 'Residency ID' : 'رقم الإقامة',
            style: const TextStyle(fontSize: 12)),
      ),
      DropdownMenuItem(
        value: 'passport',
        child: Text(isEn ? 'Passport' : 'جواز سفر',
            style: const TextStyle(fontSize: 12)),
      ),
      DropdownMenuItem(
        value: 'family_card',
        child: Text(isEn ? 'Family Card' : 'بطاقة عائلية',
            style: const TextStyle(fontSize: 12)),
      ),
      DropdownMenuItem(
        value: 'driving_license',
        child: Text(isEn ? 'Driving License' : 'رخصة قيادة',
            style: const TextStyle(fontSize: 12)),
      ),
    ];
  }

  // ── Lookups ──────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: IDDocumentStatus.lookupsLoading));
    await Future.wait([
      _fetchRequestTypes(),
      _fetchDepartments(),
    ]);
    emit(state.copyWith(status: IDDocumentStatus.lookupsLoaded));
  }

  Future<void> _fetchRequestTypes() async {
    final result =
        await _getIDRenewalRequestTypesUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: IDDocumentStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (types) {
        _requestTypes = types;
        requestTypeItems = types
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

  Future<void> _fetchDepartments() async {
    final result = await _getDepartmentsUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: IDDocumentStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (departments) {
        _departments = departments;
        issuingCountryItems = departments
            .map((d) => DropdownMenuItem<String>(
                  value: _localizedName(d.nameAr, d.nameEn),
                  child: Text(
                    _localizedName(d.nameAr, d.nameEn),
                    style: const TextStyle(fontSize: 12),
                  ),
                ))
            .toList();
      },
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  /// True when the selected request type has code == 'new' (إضافة وثيقة جديدة).
  /// False for 'update' (تحديث الوثائق الثبوتية) or when nothing is selected.
  bool get isAddNewMode {
    if (requestTypeController.text.isEmpty || _requestTypes.isEmpty) {
      return false;
    }
    final match = _requestTypes.where(
      (t) => _localizedName(t.nameAr, t.nameEn) == requestTypeController.text,
    );
    if (match.isEmpty) return false;
    return match.first.code == 'new';
  }

  int? get _selectedRequestTypeId {
    if (requestTypeController.text.isEmpty) return null;
    final match = _requestTypes.where(
      (t) => _localizedName(t.nameAr, t.nameEn) == requestTypeController.text,
    );
    return match.isEmpty ? null : match.first.id;
  }

  void toggleTabaq(bool value) {
    tabaq = value;
    emit(state.copyWith(status: state.status));
  }

  void toggleKafala(bool value) {
    kafala = value;
    if (!value) kafeelNameController.clear();
    emit(state.copyWith(status: state.status));
  }

  void notifyDropdownChanged() {
    emit(state.copyWith(status: state.status));
  }

  // ── Create (stub — filled when backend URL is confirmed) ─────────────────

  Future<void> createIDDocument() async {
    emit(state.copyWith(status: IDDocumentStatus.createLoading));
    // TODO: fill params when backend URL is confirmed by backend developer
    final params = CreateIDDocumentParams(
      employee: int.tryParse(
              CacheHelper.getString(key: CacheKeys.employeeId) ?? '0') ??
          0,
      officeId: int.tryParse(officeIdController.text) ?? 0,
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      requestTypeId: _selectedRequestTypeId ?? 0,
      documentTypeCode: documentTypeController.text,
      issuingCountry: issuingCountryController.text.trim(),
      documentNumber: documentNumberController.text.trim(),
      issueNumber: issueNumberController.text.trim(),
      issueDate: issueDateController.text.trim(),
      endDate: endDateController.text.trim(),
      tabaq: tabaq,
      kafala: kafala,
      kafeelName: kafala ? kafeelNameController.text.trim() : null,
      passportNumber: passportNumberController.text.trim(),
      passportAddress: passportAddressController.text.trim(),
      familyCardNumber: familyCardNumberController.text.trim(),
      drivingLicenseNumber: drivingLicenseNumberController.text.trim(),
      attachmentIds: [],
    );
    final result = await _createIDDocumentUseCase.call(params: params);
    result.fold(
      (failure) => emit(state.copyWith(
        status: IDDocumentStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: IDDocumentStatus.createLoaded,
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
    requestTypeController.clear();
    documentTypeController.clear();
    issuingCountryController.clear();
    documentNumberController.clear();
    issueNumberController.clear();
    issueDateController.clear();
    endDateController.clear();
    kafeelNameController.clear();
    passportNumberController.clear();
    passportAddressController.clear();
    familyCardNumberController.clear();
    drivingLicenseNumberController.clear();
    attachmentFileController.clear();
    attachmentFileNameController.clear();
    tabaq = false;
    kafala = false;
    emit(state.copyWith(status: IDDocumentStatus.lookupsLoaded));
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
    requestTypeController.dispose();
    documentTypeController.dispose();
    issuingCountryController.dispose();
    documentNumberController.dispose();
    issueNumberController.dispose();
    issueDateController.dispose();
    endDateController.dispose();
    kafeelNameController.dispose();
    passportNumberController.dispose();
    passportAddressController.dispose();
    familyCardNumberController.dispose();
    drivingLicenseNumberController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
    return super.close();
  }
}
