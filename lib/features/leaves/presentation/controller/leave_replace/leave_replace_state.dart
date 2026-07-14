part of 'leave_replace_cubit.dart';

enum LeaveReplaceStatus {
  initial,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

extension LeaveReplaceStatusX on LeaveReplaceStatus {
  bool get isLoading =>
      this == LeaveReplaceStatus.lookupsLoading ||
      this == LeaveReplaceStatus.createLoading;
  bool get isError =>
      this == LeaveReplaceStatus.createError ||
      this == LeaveReplaceStatus.lookupsError;
  bool get isCreateLoaded => this == LeaveReplaceStatus.createLoaded;
  bool get isLookupsLoaded => this == LeaveReplaceStatus.lookupsLoaded;
}

class LeaveReplaceState extends Equatable {
  final LeaveReplaceStatus status;
  final List<LeaveType> leaveTypes;
  final List<EmployeeLeave> employeeLeaves;
  final bool leavesLoading;
  final int? selectedLeaveTypeId;
  final int? selectedLeaveId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? errorMessage;
  final String? requestNumber;

  const LeaveReplaceState({
    this.status = LeaveReplaceStatus.initial,
    this.leaveTypes = const [],
    this.employeeLeaves = const [],
    this.leavesLoading = false,
    this.selectedLeaveTypeId,
    this.selectedLeaveId,
    this.startDate,
    this.endDate,
    this.errorMessage,
    this.requestNumber,
  });

  LeaveReplaceState copyWith({
    LeaveReplaceStatus? status,
    List<LeaveType>? leaveTypes,
    List<EmployeeLeave>? employeeLeaves,
    bool? leavesLoading,
    int? selectedLeaveTypeId,
    int? selectedLeaveId,
    DateTime? startDate,
    DateTime? endDate,
    String? errorMessage,
    String? requestNumber,
    bool clearSelectedLeave = false,
  }) {
    return LeaveReplaceState(
      status: status ?? this.status,
      leaveTypes: leaveTypes ?? this.leaveTypes,
      employeeLeaves: employeeLeaves ?? this.employeeLeaves,
      leavesLoading: leavesLoading ?? this.leavesLoading,
      selectedLeaveTypeId: selectedLeaveTypeId ?? this.selectedLeaveTypeId,
      selectedLeaveId:
          clearSelectedLeave ? null : (selectedLeaveId ?? this.selectedLeaveId),
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  @override
  List<Object?> get props => [
        status,
        leaveTypes,
        employeeLeaves,
        leavesLoading,
        selectedLeaveTypeId,
        selectedLeaveId,
        startDate,
        endDate,
        errorMessage,
        requestNumber,
      ];
}
