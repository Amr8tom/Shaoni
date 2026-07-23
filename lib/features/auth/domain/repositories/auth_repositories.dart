import 'package:dartz/dartz.dart';
import 'package:shaoni/features/auth/domain/entities/login.dart';
import '../../../../core/error/failure.dart';
import '../entities/new_password.dart';
import '../entities/otp_response.dart';
import '../usecases/change_password_use_case.dart';
import '../usecases/login_use_case.dart';
import '../usecases/request_otp_use_case.dart';
import '../usecases/verify_otp_use_case.dart';

abstract class AuthRepositories {
  /// login an existing
  Future<Either<Failure, LoginEntity>> login({
    required LoginParams params,
  });

  /// change password
  Future<Either<Failure, NewPassword>> changePassword({
    required NewPasswordParams params,
  });

  /// mail a verification code to the user
  Future<Either<Failure, OtpResponse>> requestOtp({
    required RequestOtpParams params,
  });

  /// validate the code the user typed
  Future<Either<Failure, OtpResponse>> verifyOtp({
    required VerifyOtpParams params,
  });
}
