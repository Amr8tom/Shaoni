import 'package:dartz/dartz.dart';

import 'package:shaoni/core/error/failure.dart';

import 'package:shaoni/features/profile/domain/entities/profile.dart';
import 'package:shaoni/features/profile/domain/use_cases/update_profile_use_case.dart';

import '../../../../core/connection/checkNetwork.dart';
import '../../domain/repositories/repository.dart';
import '../data_sources/remote_data_sources.dart';

class ProfileRepositoryImp extends ProfileRepository{
  final ProfileRemoteDataSources _remoteDataSources;
  final NetworkInfo _networkInfo;
  ProfileRepositoryImp(this._remoteDataSources, this._networkInfo);
  @override
  Future<Either<Failure, Profile>> updateProfile({required UpdateProfileParams params}) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSources.updateProfile(params: params);
        return Right(response);
        } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }

    }else{
      return Left(CacheFailure());
    }

  }
}