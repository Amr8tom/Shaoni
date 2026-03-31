part of 'my_requests_cubit.dart';

final class MyRequestsState extends Equatable {
  final GeneralStatus status;
  final AllRequestsWithStages? requests;

  const MyRequestsState({
    this.status = GeneralStatus.initialized,
    this.requests,
  });

  /// copy with
  MyRequestsState copyWith({
    GeneralStatus? status,
    AllRequestsWithStages? requests,
  }) {
    return MyRequestsState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
    );
  }

  @override
  List<Object?> get props => [status, requests];
}
