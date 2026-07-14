import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/outside_working_details.dart';

class OutsideWorkingLineModel extends OutsideWorkingLineEntity {
  const OutsideWorkingLineModel({
    super.id,
    super.employeeId,
    super.startDate = '',
    super.endDate = '',
    super.includeWeekend = false,
    super.exceptionRequest = false,
    super.attendanceWay = '',
    super.tasks = '',
    super.privateTasks = '',
    super.state = '',
    super.cancelReason = '',
  });

  factory OutsideWorkingLineModel.fromJson(Map<String, dynamic> json) {
    return OutsideWorkingLineModel(
      id: json['id'] as int?,
      employeeId: json['employeeId'] as int?,
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      includeWeekend: json['includeWeekend'] as bool? ?? false,
      exceptionRequest: json['exceptionRequest'] as bool? ?? false,
      attendanceWay: json['attendanceWay'] as String? ?? '',
      tasks: json['tasks'] as String? ?? '',
      privateTasks: json['privateTasks'] as String? ?? '',
      state: json['state'] as String? ?? '',
      cancelReason: json['cancelReason'] as String? ?? '',
    );
  }

  static Map<String, dynamic> toJsonFromEntity(OutsideWorkingLineEntity e) {
    return {
      'id': e.id,
      'employeeId': e.employeeId,
      'startDate': e.startDate,
      'endDate': e.endDate,
      'includeWeekend': e.includeWeekend,
      'exceptionRequest': e.exceptionRequest,
      'attendanceWay': e.attendanceWay,
      'tasks': e.tasks,
      'privateTasks': e.privateTasks,
      'state': e.state,
      'cancelReason': e.cancelReason,
    };
  }
}

class OutsideWorkingDetailsModel extends OutsideWorkingDetailsEntity {
  const OutsideWorkingDetailsModel({
    super.id,
    super.odooOutsideWorkingId,
    super.orderReason = '',
    super.editReasons,
    super.rejectReasons,
    super.departmentType = '',
    super.projectType = '',
    super.attendanceWay = '',
    super.startDate = '',
    super.endDate = '',
    super.includeWeekend = false,
    super.applicantForAssignmentId,
    super.projectIds = const [],
    super.lines = const [],
  });

  factory OutsideWorkingDetailsModel.fromJson(Map<String, dynamic> json) {
    final rawLines = json['lines'];
    final rawProjects = json['projectIds'];

    return OutsideWorkingDetailsModel(
      id: json['id'] as int?,
      odooOutsideWorkingId: json['odooOutsideWorkingId'] as int?,
      orderReason: json['orderReason'] as String? ?? '',
      editReasons: json['editReasons'] as String?,
      rejectReasons: json['rejectReasons'] as String?,
      departmentType: json['departmentType'] as String? ?? '',
      projectType: json['projectType'] as String? ?? '',
      attendanceWay: json['attendanceWay'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      includeWeekend: json['includeWeekend'] as bool? ?? false,
      applicantForAssignmentId: json['applicantForAssignmentId'] as int?,
      projectIds: rawProjects is List
          ? rawProjects.whereType<int>().toList()
          : const [],
      lines: rawLines is List
          ? rawLines
              .whereType<Map<String, dynamic>>()
              .map(OutsideWorkingLineModel.fromJson)
              .toList()
          : const [],
    );
  }

  static Map<String, dynamic> toJsonFromEntity(OutsideWorkingDetailsEntity e) {
    return {
      'id': e.id,
      'odooOutsideWorkingId': e.odooOutsideWorkingId,
      'orderReason': e.orderReason,
      'editReasons': e.editReasons,
      'rejectReasons': e.rejectReasons,
      'departmentType': e.departmentType,
      'projectType': e.projectType,
      'attendanceWay': e.attendanceWay,
      'startDate': e.startDate,
      'endDate': e.endDate,
      'includeWeekend': e.includeWeekend,
      'applicantForAssignmentId': e.applicantForAssignmentId,
      'projectIds': e.projectIds,
      'lines': e.lines.map(OutsideWorkingLineModel.toJsonFromEntity).toList(),
    };
  }
}
