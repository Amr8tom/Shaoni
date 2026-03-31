part of 'request_service_cubit.dart';

extension RequestStateExtension on RequestServiceState {
  bool get isLoading => status == RequestStatus.faqLoading;

  bool get isLoaded => status == RequestStatus.faqLoaded;

  bool get isError => status == RequestStatus.faqError;

  bool get isFilterSearching => status == RequestStatus.filterSearching;

  bool get isFilterSearched => status == RequestStatus.filterSearched;

  bool get isFilterEmpty => status == RequestStatus.filterEmpty;

  bool get isExpanded => status == RequestStatus.expanded;
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
  permissionTimeSuccess,
  permissionTypesSuccess,
  expanded,
}

final class RequestServiceState extends Equatable {
  final RequestStatus status;
  final List<RequestServicesEntity> services;
  final List<RequestServicesEntity> filteredServices;
  final List<PermissionType> permissionTypes;
  final List<PermissionTime> permissionTimes;
  final int? expandedIndex;

  const RequestServiceState({
    this.status = RequestStatus.initialized,
    this.services = const [],
    this.filteredServices = const [],
    this.expandedIndex,
    this.permissionTypes = const [],
    this.permissionTimes = const [],
  });

  RequestServiceState copyWith({
    RequestStatus? status,
    List<RequestServicesEntity>? services,
    List<RequestServicesEntity>? filteredServices,
    int? expandedIndex,
    bool clearExpandedIndex = false,
    List<PermissionType>? permissionTypes,
    List<PermissionTime>? permissionTimes,
  }) {
    return RequestServiceState(
      status: status ?? this.status,
      services: services ?? this.services,
      filteredServices: filteredServices ?? this.filteredServices,
      expandedIndex:
          clearExpandedIndex ? null : (expandedIndex ?? this.expandedIndex),
      permissionTypes: permissionTypes ?? this.permissionTypes,
      permissionTimes: permissionTimes ?? this.permissionTimes,
    );
  }

  @override
  List<Object?> get props => [
    status,
    services,
    filteredServices,
    expandedIndex,
    permissionTypes,
    permissionTimes,
  ];
}
