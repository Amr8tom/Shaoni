part of 'start_work_cubit.dart';

enum StartWorkStatus {
  initialized,
  lookupsLoading,
  lookupsLoaded,
  lookupsError,
  createLoading,
  createLoaded,
  createError,
}

/// The extra field shown under the type dropdown, derived from the selected
/// start-work type.
enum StartWorkFieldKind {
  none,
  contract, // hr_contract_id  (dropdown)
  taskManagement, // task_management_id (dropdown)
  leaveType, // holiday_status_id (dropdown)
  employeeTransfer, // employee_transfer (text)
  jobTitleModification, // job_title_modification (text)
  endLoanPeriod, // end_loan_period (date → string)
  extendWorkingPeriod, // extend_employee_working_period (text)
}

extension StartWorkStateExtension on StartWorkState {
  bool get isInitialized => status == StartWorkStatus.initialized;
  bool get isLookupsLoading => status == StartWorkStatus.lookupsLoading;
  bool get isLookupsLoaded => status == StartWorkStatus.lookupsLoaded;
  bool get isLookupsError => status == StartWorkStatus.lookupsError;
  bool get isCreateLoading => status == StartWorkStatus.createLoading;
  bool get isCreateLoaded => status == StartWorkStatus.createLoaded;
  bool get isCreateError => status == StartWorkStatus.createError;
}

final class StartWorkState extends Equatable {
  final StartWorkStatus status;
  final String? errorMessage;
  final String? requestNumber;

  /// Drives the conditional-field UI. Bumped on type/employee selection and
  /// after each conditional lookup resolves, so the form rebuilds reliably.
  final int? selectedTypeId;
  final int? selectedEmployeeId;
  final bool conditionalLoading;
  final int conditionalVersion;

  const StartWorkState({
    this.status = StartWorkStatus.initialized,
    this.errorMessage,
    this.requestNumber,
    this.selectedTypeId,
    this.selectedEmployeeId,
    this.conditionalLoading = false,
    this.conditionalVersion = 0,
  });

  StartWorkState copyWith({
    StartWorkStatus? status,
    String? errorMessage,
    String? requestNumber,
    int? selectedTypeId,
    int? selectedEmployeeId,
    bool? conditionalLoading,
    int? conditionalVersion,
  }) {
    return StartWorkState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      requestNumber: requestNumber ?? this.requestNumber,
      selectedTypeId: selectedTypeId ?? this.selectedTypeId,
      selectedEmployeeId: selectedEmployeeId ?? this.selectedEmployeeId,
      conditionalLoading: conditionalLoading ?? this.conditionalLoading,
      conditionalVersion: conditionalVersion ?? this.conditionalVersion,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        requestNumber,
        selectedTypeId,
        selectedEmployeeId,
        conditionalLoading,
        conditionalVersion,
      ];
}
