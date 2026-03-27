import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shaoni/features/navigation/domain/use_cases/get_user_data_use_case.dart';
import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/local_storage/cache_keys.dart';
import '../../../../core/utils/enums/general_status.dart';
import '../../../../core/utils/usecases/base_usecase.dart';

import '../../../auth/domain/entities/user_entity.dart';
import '../../../home/home_screen.dart';
import '../../../my-requests/presentation/screens/my_requests_screen.dart';
import '../../../my-services/presentation/screens/services_screen.dart';
import '../../../profile/profile_screen.dart';
import '../../domain/use_cases/get_count_unreaded_notification_use_case.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  // final GetCountUnreadedNotificationUseCase
  // _getCountUnreadedNotificationUseCase;
  final GetUserDataUseCase _getUserDataUseCase;

  NavigationCubit(this._getUserDataUseCase) : super(const NavigationState()) {
    getUserData(CacheHelper.getString(key: CacheKeys.userId));
    // isGuestMode() ? null :
    // GetCountUnreadedNotification();
  }

  int indx = 0;

  Future<void> getUserData(String? id) async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await _getUserDataUseCase.call(
      params: GetUserDataParams(id: id ?? "1"),
    );
    return result.fold(
      (failure) => emit(state.copyWith(status: GeneralStatus.error)),
      (user) => emit(state.copyWith(status: GeneralStatus.success, user: user)),
    );
  }

  void changeIndex(int index) {
    emit(state.copyWith(status: GeneralStatus.loading));
    indx = index;
    emit(state.copyWith(status: GeneralStatus.success));
  }

  // Future GetCountUnreadedNotification() async {
  //   final token = CacheHelper.getString(key: CacheKeys.token);
  //   if (token == null || token.trim() == '') {
  //     return;
  //   }
  //   emit(state.copyWith(status: GeneralStatus.loading));
  //   final result = await _getCountUnreadedNotificationUseCase.call(
  //     params: NoParams(),
  //   );
  //   return result.fold(
  //         (failure) => emit(state.copyWith(status: GeneralStatus.error)),
  //         (count) => emit(state.copyWith(notificationCount: count)),
  //   );
  // }
}
