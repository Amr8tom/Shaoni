import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/auth/domain/entities/login.dart';
import 'package:shaoni/features/auth/domain/entities/new_password.dart';
import 'package:shaoni/features/auth/domain/repositories/auth_repositories.dart';
import 'package:shaoni/features/auth/domain/usecases/change_password_use_case.dart';
import 'package:shaoni/features/auth/domain/usecases/login_use_case.dart';

import '../../../../core/connection/check_network.dart';
import '../data_sources/remote_data_sources.dart';

class AuthRepositoriesImp implements AuthRepositories {
  final AuthRemoteDataSources _remoteDataSources;
  final NetworkInfo _networkInfo;

  const AuthRepositoriesImp(this._remoteDataSources, this._networkInfo);

  @override
  Future<Either<Failure, LoginEntity>> login(
      {required LoginParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSources.login(params: params);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, NewPassword>> changePassword(
      {required NewPasswordParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSources.changePassword(params: params);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(e);
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
