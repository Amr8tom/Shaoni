import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/leave_interruption.dart';

class LeaveInterruptionModel extends LeaveInterruptionEntity {
  const LeaveInterruptionModel({
    super.externalName = '',
    super.state = '',
    super.employeeId,
    super.requestDate = '',
    super.leaveInterruptionDate = '',
    super.leaveInterruptionTypeId,
    super.leaveInterruptionTypeName = '',
    super.leaveTypeId,
    super.leaveTypeName = '',
    super.leaveId,
    super.reasons = '',
    super.editReasons,
    super.rejectReasons,
  });

  factory LeaveInterruptionModel.fromJson(Map<String, dynamic> json) {
    return LeaveInterruptionModel(
      externalName: json['externalName'] as String? ?? '',
      state: json['state'] as String? ?? '',
      employeeId: json['employeeId'] as int?,
      requestDate: json['requestDate'] as String? ?? '',
      leaveInterruptionDate: json['leaveInterruptionDate'] as String? ?? '',
      leaveInterruptionTypeId: json['leaveInterruptionTypeId'] as int?,
      leaveInterruptionTypeName:
          json['leaveInterruptionTypeName'] as String? ?? '',
      leaveTypeId: json['leaveTypeId'] as int?,
      leaveTypeName: json['leaveTypeName'] as String? ?? '',
      leaveId: json['leaveId'] as int?,
      reasons: json['leaveInterruptionRequestReasons'] as String? ?? '',
      editReasons: json['editReasons'] as String?,
      rejectReasons: json['rejectReasons'] as String?,
    );
  }

  static Map<String, dynamic> toJsonFromEntity(LeaveInterruptionEntity entity) {
    return {
      'externalName': entity.externalName,
      'state': entity.state,
      'employeeId': entity.employeeId,
      'requestDate': entity.requestDate,
      'leaveInterruptionDate': entity.leaveInterruptionDate,
      'leaveInterruptionTypeId': entity.leaveInterruptionTypeId,
      'leaveInterruptionTypeName': entity.leaveInterruptionTypeName,
      'leaveTypeId': entity.leaveTypeId,
      'leaveTypeName': entity.leaveTypeName,
      'leaveId': entity.leaveId,
      'leaveInterruptionRequestReasons': entity.reasons,
      'editReasons': entity.editReasons,
      'rejectReasons': entity.rejectReasons,
    };
  }
}
