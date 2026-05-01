part of 'attendance_cubit.dart';

/// Lifecycle of the Attendance list screen.
enum AttendanceStatus {
  initialized,
  loading,
  loaded,
  empty,
  error,
}

/// Convenience getters used by the UI to decide which subtree to render
/// (matches the project's existing `*StateExtension` style).
extension AttendanceStateExtension on AttendanceState {
  bool get isInitialized => status == AttendanceStatus.initialized;
  bool get isLoading => status == AttendanceStatus.loading;
  bool get isLoaded => status == AttendanceStatus.loaded;
  bool get isEmpty => status == AttendanceStatus.empty;
  bool get isError => status == AttendanceStatus.error;
}

final class AttendanceState extends Equatable {
  final AttendanceStatus status;
  final List<AttendanceRecord> records;
  final String? errorMessage;

  const AttendanceState({
    this.status = AttendanceStatus.initialized,
    this.records = const [],
    this.errorMessage,
  });

  AttendanceState copyWith({
    AttendanceStatus? status,
    List<AttendanceRecord>? records,
    String? errorMessage,
  }) {
    return AttendanceState(
      status: status ?? this.status,
      records: records ?? this.records,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, records, errorMessage];
}
