part of 'my_requests_cubit.dart';

final class MyRequestsState extends Equatable {
  final MyRequestsStatus status;
  final RequestWithStage? requestDetails;
  final AllRequestsWithStages? userRequests;
  final AllRequestsWithStages? managerRequests;
  final AllRequestsWithStages? kafeelRequests;
  final List<RequestWithStage>
      itemsManager; // Keep this non-nullable with a default []
  final List<RequestWithStage>
      itemsUser; // Keep this non-nullable with a default []
  final List<RequestWithStage>
      itemsKafeel; // Keep this non-nullable with a default []
  final String? selectedServiceCode;

  const MyRequestsState({
    this.status = MyRequestsStatus.initialized,
    this.itemsUser = const [],
    this.itemsManager = const [],
    this.itemsKafeel = const [],
    this.userRequests,
    this.requestDetails,
    this.managerRequests,
    this.kafeelRequests,
    this.selectedServiceCode,
  });

  MyRequestsState copyWith({
    MyRequestsStatus? status,
    List<RequestWithStage>? itemsManager,
    List<RequestWithStage>? itemsUser,
    List<RequestWithStage>? itemsKafeel,
    AllRequestsWithStages? managerRequests,
    AllRequestsWithStages? kafeelRequests,
    AllRequestsWithStages? userRequests,
    RequestWithStage? requestDetails,
    String? selectedServiceCode,
  }) {
    return MyRequestsState(
      status: status ?? this.status,
      userRequests: userRequests ?? this.userRequests,
      managerRequests: managerRequests ?? this.managerRequests,
      kafeelRequests: kafeelRequests ?? this.kafeelRequests,
      itemsManager: itemsManager ?? this.itemsManager,
      itemsKafeel: itemsKafeel ?? this.itemsKafeel,
      requestDetails: requestDetails ?? this.requestDetails,
      itemsUser: itemsUser ?? this.itemsUser,
      selectedServiceCode: selectedServiceCode ?? this.selectedServiceCode,
    );
  }

  /// Getters for filtered items
  List<RequestWithStage> get filteredItemsUser {
    if (selectedServiceCode == null) return itemsUser;
    return itemsUser
        .where((item) => item.service?.nameEn == selectedServiceCode)
        .toList();
  }

  List<RequestWithStage> get filteredItemsManager {
    if (selectedServiceCode == null) return itemsManager;
    return itemsManager
        .where((item) => item.service?.nameEn == selectedServiceCode)
        .toList();
  }

  List<RequestWithStage> get filteredItemsKafeel {
    if (selectedServiceCode == null) return itemsKafeel;
    return itemsKafeel
        .where((item) => item.service?.nameEn == selectedServiceCode)
        .toList();
  }

  @override
  List<Object?> get props => [
        status,
        userRequests,
        managerRequests,
        kafeelRequests,
        itemsManager,
        itemsUser,
        itemsKafeel,
        requestDetails,
        selectedServiceCode,
      ];
}

enum MyRequestsStatus {
  initialized,
  loading,
  pageLoading,
  success,
  error,
  sendRequestLoading,
  sendRequestSuccess
}

extension MyRequestsStatusExtension on MyRequestsStatus {
  bool get isInitialized => this == MyRequestsStatus.initialized;

  bool get isLoading => this == MyRequestsStatus.loading;

  bool get isSuccess => this == MyRequestsStatus.success;

  bool get isPageLoading => this == MyRequestsStatus.pageLoading;
  bool get isSendRequestLoading => this == MyRequestsStatus.sendRequestLoading;
  bool get isSendRequestSuccess => this == MyRequestsStatus.sendRequestSuccess;

  bool get isError => this == MyRequestsStatus.error;
}
