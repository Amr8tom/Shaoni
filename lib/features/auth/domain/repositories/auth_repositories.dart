import 'package:dartz/dartz.dart';
import 'package:shaoni/features/auth/domain/entities/login.dart';
import '../../../../core/error/failure.dart';
import '../entities/new_password.dart';
import '../usecases/change_password_use_case.dart';
import '../usecases/login_use_case.dart';

abstract class AuthRepositories {
  /// login an existing
  Future<Either<Failure, LoginEntity>> login({
    required LoginParams params,
  });

  /// change password
  Future<Either<Failure, NewPassword>> changePassword({
    required NewPasswordParams params,
  });
}
