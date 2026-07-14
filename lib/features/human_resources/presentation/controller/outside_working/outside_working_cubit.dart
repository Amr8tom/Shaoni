import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/attendance_way.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/department_type_lookup.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/outside_working_employee.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/outside_working_project.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/project_type_lookup.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/get_attendance_way_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/get_department_type_lookup_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/get_project_type_lookup_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/get_outside_working_employees_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/get_outside_working_projects_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/create_outside_working_use_case.dart';

part 'outside_working_state.dart';

/// Per-employee task inputs. Controllers must live in the cubit, not in state.
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
  final SessionStorage _sessionStorage;

  final requestFormKey = GlobalKey<FormState>();

  // ── Controllers ───────────────────────────────────────────────────────────
  final officeIdController = TextEditingController();
  final orderReasonController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  /// Per-employee task data keyed by employee id.
  final Map<int, EmployeeTaskData> employeeTaskData = {};

  OutsideWorkingCubit(
    this._getAttendanceWayUseCase,
    this._getDepartmentTypeLookupUseCase,
    this._getProjectTypeLookupUseCase,
    this._getOutsideWorkingEmployeesUseCase,
    this._getOutsideWorkingProjectsUseCase,
    this._createOutsideWorkingUseCase,
    this._sessionStorage,
  ) : super(const OutsideWorkingState()) {
    _loadLookups();
  }

  // ── Lookups ───────────────────────────────────────────────────────────────

  Future<void> _loadLookups() async {
    emit(state.copyWith(status: OutsideWorkingStatus.lookupsLoading));
    await _fetchAttendanceWays();
    await _fetchDepartmentTypes();
    await _fetchProjectTypes();
    await _fetchEmployees();
    if (isClosed) return;
    if (state.status != OutsideWorkingStatus.lookupsError) {
      emit(state.copyWith(status: OutsideWorkingStatus.lookupsLoaded));
    }
  }

  Future<void> _fetchAttendanceWays() async {
    final result = await _getAttendanceWayUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: OutsideWorkingStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (ways) => emit(state.copyWith(attendanceWays: ways)),
    );
  }

  Future<void> _fetchDepartmentTypes() async {
    final result =
        await _getDepartmentTypeLookupUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: OutsideWorkingStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (types) => emit(state.copyWith(departmentTypes: types)),
    );
  }

  Future<void> _fetchProjectTypes() async {
    final result = await _getProjectTypeLookupUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: OutsideWorkingStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (types) => emit(state.copyWith(projectTypes: types)),
    );
  }

  Future<void> _fetchEmployees() async {
    final result =
        await _getOutsideWorkingEmployeesUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: OutsideWorkingStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (employees) => emit(state.copyWith(
        employees: employees,
        currentUserDepartmentId: _resolveCurrentUserDepartment(employees),
      )),
    );
  }

  Future<void> _fetchProjects() async {
    emit(state.copyWith(projectsLoading: true));
    final result =
        await _getOutsideWorkingProjectsUseCase.call(params: NoParams());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        projectsLoading: false,
        status: OutsideWorkingStatus.lookupsError,
        errorMessage: failure.message,
      )),
      (projects) => emit(state.copyWith(
        projectsLoading: false,
        projects: projects,
      )),
    );
  }

  /// The session only stores the employee id, so the applicant's department is
  /// resolved by finding them in the employee directory.
  int? _resolveCurrentUserDepartment(List<OutsideWorkingEmployee> employees) {
    final employeeId = int.tryParse(_sessionStorage.employeeId ?? '');
    if (employeeId == null) return null;
    for (final employee in employees) {
      if (employee.id == employeeId) return employee.departmentId;
    }
    return null;
  }

  // ── Selection handlers ────────────────────────────────────────────────────

  /// Switching the department type changes which employees are eligible, so any
  /// previous picks (and their task inputs) are dropped.
  void onDepartmentTypeSelected(String? value) {
    if (value == null) return;
    _disposeTaskData();
    emit(state.copyWith(
      departmentTypeCode: value,
      selectedEmployees: const [],
      employeeSearchQuery: '',
    ));
  }

  void onProjectTypeSelected(String? value) {
    if (value == null) return;
    emit(state.copyWith(
      projectTypeCode: value,
      clearSelectedProject: true,
    ));
    if (value != kGeneralProject && state.projects.isEmpty) {
      _fetchProjects();
    }
  }

  void onProjectNameSelected(String? value) {
    final id = int.tryParse(value ?? '');
    if (id == null) return;
    emit(state.copyWith(selectedProjectId: id));
  }

  void onAttendanceWaySelected(String? value) {
    if (value == null) return;
    emit(state.copyWith(attendanceWayCode: value));
  }

  void setIncludeWeekend(bool value) {
    emit(state.copyWith(includeWeekend: value));
  }

  // ── Employee multi-select ─────────────────────────────────────────────────

  void toggleEmployee(OutsideWorkingEmployee employee) {
    final isSelected = state.isEmployeeSelected(employee);

    if (isSelected) {
      employeeTaskData[employee.id]?.dispose();
      employeeTaskData.remove(employee.id);
      emit(state.copyWith(
        selectedEmployees:
            state.selectedEmployees.where((e) => e.id != employee.id).toList(),
      ));
    } else {
      // Each line inherits the request-level weekend choice by default.
      employeeTaskData[employee.id] = EmployeeTaskData()
        ..includeWeekend = state.includeWeekend;
      emit(state.copyWith(
        selectedEmployees: [...state.selectedEmployees, employee],
      ));
    }
  }

  void onEmployeeSearchChanged(String query) {
    emit(state.copyWith(employeeSearchQuery: query));
  }

  // ── Per-employee task setters ─────────────────────────────────────────────

  void setEmployeeIncludeWeekend(int employeeId, bool value) {
    employeeTaskData[employeeId]?.includeWeekend = value;
    _bumpTaskData();
  }

  void setExceptionRequest(int employeeId, bool value) {
    employeeTaskData[employeeId]?.exceptionRequest = value;
    _bumpTaskData();
  }

  void _bumpTaskData() =>
      emit(state.copyWith(taskDataVersion: state.taskDataVersion + 1));

  // ── Create ────────────────────────────────────────────────────────────────

  Future<void> createOutsideWorking() async {
    emit(state.copyWith(status: OutsideWorkingStatus.createLoading));

    final includeWeekend = state.includeWeekend;

    final lines = state.selectedEmployees.map((e) {
      final data = employeeTaskData[e.id];
      return OutWorkingLine(
        employee: e.id,
        includeWeekend: data?.includeWeekend ?? includeWeekend,
        exceptionRequest: data?.exceptionRequest ?? false,
        tasks: data?.tasksController.text.trim() ?? '',
        privateTasks: data?.privateTasksController.text.trim() ?? '',
      );
    }).toList();

    final params = CreateOutsideWorkingParams(
      employeeId: int.tryParse(_sessionStorage.employeeId ?? '0') ?? 0,
      officeId: int.tryParse(officeIdController.text) ?? 0,
      date: DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
      orderReason: orderReasonController.text.trim(),
      departmentType: state.departmentTypeCode ?? '',
      projectType: state.projectTypeCode ?? '',
      projectName: state.showProjectName && state.selectedProjectId != null
          ? [state.selectedProjectId!]
          : const [],
      employeeIds: state.selectedEmployees.map((e) => e.id).toList(),
      startDate: startDateController.text.trim(),
      endDate: endDateController.text.trim(),
      includeWeekend: includeWeekend,
      attendanceWay: state.attendanceWayCode ?? '',
      outWorkingLines: lines,
    );

    final result = await _createOutsideWorkingUseCase.call(params: params);
    if (isClosed) return;
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
    orderReasonController.clear();
    startDateController.clear();
    endDateController.clear();
    _disposeTaskData();

    emit(OutsideWorkingState(
      status: OutsideWorkingStatus.lookupsLoaded,
      departmentTypes: state.departmentTypes,
      projectTypes: state.projectTypes,
      attendanceWays: state.attendanceWays,
      projects: state.projects,
      employees: state.employees,
      currentUserDepartmentId: state.currentUserDepartmentId,
    ));
  }

  void _disposeTaskData() {
    for (final data in employeeTaskData.values) {
      data.dispose();
    }
    employeeTaskData.clear();
  }

  @override
  Future<void> close() {
    officeIdController.dispose();
    orderReasonController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    _disposeTaskData();
    return super.close();
  }
}
