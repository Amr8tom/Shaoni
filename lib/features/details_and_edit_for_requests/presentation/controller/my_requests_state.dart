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

  const MyRequestsState({
    this.status = MyRequestsStatus.initialized,
    this.itemsUser = const [],
    this.itemsManager = const [],
    this.itemsKafeel = const [],
    this.userRequests,
    this.requestDetails,
    this.managerRequests,
    this.kafeelRequests,
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
    );
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
        requestDetails
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
