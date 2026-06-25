import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/id_document/country.dart';
import 'package:shaoni/features/human_resources/domain/entity/id_document/id_renewal_request_type.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/id_document/get_countries_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/id_document/get_id_renewal_request_types_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/id_document/create_id_document_use_case.dart';
import 'package:shaoni/generated/l10n.dart';

part 'id_document_state.dart';

class IDDocumentCubit extends Cubit<IDDocumentState> {
  final GetCountriesUseCase _getCountriesUseCase;
  final GetIDRenewalRequestTypesUseCase _getIDRenewalRequestTypesUseCase;
  final CreateIDDocumentUseCase _createIDDocumentUseCase;
  final SessionStorage _sessionStorage;

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

  /// دولة الإصدار — display name (what user sees)
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
  List<Country> _countries = [];

  /// The integer ID of the currently selected country (sent in payload).
  int? _selectedCountryId;

  IDDocumentCubit(
    this._getCountriesUseCase,
    this._getIDRenewalRequestTypesUseCase,
    this._createIDDocumentUseCase,
    this._sessionStorage,
  ) : super(const IDDocumentState()) {
    _loadLookups();
  }

  // ── Document type items (hardcoded, navigated by code) ───────────────────

  /// Returns dropdown items whose VALUE is the document type CODE.
  /// The dispatcher widget reads this code to pick the correct sub-widget.
  List<DropdownMenuItem<String>> get documentTypeItems {
    return [
      DropdownMenuItem(
        value: 'national_id',
        child: Text(S.current.nationalId, style: const TextStyle(fontSize: 12)),
      ),
      DropdownMenuItem(
        value: 'residency',
        child:
            Text(S.current.residencyId, style: const TextStyle(fontSize: 12)),
      ),
      DropdownMenuItem(
        value: 'passport',
        child: Text(S.current.passport, style: const TextStyle(fontSize: 12)),
      ),
      DropdownMenuItem(
        value: 'family_card',
        child: Text(S.current.familyCard, style: const TextStyle(fontSize: 12)),
      ),
      DropdownMenuItem(
        value: 'driving_license',
        child: Text(S.current.drivingLicense,
            style: const TextStyle(fontSize: 12)),
      ),
    ];
  }

  // ── Lookups ──────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: IDDocumentStatus.lookupsLoading));
    await Future.wait([
      _fetchRequestTypes(),
      _fetchCountries(),
    ]);
    if (isClosed) return;
    emit(state.copyWith(status: IDDocumentStatus.lookupsLoaded));
  }

  Future<void> _fetchRequestTypes() async {
    final result =
        await _getIDRenewalRequestTypesUseCase.call(params: NoParams());
    if (isClosed) return;
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

  Future<void> _fetchCountries() async {
    final result = await _getCountriesUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: IDDocumentStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (countries) {
        _countries = countries;
        issuingCountryItems = countries
            .map((c) => DropdownMenuItem<String>(
                  value: _localizedName(c.nameAr, c.nameEn),
                  child: Text(
                    _localizedName(c.nameAr, c.nameEn),
                    style: const TextStyle(fontSize: 12),
                  ),
                ))
            .toList();
      },
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  /// Returns the code of the currently selected request type, or null if none.
  String? get _selectedRequestTypeCode {
    if (requestTypeController.text.isEmpty || _requestTypes.isEmpty) {
      return null;
    }
    final match = _requestTypes.where(
      (t) => _localizedName(t.nameAr, t.nameEn) == requestTypeController.text,
    );
    return match.isEmpty ? null : match.first.code;
  }

  /// True when selected request type is 'new' (إضافة وثيقة جديدة).
  bool get isAddNewMode => _selectedRequestTypeCode == 'new';

  /// True when selected request type is 'update' (تحديث الوثائق الثبوتية).
  bool get isUpdateMode => _selectedRequestTypeCode == 'update';

  /// Show the document TYPE dropdown for both 'new' and 'update'.
  bool get showDocumentData => isAddNewMode || isUpdateMode;

  /// Show full document data fields (country, dates, etc.) only for 'new' mode.
  bool get showDocumentFields => isAddNewMode;

  /// Resolve country ID from display name selected in dropdown.
  void onCountrySelected(String? displayName) {
    issuingCountryController.text = displayName ?? '';
    if (displayName == null || displayName.isEmpty || _countries.isEmpty) {
      _selectedCountryId = null;
    } else {
      final match = _countries.where(
        (c) => _localizedName(c.nameAr, c.nameEn) == displayName,
      );
      _selectedCountryId = match.isEmpty ? null : match.first.id;
    }
    notifyDropdownChanged();
  }

  void toggleTabaq(bool value) {
    tabaq = value;
    emit(state.copyWith(version: state.version + 1));
  }

  void toggleKafala(bool value) {
    kafala = value;
    if (!value) kafeelNameController.clear();
    emit(state.copyWith(version: state.version + 1));
  }

  void notifyDropdownChanged() {
    emit(state.copyWith(version: state.version + 1));
  }

  // ── Create ───────────────────────────────────────────────────────────────

  Future<void> createIDDocument() async {
    emit(state.copyWith(status: IDDocumentStatus.createLoading));
    final params = CreateIDDocumentParams(
      employeeId: int.tryParse(_sessionStorage.employeeId ?? '0') ?? 0,
      officeId: int.tryParse(officeIdController.text) ?? 0,
      date: DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
      requestTypes: _selectedRequestTypeCode ?? '',
      identificationType: documentTypeController.text,
      countryOfIssue: _selectedCountryId,
      identificationId: documentNumberController.text.trim(),
      issueNumber: issueNumberController.text.trim(),
      issuerDate: issueDateController.text.trim(),
      endDate: endDateController.text.trim(),
      apply: tabaq,
      kafala: kafala,
      kafeelName: kafala ? kafeelNameController.text.trim() : null,
      passportNumber: passportNumberController.text.trim(),
      passportAddress: passportAddressController.text.trim(),
      familyCardNumber: familyCardNumberController.text.trim(),
      drivingLicenseNumber: drivingLicenseNumberController.text.trim(),
      attachmentIds: [],
    );
    final result = await _createIDDocumentUseCase.call(params: params);
    if (isClosed) return;
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
    _selectedCountryId = null;
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
