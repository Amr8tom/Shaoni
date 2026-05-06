part of 'attendance_cubit.dart';


final class AttendanceState extends Equatable {
  final AttendanceStatus status;
  final List<AttendanceRecord> records;
  final String? errorMessage;
  final String? successMessage;
  final String? requestNumber;

  const AttendanceState({
    this.status = AttendanceStatus.initialized,
    this.records = const [],
    this.errorMessage,
    this.successMessage,
    this.requestNumber,
  });

  AttendanceState copyWith({
    AttendanceStatus? status,
    List<AttendanceRecord>? records,
    String? errorMessage,
    String? successMessage,
    String? requestNumber,
  }) {
    return AttendanceState(
      status: status ?? this.status,
      records: records ?? this.records,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }

  @override
  List<Object?> get props => [status, records, errorMessage,successMessage,requestNumber];
}
/// Lifecycle of the Attendance list screen.
enum AttendanceStatus {
  initialized,
  forgetLoading,
  lookupsLoading,
  forgetError,
  lookupsError,
  forgetLoaded,
  lookupsLoaded,
  loading,
  createAttendanceRequestLoading,
  createAttendanceRequestLoaded,
  loaded,
  empty,
  error,
}

/// Convenience getters used by the UI to decide which subtree to render
/// (matches the project's existing `*StateExtension` style).
extension AttendanceStateExtension on AttendanceState {
  bool get isInitialized => status == AttendanceStatus.initialized;

  bool get isLoading => status == AttendanceStatus.loading;

  bool get isForgetLoading => status == AttendanceStatus.forgetLoading;

  bool get isLookupsLoading => status == AttendanceStatus.lookupsLoading;

  bool get isCreateAttendanceRequestLoading =>
      status == AttendanceStatus.createAttendanceRequestLoading;

  bool get isCreateAttendanceRequestLoaded =>
      status == AttendanceStatus.createAttendanceRequestLoaded;

  bool get isSuccess => status == AttendanceStatus.loaded;

  bool get isForgetSuccess => status == AttendanceStatus.forgetLoaded;

  bool get isLookupSuccess => status == AttendanceStatus.lookupsLoaded;

  bool get isEmpty => status == AttendanceStatus.empty;

  bool get isForgetError => status == AttendanceStatus.forgetError;
  bool get isLookupError => status == AttendanceStatus.lookupsError;
  bool get isError => status == AttendanceStatus.error;
}
