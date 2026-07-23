part of 'leave_request_cubit.dart';

enum LeaveRequestStatus {
  initial,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

extension LeaveRequestStatusX on LeaveRequestStatus {
  bool get isLoading =>
      this == LeaveRequestStatus.lookupsLoading ||
      this == LeaveRequestStatus.createLoading;
  bool get isError =>
      this == LeaveRequestStatus.createError ||
      this == LeaveRequestStatus.lookupsError;
  bool get isCreateLoaded => this == LeaveRequestStatus.createLoaded;
  bool get isLookupsLoaded => this == LeaveRequestStatus.lookupsLoaded;
}

class LeaveRequestState extends Equatable {
  final LeaveRequestStatus status;
  final List<LeaveType> leaveTypes;
  final List<LeaveEmployee> employees;
  final List<LeaveAppointment> appointments;
  final int? selectedLeaveTypeId;
  final int? selectedAlternativeEmployeeId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String attachmentName;
  final String attachmentBase64;

  /// Attachments already stored on the request (edit mode), preserved on update.
  final List<LeaveRequestEditAttachment> existingAttachments;
  final String sequenceNumber;
  final bool requestUnitHours;
  final bool requestUnitHalf;
  final String? errorMessage;
  final String? requestNumber;

  const LeaveRequestState({
    this.status = LeaveRequestStatus.initial,
    this.leaveTypes = const [],
    this.employees = const [],
    this.appointments = const [],
    this.selectedLeaveTypeId,
    this.selectedAlternativeEmployeeId,
    this.startDate,
    this.endDate,
    this.attachmentName = '',
    this.attachmentBase64 = '',
    this.existingAttachments = const [],
    this.sequenceNumber = '',
    this.requestUnitHours = false,
    this.requestUnitHalf = false,
    this.errorMessage,
    this.requestNumber,
  });

  LeaveRequestState copyWith({
    LeaveRequestStatus? status,
    List<LeaveType>? leaveTypes,
    List<LeaveEmployee>? employees,
    List<LeaveAppointment>? appointments,
    int? selectedLeaveTypeId,
    int? selectedAlternativeEmployeeId,
    DateTime? startDate,
    DateTime? endDate,
    String? attachmentName,
    String? attachmentBase64,
    List<LeaveRequestEditAttachment>? existingAttachments,
    String? sequenceNumber,
    bool? requestUnitHours,
    bool? requestUnitHalf,
    String? errorMessage,
    String? requestNumber,
    bool clearAlternativeEmployee = false,
  }) {
    return LeaveRequestState(
      status: status ?? this.status,
      leaveTypes: leaveTypes ?? this.leaveTypes,
      employees: employees ?? this.employees,
      appointments: appointments ?? this.appointments,
      selectedLeaveTypeId: selectedLeaveTypeId ?? this.selectedLeaveTypeId,
      selectedAlternativeEmployeeId: clearAlternativeEmployee
          ? null
          : (selectedAlternativeEmployeeId ??
              this.selectedAlternativeEmployeeId),
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      attachmentName: attachmentName ?? this.attachmentName,
      attachmentBase64: attachmentBase64 ?? this.attachmentBase64,
      existingAttachments: existingAttachments ?? this.existingAttachments,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      requestUnitHours: requestUnitHours ?? this.requestUnitHours,
      requestUnitHalf: requestUnitHalf ?? this.requestUnitHalf,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  @override
  List<Object?> get props => [
        status,
        leaveTypes,
        employees,
        appointments,
        selectedLeaveTypeId,
        selectedAlternativeEmployeeId,
        startDate,
        endDate,
        attachmentName,
        attachmentBase64,
        existingAttachments,
        sequenceNumber,
        requestUnitHours,
        requestUnitHalf,
        errorMessage,
        requestNumber,
      ];
}
