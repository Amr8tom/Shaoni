part of 'my_requests_cubit.dart';

final class MyRequestsState extends Equatable {
  final MyRequestsStatus status;
  final RequestWithStage? requestDetails;
  final AllRequestsWithStages? userRequests;
  final AllRequestsWithStages? managerRequests;
  final List<RequestWithStage>
      itemsManager; // Keep this non-nullable with a default []
  final List<RequestWithStage>
      itemsUser; // Keep this non-nullable with a default []

  const MyRequestsState({
    this.status = MyRequestsStatus.initialized,
    this.itemsUser = const [], // Default to empty list
    this.itemsManager = const [], // Default to empty list
    this.userRequests,
    this.requestDetails,
    this.managerRequests,
  });

  MyRequestsState copyWith({
    MyRequestsStatus? status,
    List<RequestWithStage>? itemsManager, // Nullable here
    List<RequestWithStage>? itemsUser, // Nullable here
    AllRequestsWithStages? managerRequests,
    AllRequestsWithStages? userRequests,
    RequestWithStage? requestDetails,
  }) {
    return MyRequestsState(
      status: status ?? this.status,
      userRequests: userRequests ?? this.userRequests,
      managerRequests: managerRequests ?? this.managerRequests,
      itemsManager: itemsManager ?? this.itemsManager,
      requestDetails: requestDetails ?? this.requestDetails,
      // Only replaces if you explicitly pass a new list
      itemsUser: itemsUser ??
          this.itemsUser, // Only replaces if you explicitly pass a new list
    );
  }

  @override
  List<Object?> get props => [status, userRequests,managerRequests, itemsManager, itemsUser, requestDetails];
}

enum MyRequestsStatus { initialized, loading, pageLoading, success, error, sendRequestLoading,sendRequestSuccess }

extension MyRequestsStatusExtension on MyRequestsStatus {
  bool get isInitialized => this == MyRequestsStatus.initialized;

  bool get isLoading => this == MyRequestsStatus.loading;

  bool get isSuccess => this == MyRequestsStatus.success;

  bool get isPageLoading => this == MyRequestsStatus.pageLoading;
  bool get isSendRequestLoading => this == MyRequestsStatus.sendRequestLoading;
  bool get isSendRequestSuccess => this == MyRequestsStatus.sendRequestSuccess;

  bool get isError => this == MyRequestsStatus.error;
}
