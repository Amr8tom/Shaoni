import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/local_storage/cache_keys.dart';
import '../../../../core/utils/enums/general_status.dart';
import '../../../../core/utils/usecases/base_usecase.dart';

import '../../../home/home_screen.dart';
import '../../../my-orders/presentation/screens/my_order_screen.dart';
import '../../../my-services/presentation/screens/services_screen.dart';
import '../../../profile/profile_screen.dart';
import '../../domain/use_cases/get_count_unreaded_notification_use_case.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  final GetCountUnreadedNotificationUseCase
  _getCountUnreadedNotificationUseCase;

  NavigationCubit(this._getCountUnreadedNotificationUseCase)
      : super(const NavigationState()) {
    // isGuestMode() ? null :
    GetCountUnreadedNotification();
  }

  int indx = 0;

  // bool isGuestMode() {
  //   final token = CacheHelper.getString(key: CacheKeys.token);
  //
  //   if (token == null || token.trim() == '') {
  //     emit(
  //       state.copyWith(
  //         status: GeneralStatus.initialized,
  //         isGuest: true,
  //         screens: const [
  //           GuestRegistrationPrompt(),
  //           GuestRegistrationPrompt(),
  //           GuestRegistrationPrompt(),
  //           GuestRegistrationPrompt(),
  //           // HomeScreen(),
  //         ],
  //       ),
  //     );
  //
  //     return true;
  //   } else {
  //     emit(state.copyWith(
  //       status: GeneralStatus.success,
  //       isGuest: false,
  //       screens: const [
  //         // MealsScreen(),
  //         // GroupsScreen(),
  //         // ResidencesScreen(),
  //         // ProfileScreen(),
  //         // HomeScreen(),
  //       ],
  //     ),);
  //     return false;
  //   }
  // }

  void changeIndex(int index) {
    emit(state.copyWith(status: GeneralStatus.loading));
    indx = index;
    emit(state.copyWith(status: GeneralStatus.success));
  }

  Future GetCountUnreadedNotification() async {
    final token = CacheHelper.getString(key: CacheKeys.token);
    if (token == null || token.trim() == '') {
      return;
    }
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await _getCountUnreadedNotificationUseCase.call(
      params: NoParams(),
    );
    return result.fold(
          (failure) => emit(state.copyWith(status: GeneralStatus.error)),
          (count) => emit(state.copyWith(notificationCount: count)),
    );
  }
}
