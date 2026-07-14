import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/leave_replace.dart';

class LeaveReplaceModel extends LeaveReplaceEntity {
  const LeaveReplaceModel({
    super.externalName = '',
    super.state = '',
    super.employeeId,
    super.requestDate = '',
    super.leaveStartDate = '',
    super.leaveEndDate = '',
    super.leaveTypeId,
    super.leaveTypeName = '',
    super.leaveId,
    super.editReasons,
    super.rejectReasons,
  });

  factory LeaveReplaceModel.fromJson(Map<String, dynamic> json) {
    return LeaveReplaceModel(
      externalName: json['externalName'] as String? ?? '',
      state: json['state'] as String? ?? '',
      employeeId: json['employeeId'] as int?,
      requestDate: json['requestDate'] as String? ?? '',
      leaveStartDate: json['leaveStartDate'] as String? ?? '',
      leaveEndDate: json['leaveEndDate'] as String? ?? '',
      leaveTypeId: json['leaveTypeId'] as int?,
      leaveTypeName: json['leaveTypeName'] as String? ?? '',
      leaveId: json['leaveId'] as int?,
      editReasons: json['editReasons'] as String?,
      rejectReasons: json['rejectReasons'] as String?,
    );
  }

  static Map<String, dynamic> toJsonFromEntity(LeaveReplaceEntity entity) {
    return {
      'externalName': entity.externalName,
      'state': entity.state,
      'employeeId': entity.employeeId,
      'requestDate': entity.requestDate,
      'leaveStartDate': entity.leaveStartDate,
      'leaveEndDate': entity.leaveEndDate,
      'leaveTypeId': entity.leaveTypeId,
      'leaveTypeName': entity.leaveTypeName,
      'leaveId': entity.leaveId,
      'editReasons': entity.editReasons,
      'rejectReasons': entity.rejectReasons,
    };
  }
}
