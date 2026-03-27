part of 'home_cubit.dart';

final class HomeState extends Equatable {
  final GeneralStatus status;
  final UserEntity? user;

  const HomeState({
    this.status = GeneralStatus.initialized,
    this.user,

  });

  /// copyWith method
  HomeState copyWith({
    GeneralStatus? status,
    UserEntity? user,

  }) {
    return HomeState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    status,
    user,
  ];
}
