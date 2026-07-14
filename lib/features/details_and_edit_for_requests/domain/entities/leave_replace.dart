import 'package:equatable/equatable.dart';

class LeaveReplaceEntity extends Equatable {
  final String externalName;
  final String state;
  final int? employeeId;
  final String requestDate;
  final String leaveStartDate;
  final String leaveEndDate;
  final int? leaveTypeId;
  final String leaveTypeName;
  final int? leaveId;
  final String? editReasons;
  final String? rejectReasons;

  const LeaveReplaceEntity({
    this.externalName = '',
    this.state = '',
    this.employeeId,
    this.requestDate = '',
    this.leaveStartDate = '',
    this.leaveEndDate = '',
    this.leaveTypeId,
    this.leaveTypeName = '',
    this.leaveId,
    this.editReasons,
    this.rejectReasons,
  });

  @override
  List<Object?> get props => [
        externalName,
        state,
        employeeId,
        requestDate,
        leaveStartDate,
        leaveEndDate,
        leaveTypeId,
        leaveTypeName,
        leaveId,
        editReasons,
        rejectReasons,
      ];
}
