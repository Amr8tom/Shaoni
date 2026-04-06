part of 'my_requests_cubit.dart';

final class MyRequestsState extends Equatable {
  final MyRequestsStatus status;
  final AllRequestsWithStages? requests;
  final List<RequestWithStage>
      itemsManager; // Keep this non-nullable with a default []
  final List<RequestWithStage>
      itemsUser; // Keep this non-nullable with a default []

  const MyRequestsState({
    this.status = MyRequestsStatus.initialized,
    this.itemsUser = const [], // Default to empty list
    this.itemsManager = const [], // Default to empty list
    this.requests,
  });

  MyRequestsState copyWith({
    MyRequestsStatus? status,
    List<RequestWithStage>? itemsManager, // Nullable here
    List<RequestWithStage>? itemsUser, // Nullable here
    AllRequestsWithStages? requests,
  }) {
    return MyRequestsState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      itemsManager: itemsManager ?? this.itemsManager,
      // Only replaces if you explicitly pass a new list
      itemsUser: itemsUser ??
          this.itemsUser, // Only replaces if you explicitly pass a new list
    );
  }

  @override
  List<Object?> get props => [status, requests, itemsManager, itemsUser];
}

enum MyRequestsStatus { initialized, loading, pageLoading, success, error }

extension MyRequestsStatusExtension on MyRequestsStatus {
  bool get isInitialized => this == MyRequestsStatus.initialized;

  bool get isLoading => this == MyRequestsStatus.loading;

  bool get isSuccess => this == MyRequestsStatus.success;

  bool get isPageLoading => this == MyRequestsStatus.pageLoading;

  bool get isError => this == MyRequestsStatus.error;
}
