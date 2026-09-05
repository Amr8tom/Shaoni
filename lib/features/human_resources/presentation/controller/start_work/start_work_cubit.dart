import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/start_work/employee.dart';
import 'package:shaoni/features/human_resources/domain/entity/start_work/start_work_type.dart';
import 'package:shaoni/features/human_resources/domain/entity/start_work/start_work_option.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/create_start_work_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/get_employees_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/get_employee_contracts_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/get_task_management_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/get_employee_leave_types_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/get_start_work_types_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/update_start_work_use_case.dart';
import 'package:shaoni/generated/l10n.dart';

part 'start_work_state.dart';

class StartWorkCubit extends Cubit<StartWorkState> {
  final GetStartWorkTypesUseCase _getStartWorkTypesUseCase;
  final GetEmployeesUseCase _getEmployeesUseCase;
  final GetEmployeeContractsUseCase _getEmployeeContractsUseCase;
  final GetTaskManagementUseCase _getTaskManagementUseCase;
  final GetEmployeeLeaveTypesUseCase _getEmployeeLeaveTypesUseCase;
  final CreateStartWorkUseCase _createStartWorkUseCase;
  final UpdateStartWorkUseCase _updateStartWorkUseCase;
  final SessionStorage _sessionStorage;

  /// Form key
  final requestFormKey = GlobalKey<FormState>();

  /// ── Applicant controllers ────────────────────────────────────────────────
  final applicantNameController = TextEditingController();
  final organizationalUnitController = TextEditingController();
  final officeIdController = TextEditingController();

  /// ── Request-specific controllers ────────────────────────────────────────
  final startWorkTypeController = TextEditingController();
  final employeeController = TextEditingController();
  final startDateController = TextEditingController();
  final startHijriController = TextEditingController();
  final noteController = TextEditingController();

  /// ── Conditional field controllers (one is used per selected type) ─────────
  final contractController = TextEditingController(); // hr_contract_id
  final taskManagementController =
      TextEditingController(); // task_management_id
  final leaveTypeController = TextEditingController(); // holiday_status_id
  final employeeTransferController = TextEditingController();
  final jobTitleModificationController = TextEditingController();
  final endLoanPeriodController =
      TextEditingController(); // gregorian yyyy-MM-dd
  final endLoanHijriController = TextEditingController();
  final extendWorkingPeriodController = TextEditingController();

  /// ── Attachment controllers ───────────────────────────────────────────────
  final attachmentFileController = TextEditingController();
  final attachmentFileNameController = TextEditingController();

  /// Dropdown items for the UI
  List<DropdownMenuItem<String>> startWorkTypeItems = [];
  List<DropdownMenuItem<String>> employeeItems = [];
  List<DropdownMenuItem<String>> contractItems = [];
  List<DropdownMenuItem<String>> taskManagementItems = [];
  List<DropdownMenuItem<String>> leaveTypeItems = [];

  /// Raw lists for ID resolution
  List<StartWorkType> _startWorkTypes = [];
  List<Employee> _employees = [];

  StartWorkCubit(
    this._getStartWorkTypesUseCase,
    this._getEmployeesUseCase,
    this._getEmployeeContractsUseCase,
    this._getTaskManagementUseCase,
    this._getEmployeeLeaveTypesUseCase,
    this._createStartWorkUseCase,
    this._updateStartWorkUseCase,
    this._sessionStorage,
  ) : super(const StartWorkState()) {
    _loadLookups();
  }

  /// ── Lookups ──────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: StartWorkStatus.lookupsLoading));
    await Future.wait([_fetchStartWorkTypes(), _fetchEmployees()]);
    if (isClosed) return;
    emit(state.copyWith(status: StartWorkStatus.lookupsLoaded));
  }

  Future<void> _fetchStartWorkTypes() async {
    final result = await _getStartWorkTypesUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: StartWorkStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (types) {
        _startWorkTypes = types;
        startWorkTypeItems = types
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

  Future<void> _fetchEmployees() async {
    final result = await _getEmployeesUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: StartWorkStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (employees) {
        _employees = employees;
        employeeItems = employees
            .map((e) => DropdownMenuItem<String>(
                  value: e.quadName,
                  child: Text(
                    e.quadName,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList();
      },
    );
  }

  /// ── Selection handlers (emit so the conditional field rebuilds) ───────────

  void selectType(String value) {
    startWorkTypeController.text = value;
    final kind = activeFieldKind;

    // Load the lookup backing the newly selected field, if it's a dropdown.
    if (kind == StartWorkFieldKind.contract) {
      _loadContracts();
    } else if (kind == StartWorkFieldKind.taskManagement) {
      _loadTaskManagement();
    } else if (kind == StartWorkFieldKind.leaveType) {
      _loadLeaveTypes();
    }

    emit(state.copyWith(selectedTypeId: _selectedType?.id ?? 0));
  }

  void selectEmployee(String value) {
    employeeController.text = value;
    // Employee-filtered selections are no longer valid for the new employee.
    contractController.clear();
    leaveTypeController.clear();

    final kind = activeFieldKind;
    if (kind == StartWorkFieldKind.contract) {
      _loadContracts();
    } else if (kind == StartWorkFieldKind.leaveType) {
      _loadLeaveTypes();
    }

    emit(state.copyWith(selectedEmployeeId: _selectedEmployeeId ?? 0));
  }

  /// ── Conditional lookups ──────────────────────────────────────────────────

  Future<void> _loadContracts() async {
    final empId = _selectedEmployeeId;
    if (empId == null) return;
    emit(state.copyWith(conditionalLoading: true));
    final result = await _getEmployeeContractsUseCase.call(
      params: GetEmployeeContractsParams(employeeId: empId),
    );
    if (isClosed) return;
    result.fold(
      (_) => emit(state.copyWith(conditionalLoading: false)),
      (list) {
        contractItems = _optionItems(list);
        emit(state.copyWith(
          conditionalLoading: false,
          conditionalVersion: state.conditionalVersion + 1,
        ));
      },
    );
  }

  Future<void> _loadTaskManagement() async {
    emit(state.copyWith(conditionalLoading: true));
    final result = await _getTaskManagementUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (_) => emit(state.copyWith(conditionalLoading: false)),
      (list) {
        taskManagementItems = _optionItems(list);
        emit(state.copyWith(
          conditionalLoading: false,
          conditionalVersion: state.conditionalVersion + 1,
        ));
      },
    );
  }

  Future<void> _loadLeaveTypes() async {
    final empId = _selectedEmployeeId;
    if (empId == null) return;
    emit(state.copyWith(conditionalLoading: true));
    final result = await _getEmployeeLeaveTypesUseCase.call(
      params: GetEmployeeLeaveTypesParams(employeeId: empId),
    );
    if (isClosed) return;
    result.fold(
      (_) => emit(state.copyWith(conditionalLoading: false)),
      (list) {
        leaveTypeItems = list
            .map((e) => DropdownMenuItem<String>(
                  value: e.id.toString(),
                  child: Text(
                    _localizedName(e.nameAr, e.nameEn),
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList();
        emit(state.copyWith(
          conditionalLoading: false,
          conditionalVersion: state.conditionalVersion + 1,
        ));
      },
    );
  }

  List<DropdownMenuItem<String>> _optionItems(List<StartWorkOption> options) {
    return options
        .map((o) => DropdownMenuItem<String>(
              value: o.id.toString(),
              child: Text(
                o.name,
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ))
        .toList();
  }

  /// ── Helpers: selection → ID / field kind ─────────────────────────────────

  StartWorkType? get _selectedType {
    if (startWorkTypeController.text.isEmpty) return null;
    final match = _startWorkTypes.where(
      (t) => _localizedName(t.nameAr, t.nameEn) == startWorkTypeController.text,
    );
    return match.isEmpty ? null : match.first;
  }

  int? get _selectedTypeId => _selectedType?.id;

  int? get _selectedEmployeeId {
    if (employeeController.text.isEmpty) return null;
    final match = _employees.where(
      (e) => e.quadName == employeeController.text,
    );
    return match.isEmpty ? null : match.first.id;
  }

  /// Maps the selected type to its conditional field. Keyed off the type's
  /// Arabic name (always present on the entity, so this stays correct even
  /// when the app renders the English name in the dropdown).
  StartWorkFieldKind get activeFieldKind {
    final type = _selectedType;
    if (type == null) return StartWorkFieldKind.none;
    final ar = type.nameAr;
    if (ar.contains('تعيين') ||
        ar.contains('تعين') ||
        ar.contains('توقيع') ||
        ar.contains('عقد')) {
      return StartWorkFieldKind.contract;
    }
    if (ar.contains('تكليف')) return StartWorkFieldKind.taskManagement;
    if (ar.contains('نقل')) return StartWorkFieldKind.employeeTransfer;
    if (ar.contains('مسمى') || ar.contains('مسمي')) {
      return StartWorkFieldKind.jobTitleModification;
    }
    if (ar.contains('إعارة') || ar.contains('اعارة')) {
      return StartWorkFieldKind.endLoanPeriod;
    }
    if (ar.contains('إجازة') || ar.contains('اجازة')) {
      return StartWorkFieldKind.leaveType;
    }
    if (ar.contains('تمديد')) return StartWorkFieldKind.extendWorkingPeriod;
    return StartWorkFieldKind.none; // promotion / anything with no extra field
  }

  /// ── Params ───────────────────────────────────────────────────────────────

  CreateStartWorkParams _buildParams() {
    final kind = activeFieldKind;
    return CreateStartWorkParams(
      date: DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
      employee: _selectedEmployeeId ?? 0,
      managerId: int.tryParse(_sessionStorage.employeeId ?? '0') ?? 0,
      officeId: int.tryParse(officeIdController.text) ?? 0,
      startDate: startDateController.text.trim(),
      typeId: _selectedTypeId ?? 0,
      note: noteController.text.trim(),
      attachmentName: attachmentFileNameController.text.trim(),
      attachment: attachmentFileController.text.trim(),
      hrContractId: kind == StartWorkFieldKind.contract
          ? (int.tryParse(contractController.text) ?? 0)
          : 0,
      taskManagementId: kind == StartWorkFieldKind.taskManagement
          ? (int.tryParse(taskManagementController.text) ?? 0)
          : 0,
      holidayStatusId: kind == StartWorkFieldKind.leaveType
          ? (int.tryParse(leaveTypeController.text) ?? 0)
          : 0,
      employeeTransfer: kind == StartWorkFieldKind.employeeTransfer
          ? employeeTransferController.text.trim()
          : '',
      jobTitleModification: kind == StartWorkFieldKind.jobTitleModification
          ? jobTitleModificationController.text.trim()
          : '',
      endLoanPeriod: kind == StartWorkFieldKind.endLoanPeriod
          ? endLoanPeriodController.text.trim()
          : '',
      extendEmployeeWorkingPeriod:
          kind == StartWorkFieldKind.extendWorkingPeriod
              ? extendWorkingPeriodController.text.trim()
              : '',
    );
  }

  /// ── Create ───────────────────────────────────────────────────────────────

  Future<void> createStartWorkRequest() async {
    emit(state.copyWith(status: StartWorkStatus.createLoading));

    final result = await _createStartWorkUseCase.call(params: _buildParams());

    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: StartWorkStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: StartWorkStatus.createLoaded,
        requestNumber: response.requestId.toString(),
      )),
    );
  }

  /// ── Update ───────────────────────────────────────────────────────────────

  Future<void> updateStartWorkRequest({required int requestId}) async {
    emit(state.copyWith(status: StartWorkStatus.createLoading));

    final result = await _updateStartWorkUseCase.call(
      params: UpdateStartWorkParams(
        requestId: requestId,
        data: _buildParams(),
      ),
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: StartWorkStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: StartWorkStatus.createLoaded,
        requestNumber: response.requestId.toString(),
      )),
    );
  }

  /// ── Reset ────────────────────────────────────────────────────────────────

  void deleteStartWorkRequest() {
    applicantNameController.clear();
    organizationalUnitController.clear();
    officeIdController.clear();
    startWorkTypeController.clear();
    employeeController.clear();
    startDateController.clear();
    startHijriController.clear();
    noteController.clear();
    contractController.clear();
    taskManagementController.clear();
    leaveTypeController.clear();
    employeeTransferController.clear();
    jobTitleModificationController.clear();
    endLoanPeriodController.clear();
    endLoanHijriController.clear();
    extendWorkingPeriodController.clear();
    attachmentFileController.clear();
    attachmentFileNameController.clear();
    emit(state.copyWith(
      selectedTypeId: 0,
      selectedEmployeeId: 0,
      conditionalVersion: state.conditionalVersion + 1,
    ));
  }

  /// ── Private helpers ──────────────────────────────────────────────────────

  String _localizedName(String ar, String en) {
    return S.current.localeee == 'en'
        ? (en.isEmpty ? ar : en)
        : (ar.isEmpty ? en : ar);
  }

  @override
  Future<void> close() {
    applicantNameController.dispose();
    organizationalUnitController.dispose();
    officeIdController.dispose();
    startWorkTypeController.dispose();
    employeeController.dispose();
    startDateController.dispose();
    startHijriController.dispose();
    noteController.dispose();
    contractController.dispose();
    taskManagementController.dispose();
    leaveTypeController.dispose();
    employeeTransferController.dispose();
    jobTitleModificationController.dispose();
    endLoanPeriodController.dispose();
    endLoanHijriController.dispose();
    extendWorkingPeriodController.dispose();
    attachmentFileController.dispose();
    attachmentFileNameController.dispose();
    return super.close();
  }
}
