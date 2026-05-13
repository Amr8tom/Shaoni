part of 'exit_request_service_cubit.dart';

extension ExitRequestStateExtension on ExitRequestServiceState {
  bool get isLoading => status == RequestStatus.faqLoading;

  bool get isLoaded => status == RequestStatus.faqLoaded;

  bool get isError => status == RequestStatus.faqError;

  bool get isFilterSearching => status == RequestStatus.filterSearching;

  bool get isFilterSearched => status == RequestStatus.filterSearched;

  bool get isFilterEmpty => status == RequestStatus.filterEmpty;

  bool get isExpanded => status == RequestStatus.expanded;

  bool get isPermissionTimeLoading =>
      status == RequestStatus.permissionTimeLoading;

  bool get isPermissionTimeError => status == RequestStatus.permissionTimeError;

  bool get isPermissionTimeSuccess =>
      status == RequestStatus.permissionTimeSuccess;

  bool get isPermissionTypesLoading =>
      status == RequestStatus.permissionTypesLoading;

  bool get isPermissionTypesError =>
      status == RequestStatus.permissionTypesError;

  bool get isPermissionTypesSuccess =>
      status == RequestStatus.permissionTypesSuccess;

  bool get isInitialized => status == RequestStatus.initialized;

  bool get isCreateExitPermissionLoading =>
      status == RequestStatus.createExitPermissionLoading;

  bool get isCreateExitPermissionError =>
      status == RequestStatus.createExitPermissionError;

  bool get isCreateExitPermissionSuccess =>
      status == RequestStatus.createExitPermissionSuccess;

  bool get isUpdateExitPermissionLoading =>
      status == RequestStatus.updateExitPermissionLoading;

  bool get isUpdateExitPermissionError =>
      status == RequestStatus.updateExitPermissionError;

  bool get isUpdateExitPermissionSuccess =>
      status == RequestStatus.updateExitPermissionSuccess;

  bool get isSubmitting =>
      status == RequestStatus.createExitPermissionLoading ||
      status == RequestStatus.updateExitPermissionLoading;

  bool get isSubmitSucceeded =>
      status == RequestStatus.createExitPermissionSuccess ||
      status == RequestStatus.updateExitPermissionSuccess;

  bool get isSubmitFailed =>
      status == RequestStatus.createExitPermissionError ||
      status == RequestStatus.updateExitPermissionError;
}

enum RequestStatus {
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
  updateExitPermissionLoading,
  updateExitPermissionSuccess,
  updateExitPermissionError,
  expanded,
}

final class ExitRequestServiceState extends Equatable {
  final RequestStatus status;
  final ExitPermission? successPermission;
  final List<RequestServicesEntity> services;
  final List<RequestServicesEntity> filteredServices;
  final List<PermissionType> permissionTypes;
  final List<PermissionTime> permissionTimes;
  final int? expandedIndex;
  final String? errorMassage;

  const ExitRequestServiceState(
      {this.status = RequestStatus.initialized,
      this.services = const [],
      this.filteredServices = const [],
      this.expandedIndex,
      this.successPermission,
      this.permissionTypes = const [],
      this.permissionTimes = const [],
      this.errorMassage});

  ExitRequestServiceState copyWith(
      {RequestStatus? status,
      List<RequestServicesEntity>? services,
      List<RequestServicesEntity>? filteredServices,
      int? expandedIndex,
      ExitPermission? successPermission,
      bool clearExpandedIndex = false,
      List<PermissionType>? permissionTypes,
      List<PermissionTime>? permissionTimes,
      String? errorMessage}) {
    return ExitRequestServiceState(
        status: status ?? this.status,
        services: services ?? this.services,
        successPermission: successPermission ?? this.successPermission,
        filteredServices: filteredServices ?? this.filteredServices,
        expandedIndex:
            clearExpandedIndex ? null : (expandedIndex ?? this.expandedIndex),
        permissionTypes: permissionTypes ?? this.permissionTypes,
        permissionTimes: permissionTimes ?? this.permissionTimes,
        errorMassage: errorMessage ?? this.errorMassage);
  }

  @override
  List<Object?> get props => [
        status,
        services,
        filteredServices,
        expandedIndex,
        successPermission,
        permissionTypes,
        permissionTimes,
        errorMassage,
      ];
}
