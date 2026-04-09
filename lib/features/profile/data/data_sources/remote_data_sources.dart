import 'package:shaoni/core/constants/api_constants.dart';
import 'package:shaoni/core/dio/dio_helper.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/profile/domain/entities/profile.dart';
import 'package:shaoni/features/profile/domain/use_cases/update_profile_use_case.dart';

import '../model/profile_model.dart';

abstract class ProfileRemoteDataSources {
  Future<Profile> updateProfile({required UpdateProfileParams params});
}

class ProfileRemoteDataSourcesImpl implements ProfileRemoteDataSources {
  final DioHelper _dioHelper;

  ProfileRemoteDataSourcesImpl(this._dioHelper);

  @override
  Future<Profile> updateProfile({required UpdateProfileParams params}) async {
    try {
      final response = await _dioHelper.putData(
          URL: URL.updateProfile, body: params.toMap());
      if (response != null) {
        return ProfileModel.fromJson(response.data);
      } else {
        throw ServerFailure(message: "server error");
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}
