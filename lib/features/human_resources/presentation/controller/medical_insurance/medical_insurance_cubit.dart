import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/core/local_storage/cache_keys.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/medical_insurance/medical_insurance_class.dart';
import 'package:shaoni/features/human_resources/domain/entity/medical_insurance/employee_relative.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/medical_insurance/get_medical_insurance_classes_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/medical_insurance/get_employee_relatives_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/medical_insurance/create_medical_insurance_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/medical_insurance/update_medical_insurance_use_case.dart';
import 'package:shaoni/generated/l10n.dart';

part 'medical_insurance_state.dart';

class MedicalInsuranceCubit extends Cubit<MedicalInsuranceState> {
  final GetMedicalInsuranceClassesUseCase _getMedicalInsuranceClassesUseCase;
  final GetEmployeeRelativesUseCase _getEmployeeRelativesUseCase;
  final CreateMedicalInsuranceUseCase _createMedicalInsuranceUseCase;
  final UpdateMedicalInsuranceUseCase _updateMedicalInsuranceUseCase;

  /// Form key
  final requestFormKey = GlobalKey<FormState>();

  /// Applicant & date controllers
  final officeIdController = TextEditingController();
  final todayDateController = TextEditingController();
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();

  /// Request-specific controllers
  final insuranceClassController = TextEditingController();
  final reasonForUpgradeController = TextEditingController();
  final noteController = TextEditingController();

  /// Attachment controllers
  final attachmentFileController = TextEditingController();
  final attachmentFileNameController = TextEditingController();

  /// Dropdown items for the UI
  List<DropdownMenuItem<String>> insuranceClassItems = [];

  /// Raw lists for ID resolution
  List<MedicalInsuranceClass> _insuranceClasses = [];
  List<EmployeeRelative> _employeeRelatives = [];

  /// All relatives for multi-select display
  List<EmployeeRelative> get employeeRelatives => _employeeRelatives;

  MedicalInsuranceCubit(
    this._getMedicalInsuranceClassesUseCase,
    this._getEmployeeRelativesUseCase,
    this._createMedicalInsuranceUseCase,
    this._updateMedicalInsuranceUseCase,
  ) : super(const MedicalInsuranceState()) {
    _loadLookups();
  }

  // ── Lookups ──────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: MedicalInsuranceStatus.lookupsLoading));
    await _fetchInsuranceClasses();
    // Load relatives for the current employee
    final empIdStr = CacheHelper.getString(key: CacheKeys.employeeId) ?? '0';
    final empId = int.tryParse(empIdStr) ?? 0;
    if (empId > 0) {
      await _fetchEmployeeRelatives(employeeId: empId);
    }
    emit(state.copyWith(status: MedicalInsuranceStatus.lookupsLoaded));
  }

  Future<void> _fetchInsuranceClasses() async {
    final result =
        await _getMedicalInsuranceClassesUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: MedicalInsuranceStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (classes) {
        _insuranceClasses = classes;
        insuranceClassItems = classes
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

  Future<void> _fetchEmployeeRelatives({required int employeeId}) async {
    final result = await _getEmployeeRelativesUseCase.call(
      params: GetEmployeeRelativesParams(employeeId: employeeId),
    );
    result.fold(
      (failure) {/* non-fatal, relatives stay empty */},
      (relatives) {
        _employeeRelatives = relatives;
      },
    );
  }

  // ── Include family member toggle ─────────────────────────────────────────

  void setIncludeFamilyMember(bool value) {
    emit(state.copyWith(
      includeFamilyMember: value,
      selectedRelativeIds: value ? state.selectedRelativeIds : {},
    ));
  }

  // ── Relative multi-select ────────────────────────────────────────────────

  void toggleRelative(int relativeId) {
    final updated = Set<int>.from(state.selectedRelativeIds);
    if (updated.contains(relativeId)) {
      updated.remove(relativeId);
    } else {
      updated.add(relativeId);
    }
    emit(state.copyWith(selectedRelativeIds: updated));
  }

  bool isRelativeSelected(int relativeId) =>
      state.selectedRelativeIds.contains(relativeId);

  // ── Helpers ──────────────────────────────────────────────────────────────

  int? get _selectedInsuranceClassId {
    if (insuranceClassController.text.isEmpty) return null;
    final match = _insuranceClasses.where(
      (c) =>
          _localizedName(c.nameAr, c.nameEn) == insuranceClassController.text,
    );
    return match.isEmpty ? null : match.first.id;
  }

  CreateMedicalInsuranceParams _buildParams() {
    final empId =
        int.tryParse(CacheHelper.getString(key: CacheKeys.employeeId) ?? '0') ??
            0;
    return CreateMedicalInsuranceParams(
      employeeId: empId,
      officeId: int.tryParse(officeIdController.text) ?? 0,
      newInsuranceClass: _selectedInsuranceClassId ?? 0,
      includeFamilyMember: state.includeFamilyMember,
      applicantDependantsIds: state.selectedRelativeIds.toList(),
      reasonForUpgrade: reasonForUpgradeController.text.trim(),
      note: noteController.text.trim(),
      date: DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
      attachmentIds: [],
    );
  }

  // ── Create ───────────────────────────────────────────────────────────────

  Future<void> createMedicalInsurance() async {
    emit(state.copyWith(status: MedicalInsuranceStatus.createLoading));
    final result = await _createMedicalInsuranceUseCase.call(
      params: _buildParams(),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: MedicalInsuranceStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: MedicalInsuranceStatus.createLoaded,
        requestNumber: response.requestId.toString(),
      )),
    );
  }

  // ── Update ───────────────────────────────────────────────────────────────

  Future<void> updateMedicalInsurance({required int requestId}) async {
    emit(state.copyWith(status: MedicalInsuranceStatus.createLoading));
    final result = await _updateMedicalInsuranceUseCase.call(
      params: UpdateMedicalInsuranceParams(
        requestId: requestId,
        data: _buildParams(),
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        status: MedicalInsuranceStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: MedicalInsuranceStatus.createLoaded,
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
    insuranceClassController.clear();
    reasonForUpgradeController.clear();
    noteController.clear();
    attachmentFileController.clear();
    attachmentFileNameController.clear();
    emit(state.copyWith(
      includeFamilyMember: false,
      selectedRelativeIds: {},
    ));
  }

  String _localizedName(String ar, String en) {
    return S.current.localeee == 'en'
        ? (en.isEmpty ? ar : en)
        : (ar.isEmpty ? en : ar);
  }

  String localizedRelativeName(EmployeeRelative r) {
    return S.current.localeee == 'en'
        ? (r.fullName.isEmpty ? r.name : r.fullName)
        : (r.name.isEmpty ? r.fullName : r.name);
  }

  String localizedRelationName(EmployeeRelative r) {
    return S.current.localeee == 'en'
        ? (r.relationEn.isEmpty ? r.relationAr : r.relationEn)
        : (r.relationAr.isEmpty ? r.relationEn : r.relationAr);
  }

  @override
  Future<void> close() {
    officeIdController.dispose();
    todayDateController.dispose();
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    insuranceClassController.dispose();
    reasonForUpgradeController.dispose();
    noteController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
    return super.close();
  }
}
