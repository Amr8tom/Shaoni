import 'package:equatable/equatable.dart';

class LeaveInterruptionEntity extends Equatable {
  final String externalName;
  final String state;
  final int? employeeId;
  final String requestDate;
  final String leaveInterruptionDate;
  final int? leaveInterruptionTypeId;
  final String leaveInterruptionTypeName;
  final int? leaveTypeId;
  final String leaveTypeName;
  final int? leaveId;
  final String reasons;
  final String? editReasons;
  final String? rejectReasons;

  const LeaveInterruptionEntity({
    this.externalName = '',
    this.state = '',
    this.employeeId,
    this.requestDate = '',
    this.leaveInterruptionDate = '',
    this.leaveInterruptionTypeId,
    this.leaveInterruptionTypeName = '',
    this.leaveTypeId,
    this.leaveTypeName = '',
    this.leaveId,
    this.reasons = '',
    this.editReasons,
    this.rejectReasons,
  });

  @override
  List<Object?> get props => [
        externalName,
        state,
        employeeId,
        requestDate,
        leaveInterruptionDate,
        leaveInterruptionTypeId,
        leaveInterruptionTypeName,
        leaveTypeId,
        leaveTypeName,
        leaveId,
        reasons,
        editReasons,
        rejectReasons,
      ];
}
