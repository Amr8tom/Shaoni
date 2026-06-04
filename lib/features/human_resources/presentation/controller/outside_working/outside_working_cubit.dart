import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/local_storage/cache_helper.dart';
import 'package:shaoni/core/local_storage/cache_keys.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/attendance_way.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/department_type_lookup.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/project_type_lookup.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/outside_working_employee.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/outside_working_project.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/get_attendance_way_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/get_department_type_lookup_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/get_project_type_lookup_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/get_outside_working_employees_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/get_outside_working_projects_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/create_outside_working_use_case.dart';
import 'package:shaoni/generated/l10n.dart';

part 'outside_working_state.dart';

/// Per-employee mutable task data.
class EmployeeTaskData {
  final TextEditingController tasksController = TextEditingController();
  final TextEditingController privateTasksController = TextEditingController();
  bool includeWeekend = false;
  bool exceptionRequest = false;

  void dispose() {
    tasksController.dispose();
    privateTasksController.dispose();
  }
}

class OutsideWorkingCubit extends Cubit<OutsideWorkingState> {
  final GetAttendanceWayUseCase _getAttendanceWayUseCase;
  final GetDepartmentTypeLookupUseCase _getDepartmentTypeLookupUseCase;
  final GetProjectTypeLookupUseCase _getProjectTypeLookupUseCase;
  final GetOutsideWorkingEmployeesUseCase _getOutsideWorkingEmployeesUseCase;
  final GetOutsideWorkingProjectsUseCase _getOutsideWorkingProjectsUseCase;
  final CreateOutsideWorkingUseCase _createOutsideWorkingUseCase;

  /// Form key
  final requestFormKey = GlobalKey<FormState>();

  // ── Header controllers ────────────────────────────────────────────────────
  final officeIdController = TextEditingController();
  final applicantNameController = TextEditingController();
  final orderReasonController = TextEditingController();

  // ── Date controllers ──────────────────────────────────────────────────────
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  // ── Dropdown controllers (store nameEn code for payload) ──────────────────
  final departmentTypeController = TextEditingController();
  final projectTypeController = TextEditingController();
  final attendanceWayController = TextEditingController();

  // ── Project name display controller ──────────────────────────────────────
  final projectNameController = TextEditingController();

  // ── Lookup data ───────────────────────────────────────────────────────────
  List<AttendanceWay> _attendanceWays = [];
  List<DepartmentTypeLookup> _departmentTypes = [];
  List<ProjectTypeLookup> _projectTypes = [];
  List<OutsideWorkingEmployee> _employees = [];
  List<OutsideWorkingProject> _projects = [];

  // ── Selected codes / ids ──────────────────────────────────────────────────
  String? _selectedDepartmentTypeCode;
  String? _selectedProjectTypeCode;
  String? _selectedAttendanceWayCode;
  List<int> _selectedProjectIds = [];

  /// Used as the dropdown value for project name (id string); controller holds display name.
  String? selectedProjectId;

  // ── Dropdown items ────────────────────────────────────────────────────────
  List<DropdownMenuItem<String>> departmentTypeItems = [];
  List<DropdownMenuItem<String>> projectTypeItems = [];
  List<DropdownMenuItem<String>> attendanceWayItems = [];
  List<DropdownMenuItem<String>> projectNameItems = [];

  // ── Employee multi-select ─────────────────────────────────────────────────
  List<OutsideWorkingEmployee> selectedEmployees = [];
  String employeeSearchQuery = '';

  /// Per-employee task data keyed by employee id.
  final Map<int, EmployeeTaskData> employeeTaskData = {};

  OutsideWorkingCubit(
    this._getAttendanceWayUseCase,
    this._getDepartmentTypeLookupUseCase,
    this._getProjectTypeLookupUseCase,
    this._getOutsideWorkingEmployeesUseCase,
    this._getOutsideWorkingProjectsUseCase,
    this._createOutsideWorkingUseCase,
  ) : super(const OutsideWorkingState()) {
    _loadLookups();
  }

  // ── Computed getters ──────────────────────────────────────────────────────

  bool get showProjectName => _selectedProjectTypeCode != 'general';

  List<OutsideWorkingEmployee> get filteredEmployees {
    if (employeeSearchQuery.isEmpty) return _employees;
    return _employees
        .where((e) =>
            e.name.toLowerCase().contains(employeeSearchQuery.toLowerCase()))
        .toList();
  }

  // ── Lookups ───────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: OutsideWorkingStatus.lookupsLoading));
    await _fetchAttendanceWays();
    await _fetchDepartmentTypes();
    await _fetchProjectTypes();
    await _fetchEmployees();
    emit(state.copyWith(status: OutsideWorkingStatus.lookupsLoaded));
  }

  Future<void> _fetchAttendanceWays() async {
    final result = await _getAttendanceWayUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: OutsideWorkingStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (ways) {
        _attendanceWays = ways;
        attendanceWayItems = ways
            .map((w) => DropdownMenuItem<String>(
                  value: w.nameEn,
                  child: Text(_localizedName(w.nameAr, w.nameEn),
                      style: const TextStyle(fontSize: 12)),
                ))
            .toList();
      },
    );
  }

  Future<void> _fetchDepartmentTypes() async {
    final result =
        await _getDepartmentTypeLookupUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: OutsideWorkingStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (types) {
        _departmentTypes = types;
        departmentTypeItems = types
            .map((t) => DropdownMenuItem<String>(
                  value: t.nameEn,
                  child: Text(_localizedName(t.nameAr, t.nameEn),
                      style: const TextStyle(fontSize: 12)),
                ))
            .toList();
      },
    );
  }

  Future<void> _fetchProjectTypes() async {
    final result = await _getProjectTypeLookupUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: OutsideWorkingStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (types) {
        _projectTypes = types;
        projectTypeItems = types
            .map((t) => DropdownMenuItem<String>(
                  value: t.nameEn,
                  child: Text(_localizedName(t.nameAr, t.nameEn),
                      style: const TextStyle(fontSize: 12)),
                ))
            .toList();
      },
    );
  }

  Future<void> _fetchEmployees() async {
    final result =
        await _getOutsideWorkingEmployeesUseCase.call(params: NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: OutsideWorkingStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (employees) {
        _employees = employees;
        notifyDropdownChanged();
      },
    );
  }

  Future<void> _fetchProjects() async {
    final result =
        await _getOutsideWorkingProjectsUseCase.call(params: NoParams());
    result.fold(
      (failure) => null,
      (projects) {
        _projects = projects;
        projectNameItems = projects
            .map((p) => DropdownMenuItem<String>(
                  value: p.id.toString(),
                  child: Text(p.name, style: const TextStyle(fontSize: 12)),
                ))
            .toList();
        notifyDropdownChanged();
      },
    );
  }

  // ── Selection handlers ────────────────────────────────────────────────────

  void onDepartmentTypeSelected(String? value) {
    _selectedDepartmentTypeCode = value;
    departmentTypeController.text = value ?? '';
    notifyDropdownChanged();
  }

  void onProjectTypeSelected(String? value) {
    _selectedProjectTypeCode = value;
    projectTypeController.text = value ?? '';
    if (value != 'general' && _projects.isEmpty) {
      _fetchProjects();
    }
    projectNameController.clear();
    _selectedProjectIds = [];
    selectedProjectId = null;
    notifyDropdownChanged();
  }

  void onProjectNameSelected(String? value) {
    if (value == null) return;
    final id = int.tryParse(value);
    if (id != null) {
      _selectedProjectIds = [id];
      selectedProjectId = value;
      final project = _projects.firstWhere((p) => p.id == id,
          orElse: () => OutsideWorkingProject(id: id, name: value));
      projectNameController.text = project.name;
    }
    notifyDropdownChanged();
  }

  void onAttendanceWaySelected(String? value) {
    _selectedAttendanceWayCode = value;
    attendanceWayController.text = value ?? '';
    notifyDropdownChanged();
  }

  // ── Employee multi-select ─────────────────────────────────────────────────

  void toggleEmployee(OutsideWorkingEmployee employee) {
    if (selectedEmployees.any((e) => e.id == employee.id)) {
      selectedEmployees =
          selectedEmployees.where((e) => e.id != employee.id).toList();
      // dispose and remove task data
      employeeTaskData[employee.id]?.dispose();
      employeeTaskData.remove(employee.id);
    } else {
      selectedEmployees = [...selectedEmployees, employee];
      // create fresh task data for this employee
      employeeTaskData[employee.id] = EmployeeTaskData();
    }
    emit(state.copyWith(version: state.version + 1));
  }

  bool isEmployeeSelected(OutsideWorkingEmployee employee) =>
      selectedEmployees.any((e) => e.id == employee.id);

  void onEmployeeSearchChanged(String query) {
    employeeSearchQuery = query;
    emit(state.copyWith(version: state.version + 1));
  }

  // ── Per-employee task setters ─────────────────────────────────────────────

  void setIncludeWeekend(int employeeId, bool value) {
    employeeTaskData[employeeId]?.includeWeekend = value;
    emit(state.copyWith(version: state.version + 1));
  }

  void setExceptionRequest(int employeeId, bool value) {
    employeeTaskData[employeeId]?.exceptionRequest = value;
    emit(state.copyWith(version: state.version + 1));
  }

  void notifyDropdownChanged() {
    emit(state.copyWith(version: state.version + 1));
  }

  // ── Create ────────────────────────────────────────────────────────────────

  Future<void> createOutsideWorking() async {
    emit(state.copyWith(status: OutsideWorkingStatus.createLoading));

    final lines = selectedEmployees.map((e) {
      final data = employeeTaskData[e.id];
      return OutWorkingLine(
        employee: e.id,
        includeWeekend: data?.includeWeekend ?? false,
        exceptionRequest: data?.exceptionRequest ?? false,
        tasks: data?.tasksController.text.trim() ?? '',
        privateTasks: data?.privateTasksController.text.trim() ?? '',
      );
    }).toList();

    final params = CreateOutsideWorkingParams(
      employeeId: int.tryParse(
              CacheHelper.getString(key: CacheKeys.employeeId) ?? '0') ??
          0,
      officeId: int.tryParse(officeIdController.text) ?? 0,
      date: DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
      orderReason: orderReasonController.text.trim(),
      departmentType: _selectedDepartmentTypeCode ?? '',
      projectType: _selectedProjectTypeCode ?? '',
      projectName:
          _selectedProjectTypeCode == 'general' ? [] : _selectedProjectIds,
      employeeIds: selectedEmployees.map((e) => e.id).toList(),
      startDate: startDateController.text.trim(),
      endDate: endDateController.text.trim(),
      includeWeekend: lines.any((l) => l.includeWeekend),
      attendanceWay: _selectedAttendanceWayCode ?? '',
      outWorkingLines: lines,
    );

    final result = await _createOutsideWorkingUseCase.call(params: params);
    result.fold(
      (failure) => emit(state.copyWith(
        status: OutsideWorkingStatus.createError,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: OutsideWorkingStatus.createLoaded,
        requestNumber: response.outsideWorkingName,
      )),
    );
  }

  // ── Reset ─────────────────────────────────────────────────────────────────

  void resetForm() {
    officeIdController.clear();
    applicantNameController.clear();
    orderReasonController.clear();
    startDateController.clear();
    endDateController.clear();
    departmentTypeController.clear();
    projectTypeController.clear();
    attendanceWayController.clear();
    projectNameController.clear();
    _selectedDepartmentTypeCode = null;
    _selectedProjectTypeCode = null;
    _selectedAttendanceWayCode = null;
    _selectedProjectIds = [];
    selectedProjectId = null;
    // dispose all per-employee data
    for (final data in employeeTaskData.values) {
      data.dispose();
    }
    employeeTaskData.clear();
    selectedEmployees = [];
    employeeSearchQuery = '';
    emit(state.copyWith(
        status: OutsideWorkingStatus.lookupsLoaded,
        version: state.version + 1));
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _localizedName(String ar, String en) {
    return S.current.localeee == 'en'
        ? (en.isEmpty ? ar : en)
        : (ar.isEmpty ? en : ar);
  }

  @override
  Future<void> close() {
    officeIdController.dispose();
    applicantNameController.dispose();
    orderReasonController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    departmentTypeController.dispose();
    projectTypeController.dispose();
    attendanceWayController.dispose();
    projectNameController.dispose();
    for (final data in employeeTaskData.values) {
      data.dispose();
    }
    return super.close();
  }
}
