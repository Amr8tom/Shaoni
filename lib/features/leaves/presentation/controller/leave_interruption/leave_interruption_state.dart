part of 'leave_interruption_cubit.dart';

enum LeaveInterruptionStatus {
  initial,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

extension LeaveInterruptionStatusX on LeaveInterruptionStatus {
  bool get isLoading =>
      this == LeaveInterruptionStatus.lookupsLoading ||
      this == LeaveInterruptionStatus.createLoading;
  bool get isError =>
      this == LeaveInterruptionStatus.createError ||
      this == LeaveInterruptionStatus.lookupsError;
  bool get isCreateLoaded => this == LeaveInterruptionStatus.createLoaded;
  bool get isLookupsLoaded => this == LeaveInterruptionStatus.lookupsLoaded;
}

class LeaveInterruptionState extends Equatable {
  final LeaveInterruptionStatus status;
  final List<InterruptionType> interruptionTypes;
  final List<LeaveType> leaveTypes;
  final List<EmployeeLeave> employeeLeaves;
  final bool leavesLoading;
  final int? selectedInterruptionTypeId;
  final int? selectedLeaveTypeId;
  final int? selectedLeaveId;
  final DateTime? interruptionDate;
  final String attachmentName;
  final String attachmentBase64;
  final String? errorMessage;
  final String? requestNumber;

  const LeaveInterruptionState({
    this.status = LeaveInterruptionStatus.initial,
    this.interruptionTypes = const [],
    this.leaveTypes = const [],
    this.employeeLeaves = const [],
    this.leavesLoading = false,
    this.selectedInterruptionTypeId,
    this.selectedLeaveTypeId,
    this.selectedLeaveId,
    this.interruptionDate,
    this.attachmentName = '',
    this.attachmentBase64 = '',
    this.errorMessage,
    this.requestNumber,
  });

  LeaveInterruptionState copyWith({
    LeaveInterruptionStatus? status,
    List<InterruptionType>? interruptionTypes,
    List<LeaveType>? leaveTypes,
    List<EmployeeLeave>? employeeLeaves,
    bool? leavesLoading,
    int? selectedInterruptionTypeId,
    int? selectedLeaveTypeId,
    int? selectedLeaveId,
    DateTime? interruptionDate,
    String? attachmentName,
    String? attachmentBase64,
    String? errorMessage,
    String? requestNumber,
    bool clearSelectedLeave = false,
  }) {
    return LeaveInterruptionState(
      status: status ?? this.status,
      interruptionTypes: interruptionTypes ?? this.interruptionTypes,
      leaveTypes: leaveTypes ?? this.leaveTypes,
      employeeLeaves: employeeLeaves ?? this.employeeLeaves,
      leavesLoading: leavesLoading ?? this.leavesLoading,
      selectedInterruptionTypeId:
          selectedInterruptionTypeId ?? this.selectedInterruptionTypeId,
      selectedLeaveTypeId: selectedLeaveTypeId ?? this.selectedLeaveTypeId,
      selectedLeaveId:
          clearSelectedLeave ? null : (selectedLeaveId ?? this.selectedLeaveId),
      interruptionDate: interruptionDate ?? this.interruptionDate,
      attachmentName: attachmentName ?? this.attachmentName,
      attachmentBase64: attachmentBase64 ?? this.attachmentBase64,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  @override
  List<Object?> get props => [
        status,
        interruptionTypes,
        leaveTypes,
        employeeLeaves,
        leavesLoading,
        selectedInterruptionTypeId,
        selectedLeaveTypeId,
        selectedLeaveId,
        interruptionDate,
        attachmentName,
        attachmentBase64,
        errorMessage,
        requestNumber,
      ];
}
