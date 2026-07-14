part of 'outside_working_cubit.dart';

/// Backend codes for `department_type` (from GetDepartmentTypeLookup).
const String kRelatedDepartment = 'related_department';

/// Backend code for a non-specific project (from GetProjectTypeLookup).
const String kGeneralProject = 'general';

enum OutsideWorkingStatus {
  initial,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

extension OutsideWorkingStatusX on OutsideWorkingStatus {
  bool get isLookupsLoading => this == OutsideWorkingStatus.lookupsLoading;

  bool get isCreateLoading => this == OutsideWorkingStatus.createLoading;

  bool get isLoading =>
      this == OutsideWorkingStatus.lookupsLoading ||
      this == OutsideWorkingStatus.createLoading;

  bool get isError =>
      this == OutsideWorkingStatus.lookupsError ||
      this == OutsideWorkingStatus.createError;

  bool get isCreateLoaded => this == OutsideWorkingStatus.createLoaded;
}

class OutsideWorkingState extends Equatable {
  final OutsideWorkingStatus status;
  final String? errorMessage;
  final String? requestNumber;

  /// ── Lookups ───────────────────────────────────────────────────────────────
  final List<DepartmentTypeLookup> departmentTypes;
  final List<ProjectTypeLookup> projectTypes;
  final List<AttendanceWay> attendanceWays;
  final List<OutsideWorkingProject> projects;
  final List<OutsideWorkingEmployee> employees;
  final bool projectsLoading;

  /// Department of the logged-in user, resolved from [employees].
  final int? currentUserDepartmentId;

  /// ── Selections ────────────────────────────────────────────────────────────
  final String? departmentTypeCode;
  final String? projectTypeCode;
  final String? attendanceWayCode;
  final int? selectedProjectId;

  /// Defaults to "yes", matching the preselected value on the web form.
  final bool includeWeekend;
  final List<OutsideWorkingEmployee> selectedEmployees;
  final String employeeSearchQuery;

  /// Bumped whenever per-employee task data (held in the cubit) changes, so
  /// Equatable emits a new state for controller-backed edits.
  final int taskDataVersion;

  const OutsideWorkingState({
    this.status = OutsideWorkingStatus.initial,
    this.errorMessage,
    this.requestNumber,
    this.departmentTypes = const [],
    this.projectTypes = const [],
    this.attendanceWays = const [],
    this.projects = const [],
    this.employees = const [],
    this.projectsLoading = false,
    this.currentUserDepartmentId,
    this.departmentTypeCode,
    this.projectTypeCode,
    this.attendanceWayCode,
    this.selectedProjectId,
    this.includeWeekend = true,
    this.selectedEmployees = const [],
    this.employeeSearchQuery = '',
    this.taskDataVersion = 0,
  });

  /// ── Derived ───────────────────────────────────────────────────────────────

  /// The project name dropdown only shows once a non-general project type is
  /// chosen. Hidden while nothing is selected.
  bool get showProjectName =>
      projectTypeCode != null && projectTypeCode != kGeneralProject;

  /// True when the request targets the applicant's own department.
  bool get isSameDepartment => departmentTypeCode == kRelatedDepartment;

  /// Employees filtered by department type first, then by the search query.
  ///
  /// "Same department" shows only colleagues sharing the applicant's
  /// department; any other type shows everyone.
  List<OutsideWorkingEmployee> get visibleEmployees {
    var list = employees;

    if (isSameDepartment && currentUserDepartmentId != null) {
      list =
          list.where((e) => e.departmentId == currentUserDepartmentId).toList();
    }

    if (employeeSearchQuery.isNotEmpty) {
      final query = employeeSearchQuery.toLowerCase();
      list = list.where((e) {
        return e.name.toLowerCase().contains(query) ||
            e.jobTitle.toLowerCase().contains(query);
      }).toList();
    }

    return list;
  }

  bool isEmployeeSelected(OutsideWorkingEmployee employee) =>
      selectedEmployees.any((e) => e.id == employee.id);

  OutsideWorkingState copyWith({
    OutsideWorkingStatus? status,
    String? errorMessage,
    String? requestNumber,
    List<DepartmentTypeLookup>? departmentTypes,
    List<ProjectTypeLookup>? projectTypes,
    List<AttendanceWay>? attendanceWays,
    List<OutsideWorkingProject>? projects,
    List<OutsideWorkingEmployee>? employees,
    bool? projectsLoading,
    int? currentUserDepartmentId,
    String? departmentTypeCode,
    String? projectTypeCode,
    String? attendanceWayCode,
    int? selectedProjectId,
    bool? includeWeekend,
    List<OutsideWorkingEmployee>? selectedEmployees,
    String? employeeSearchQuery,
    int? taskDataVersion,
    bool clearSelectedProject = false,
  }) {
    return OutsideWorkingState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
      departmentTypes: departmentTypes ?? this.departmentTypes,
      projectTypes: projectTypes ?? this.projectTypes,
      attendanceWays: attendanceWays ?? this.attendanceWays,
      projects: projects ?? this.projects,
      employees: employees ?? this.employees,
      projectsLoading: projectsLoading ?? this.projectsLoading,
      currentUserDepartmentId:
          currentUserDepartmentId ?? this.currentUserDepartmentId,
      departmentTypeCode: departmentTypeCode ?? this.departmentTypeCode,
      projectTypeCode: projectTypeCode ?? this.projectTypeCode,
      attendanceWayCode: attendanceWayCode ?? this.attendanceWayCode,
      selectedProjectId: clearSelectedProject
          ? null
          : (selectedProjectId ?? this.selectedProjectId),
      includeWeekend: includeWeekend ?? this.includeWeekend,
      selectedEmployees: selectedEmployees ?? this.selectedEmployees,
      employeeSearchQuery: employeeSearchQuery ?? this.employeeSearchQuery,
      taskDataVersion: taskDataVersion ?? this.taskDataVersion,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        requestNumber,
        departmentTypes,
        projectTypes,
        attendanceWays,
        projects,
        employees,
        projectsLoading,
        currentUserDepartmentId,
        departmentTypeCode,
        projectTypeCode,
        attendanceWayCode,
        selectedProjectId,
        includeWeekend,
        selectedEmployees,
        employeeSearchQuery,
        taskDataVersion,
      ];
}
