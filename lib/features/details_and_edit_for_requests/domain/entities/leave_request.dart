import 'package:equatable/equatable.dart';

class LeaveRequestAttachment extends Equatable {
  final int? id;
  final String name;
  final String url;

  const LeaveRequestAttachment({
    this.id,
    this.name = '',
    this.url = '',
  });

  @override
  List<Object?> get props => [id, name, url];
}

/// Details entity for `extraData.leaveRequest` (service `hr.leave`).
class LeaveRequestEntity extends Equatable {
  final String name;
  final String holidayType;
  final int? employeeId;
  final String employeeName;
  final int? alternativeEmployeeId;
  final String alternativeEmployeeName;
  final int? departmentId;
  final String departmentName;
  final int? holidayStatusId;
  final String holidayStatusName;
  final String resourceCalendarName;
  final String stateAr;
  final String stateEn;
  final String validationTypeAr;
  final String validationTypeEn;
  final String requestDateFrom;
  final String requestDateTo;
  final bool requestUnitHours;
  final bool requestUnitHalf;
  final String stageName;
  final String? editReasons;
  final String? rejectReasons;
  final List<LeaveRequestAttachment> attachments;

  const LeaveRequestEntity({
    this.name = '',
    this.holidayType = '',
    this.employeeId,
    this.employeeName = '',
    this.alternativeEmployeeId,
    this.alternativeEmployeeName = '',
    this.departmentId,
    this.departmentName = '',
    this.holidayStatusId,
    this.holidayStatusName = '',
    this.resourceCalendarName = '',
    this.stateAr = '',
    this.stateEn = '',
    this.validationTypeAr = '',
    this.validationTypeEn = '',
    this.requestDateFrom = '',
    this.requestDateTo = '',
    this.requestUnitHours = false,
    this.requestUnitHalf = false,
    this.stageName = '',
    this.editReasons,
    this.rejectReasons,
    this.attachments = const [],
  });

  @override
  List<Object?> get props => [
        name,
        holidayType,
        employeeId,
        employeeName,
        alternativeEmployeeId,
        alternativeEmployeeName,
        departmentId,
        departmentName,
        holidayStatusId,
        holidayStatusName,
        resourceCalendarName,
        stateAr,
        stateEn,
        validationTypeAr,
        validationTypeEn,
        requestDateFrom,
        requestDateTo,
        requestUnitHours,
        requestUnitHalf,
        stageName,
        editReasons,
        rejectReasons,
        attachments,
      ];
}
