part of 'navigation_cubit.dart';

@immutable
final class NavigationState  extends Equatable{
  final GeneralStatus status;
  final int notificationCount;
  final bool isGuest;
 final List<Widget> screens ;

  const NavigationState({
    this.isGuest=false,
    this.status = GeneralStatus.initialized,
    this.notificationCount = 0,
    this.screens =const [
      HomeScreen(),
      ServicesScreen(),
      MyRequestsScreen(),
      ProfileScreen(),
    ]
  });
  ///copyWith
  NavigationState copyWith({
    GeneralStatus? status,
    int? notificationCount,
    bool ? isGuest,
    List<Widget> ? screens,
  }) {
    return NavigationState(
      status: status ?? this.status,
      notificationCount: notificationCount ?? this.notificationCount,
      isGuest: isGuest ?? this.isGuest,
      screens: screens??this.screens

    );
  }

  @override
  List<Object?> get props =>[status,notificationCount,isGuest,screens];
}


