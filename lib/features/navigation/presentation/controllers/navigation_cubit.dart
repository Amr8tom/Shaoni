import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shaoni/features/navigation/domain/use_cases/get_user_data_use_case.dart';
import '../../../../core/local_storage/cache_helper.dart';
import '../../../../core/local_storage/cache_keys.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../home/home_screen.dart';
import '../../../details_and_edit_for_requests/presentation/screens/my_requests_screen.dart';
import '../../../profile/profile_screen.dart';
import '../../../services/presentation/screens/all_categories_screen.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  final GetUserDataUseCase _getUserDataUseCase;

  NavigationCubit(this._getUserDataUseCase) : super(const NavigationState()) {
    getUserData(CacheHelper.getString(key: CacheKeys.userId));
  }

  int indx = 0;

  Future<void> getUserData(String? id) async {
    emit(state.copyWith(status: NavigationStatus.loading));
    final result = await _getUserDataUseCase.call(
      params: GetUserDataParams(id: id ?? "1"),
    );
    return result.fold(
      (failure) => emit(state.copyWith(status: NavigationStatus.error)),
      (user) async {
        await CacheHelper.putString(
            key: CacheKeys.employeeId, value: user.employeeId.toString());
        await CacheHelper.putString(
            key: CacheKeys.userName, value: user.fullName.toString());
        await CacheHelper.putString(
            key: CacheKeys.organizationName,
            value: user.office?.name.toString() ?? '');
        await CacheHelper.putString(
            key: CacheKeys.departmentAddress,
            value: user.department?.nameAr.toString() ?? '');
        await CacheHelper.putString(
            key: CacheKeys.offices,
            value: user.department?.nameAr.toString() ?? '');
        await CacheHelper.putString(
            key: CacheKeys.officesList,
            value: jsonEncode(user.officeIds?.map((o) => o.toJson()).toList()));
        emit(state.copyWith(status: NavigationStatus.success, user: user));
      },
    );
  }

  void changeIndex(int index) {
    emit(state.copyWith(status: NavigationStatus.loading));
    indx = index;
    emit(state.copyWith(status: NavigationStatus.indexChanged));
  }
}

enum NavigationStatus { initialized, indexChanged, loading, success, error }

extension NavigationStatusExtension on NavigationStatus {
  bool get isInitialized => this == NavigationStatus.initialized;

  bool get isLoading => this == NavigationStatus.loading;

  bool get isSuccess => this == NavigationStatus.success;

  bool get isIndexChanged => this == NavigationStatus.indexChanged;

  bool get isError => this == NavigationStatus.error;
}
