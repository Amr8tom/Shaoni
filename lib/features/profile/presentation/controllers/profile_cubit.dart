import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shaoni/core/utils/enums/general_status.dart';
import 'package:shaoni/features/auth/domain/entities/user_entity.dart';
import 'package:shaoni/features/profile/domain/use_cases/update_profile_use_case.dart';

import 'package:shaoni/core/utils/helpers/string_normalizer.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileCubit({
    required this.updateProfileUseCase,
  }) : super(const ProfileState(status: GeneralStatus.initialized));

  Future updateProfile() async {
    emit(state.copyWith(status: GeneralStatus.loading));
    final result = await updateProfileUseCase.call(
        params: UpdateProfileParams(
            fullName: nameController.text,
            phoneNumber: numberController.text,
            nationalityId: state.nationality,
            cityId: state.city,
            genderId: state.gender));
    result.fold((failure) {
      emit(state.copyWith(status: GeneralStatus.error));
    }, (profile) {
      emit(state.copyWith(
          status: GeneralStatus.success, massage: profile.message));
    });
  }

  void initWithUser(UserEntity? user) {
    if (user == null) return;

    final int gender = StringNormalizer.isMale(user.gender) ? 1 : 2;
    final int nationality = StringNormalizer.isSaudi(user.nationality) ? 1 : 2;
    final int city = StringNormalizer.isJeddah(user.city) ? 1 : 2;

    emit(state.copyWith(
      gender: gender,
      nationality: nationality,
      city: city,
    ));

    nameController.text = user.fullName ?? "";
    numberController.text = user.phoneNumber ?? "";
    emailController.text = user.email ?? "";
  }

  void setGender(int value) {
    emit(state.copyWith(gender: value));
  }

  void setNationality(int value) {
    emit(state.copyWith(nationality: value));
  }

  void setCity(int value) {
    emit(state.copyWith(city: value));
  }
  @override
  Future<void> close() {
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    return super.close();
  }
}
