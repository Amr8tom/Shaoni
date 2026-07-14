part of 'home_cubit.dart';

final class HomeState extends Equatable {
  final GeneralStatus status;
  final UserEntity? user;
  final List<AllStatusCount>? allStatusCounts;
  final Map<String, String>? requestsStatus;
  final AnnualLeaveBalance? annualLeaveBalance;

  const HomeState({
    this.status = GeneralStatus.initialized,
    this.requestsStatus,
    this.user,
    this.allStatusCounts,
    this.annualLeaveBalance,
  });

  /// copyWith method
  HomeState copyWith({
    GeneralStatus? status,
    UserEntity? user,
    List<AllStatusCount>? allStatusCounts,
    Map<String, String>? requestsStatus,
    AnnualLeaveBalance? annualLeaveBalance,
  }) {
    return HomeState(
      status: status ?? this.status,
      user: user ?? this.user,
      allStatusCounts: allStatusCounts ?? this.allStatusCounts,
      requestsStatus: requestsStatus ?? this.requestsStatus,
      annualLeaveBalance: annualLeaveBalance ?? this.annualLeaveBalance,
    );
  }

  @override
  List<Object?> get props => [
        status,
        requestsStatus,
        user,
        allStatusCounts,
        annualLeaveBalance,
      ];
}
