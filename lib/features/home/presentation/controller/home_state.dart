part of 'home_cubit.dart';

final class HomeState extends Equatable {
  final GeneralStatus status;
  final UserEntity? user;
  final List<AllStatusCount>? allStatusCounts;

  const HomeState({
    this.status = GeneralStatus.initialized,
    this.user,
    this.allStatusCounts,
  });

  /// copyWith method
  HomeState copyWith({
    GeneralStatus? status,
    UserEntity? user,
    List<AllStatusCount>? allStatusCounts,
  }) {
    return HomeState(
      status: status ?? this.status,
      user: user ?? this.user,
      allStatusCounts: allStatusCounts ?? this.allStatusCounts,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        allStatusCounts,
      ];
}
