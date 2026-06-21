import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/features/navigation/domain/use_cases/get_user_data_use_case.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../home/home_screen.dart';
import '../../../details_and_edit_for_requests/presentation/screens/my_requests_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../services/presentation/screens/all_categories_screen.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  final GetUserDataUseCase _getUserDataUseCase;
  final SessionStorage _sessionStorage;

  NavigationCubit(this._getUserDataUseCase, this._sessionStorage)
      : super(const NavigationState()) {
    getUserData(_sessionStorage.userId);
  }

  int indx = 0;

  Future<void> getUserData(String? id) async {
    // Sanitize: treat null, empty string, or the literal "null" as missing
    final String validId =
        (id == null || id.isEmpty || id == 'null') ? '1' : id;
    emit(state.copyWith(status: NavigationStatus.loading));
    final result = await _getUserDataUseCase.call(
      params: GetUserDataParams(id: validId),
    );
    return result.fold(
      (failure) => emit(state.copyWith(status: NavigationStatus.error)),
      (user) async {
        await _sessionStorage.saveEmployeeId(user.employeeId.toString());
        await _sessionStorage.saveUserName(user.fullName.toString());
        await _sessionStorage.saveOrganizationName(
          user.office?.name.toString() ?? '',
        );
        await _sessionStorage.saveDepartmentAddress(
          user.department?.nameAr.toString() ?? '',
        );
        await _sessionStorage.saveOffices(
          user.department?.nameAr.toString() ?? '',
        );
        await _sessionStorage.saveOfficesList(jsonEncode(user.officeIds
            ?.map((office) => {
                  'id': office.id,
                  'name': office.name,
                })
            .toList()));
        await _sessionStorage.saveJobNumber(user.jobNumber ?? '');
        await _sessionStorage.saveJobTitle(user.jobTitle ?? '');
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
