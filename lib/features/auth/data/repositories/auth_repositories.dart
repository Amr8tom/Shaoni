import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/auth/domain/entities/login.dart';
import 'package:shaoni/features/auth/domain/repositories/auth_repositories.dart';
import 'package:shaoni/features/auth/domain/usecases/login_use_case.dart';

import '../../../../core/connection/checkNetwork.dart';
import '../data_sources/remote_data_sources.dart';

class AuthRepositoriesImp implements AuthRepositories{
  final AuthRemoteDataSources _remoteDataSources;
  final NetworkInfo _networkInfo;


  const AuthRepositoriesImp(this._remoteDataSources, this._networkInfo);


  @override
  Future<Either<Failure, LoginEntity>> login({required LoginParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSources.login(params: params);
        print(result);
        return Right(result);
      } on ServerFailure catch (e) {
        return left( ServerFailure(message: "server failure"));
      }
    } else {
      return Left(CacheFailure());
    }
  }



  }
