part of 'attendance_cubit.dart';

final class AttendanceState extends Equatable {
  final AttendanceStatus status;

  const AttendanceState({this.status = AttendanceStatus.initialized});

  AttendanceState copyWith({AttendanceStatus? status}) {
    return AttendanceState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}

extension AttendanceStateExtension on AttendanceState {
  bool get isLoading => status == AttendanceStatus.faqLoading;

  bool get isLoaded => status == AttendanceStatus.faqLoaded;

  bool get isError => status == AttendanceStatus.faqError;

  bool get isFilterSearching => status == AttendanceStatus.filterSearching;

  bool get isFilterSearched => status == AttendanceStatus.filterSearched;

  bool get isFilterEmpty => status == AttendanceStatus.filterEmpty;

  bool get isExpanded => status == AttendanceStatus.expanded;

  bool get isPermissionTimeLoading =>
      status == AttendanceStatus.permissionTimeLoading;

  bool get isPermissionTimeError =>
      status == AttendanceStatus.permissionTimeError;

  bool get isPermissionTimeSuccess =>
      status == AttendanceStatus.permissionTimeSuccess;

  bool get isPermissionTypesLoading =>
      status == AttendanceStatus.permissionTypesLoading;

  bool get isPermissionTypesError =>
      status == AttendanceStatus.permissionTypesError;

  bool get isPermissionTypesSuccess =>
      status == AttendanceStatus.permissionTypesSuccess;

  bool get isInitialized => status == AttendanceStatus.initialized;

  bool get isCreateExitPermissionLoading =>
      status == AttendanceStatus.createExitPermissionLoading;

  bool get isCreateExitPermissionError =>
      status == AttendanceStatus.createExitPermissionError;

  bool get isCreateExitPermissionSuccess =>
      status == AttendanceStatus.createExitPermissionSuccess;
}

enum AttendanceStatus {
  initialized,
  faqLoading,
  faqLoaded,
  filterSearching,
  filterSearched,
  filterEmpty,
  faqError,
  permissionTypesError,
  permissionTimeError,
  permissionTimeLoading,
  permissionTypesLoading,
  createExitPermissionLoading,
  permissionTimeSuccess,
  permissionTypesSuccess,
  createExitPermissionSuccess,
  createExitPermissionError,
  expanded,
}
