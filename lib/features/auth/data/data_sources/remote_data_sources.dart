import 'package:shaoni/core/constants/api_constants.dart';
import 'package:shaoni/core/dio/dio_helper.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/auth/data/model/login_model.dart';
import 'package:shaoni/features/auth/data/model/new_password_model.dart';
import 'package:shaoni/features/auth/data/model/otp_response_model.dart';
import 'package:shaoni/features/auth/domain/entities/login.dart';
import 'package:shaoni/features/auth/domain/entities/new_password.dart';
import 'package:shaoni/features/auth/domain/entities/otp_response.dart';

import '../../domain/usecases/change_password_use_case.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/request_otp_use_case.dart';
import '../../domain/usecases/verify_otp_use_case.dart';

abstract class AuthRemoteDataSources {
  /// login
  Future<LoginEntity> login({required LoginParams params});

  /// change password
  Future<NewPassword> changePassword({required NewPasswordParams params});

  /// request a verification code by e-mail
  Future<OtpResponse> requestOtp({required RequestOtpParams params});

  /// verify a code the user typed
  Future<OtpResponse> verifyOtp({required VerifyOtpParams params});
}

class AuthRemoteDataSourcesImp implements AuthRemoteDataSources {
  final DioHelper _dio;

  const AuthRemoteDataSourcesImp(this._dio);

  @override
  Future<LoginEntity> login({required LoginParams params}) async {
    try {
      final reponse =
          await _dio.postData(url: URL.login, body: params.toJson());
      if (reponse != null) {
        return LoginModel.fromJson(reponse);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<NewPassword> changePassword(
      {required NewPasswordParams params}) async {
    try {
      final reponse =
          await _dio.postData(url: URL.changePassword, body: params.toJson());
      if (reponse != null) {
        return NewPasswordModel.fromJson(reponse);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<OtpResponse> requestOtp({required RequestOtpParams params}) async {
    try {
      final response =
          await _dio.postData(url: URL.requestOtp, body: params.toJson());
      if (response != null) {
        return OtpResponseModel.fromJson(response);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<OtpResponse> verifyOtp({required VerifyOtpParams params}) async {
    try {
      final response =
          await _dio.postData(url: URL.verifyOtp, body: params.toJson());
      if (response != null) {
        return OtpResponseModel.fromJson(response);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}
