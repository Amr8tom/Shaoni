import 'package:equatable/equatable.dart';

class OutsideWorkingLineEntity extends Equatable {
  final int? id;

  /// Odoo line id — this is the id the accept/refuse action endpoint expects
  /// (`POST /OutsideWorkingLines/action/{odooLineId}`), shown on the web as
  /// "رقم طلب التكليف".
  final int? odooLineId;
  final int? employeeId;
  final String startDate;
  final String endDate;
  final bool includeWeekend;
  final bool exceptionRequest;
  final String attendanceWay;
  final String tasks;
  final String privateTasks;
  final String state;
  final String cancelReason;

  const OutsideWorkingLineEntity({
    this.id,
    this.odooLineId,
    this.employeeId,
    this.startDate = '',
    this.endDate = '',
    this.includeWeekend = false,
    this.exceptionRequest = false,
    this.attendanceWay = '',
    this.tasks = '',
    this.privateTasks = '',
    this.state = '',
    this.cancelReason = '',
  });

  @override
  List<Object?> get props => [
        id,
        odooLineId,
        employeeId,
        startDate,
        endDate,
        includeWeekend,
        exceptionRequest,
        attendanceWay,
        tasks,
        privateTasks,
        state,
        cancelReason,
      ];
}

class OutsideWorkingDetailsEntity extends Equatable {
  final int? id;
  final int? odooOutsideWorkingId;
  final String orderReason;
  final String? editReasons;
  final String? rejectReasons;
  final String departmentType;
  final String projectType;
  final String attendanceWay;
  final String startDate;
  final String endDate;
  final bool includeWeekend;
  final int? applicantForAssignmentId;
  final List<int> projectIds;
  final List<OutsideWorkingLineEntity> lines;

  const OutsideWorkingDetailsEntity({
    this.id,
    this.odooOutsideWorkingId,
    this.orderReason = '',
    this.editReasons,
    this.rejectReasons,
    this.departmentType = '',
    this.projectType = '',
    this.attendanceWay = '',
    this.startDate = '',
    this.endDate = '',
    this.includeWeekend = false,
    this.applicantForAssignmentId,
    this.projectIds = const [],
    this.lines = const [],
  });

  @override
  List<Object?> get props => [
        id,
        odooOutsideWorkingId,
        orderReason,
        editReasons,
        rejectReasons,
        departmentType,
        projectType,
        attendanceWay,
        startDate,
        endDate,
        includeWeekend,
        applicantForAssignmentId,
        projectIds,
        lines,
      ];
}
