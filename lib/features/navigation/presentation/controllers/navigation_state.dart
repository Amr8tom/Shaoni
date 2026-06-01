part of 'navigation_cubit.dart';

@immutable
final class NavigationState extends Equatable {
  final NavigationStatus status;
  final int notificationCount;
  final bool isGuest;
  final UserEntity? user;
  final List<Widget> screens;

  const NavigationState({
    this.isGuest = false,
    this.status = NavigationStatus.initialized,
    this.notificationCount = 0,
    this.user,
    this.screens = const [
      HomeScreen(),
      AllCategoriesScreen(),
      MyRequestsScreen(),
      ProfileScreen(),
    ],
  });

  ///copyWith
  NavigationState copyWith({
    NavigationStatus? status,
    int? notificationCount,
    UserEntity? user,
    bool? isGuest,
    List<Widget>? screens,
  }) {
    return NavigationState(
      status: status ?? this.status,
      notificationCount: notificationCount ?? this.notificationCount,
      isGuest: isGuest ?? this.isGuest,
      screens: screens ?? this.screens,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    status,
    notificationCount,
    isGuest,
    screens,
    user,
  ];
}
