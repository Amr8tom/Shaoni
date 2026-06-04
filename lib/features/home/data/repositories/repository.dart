import 'package:dartz/dartz.dart';
import 'package:shaoni/core/connection/check_network.dart';

import 'package:shaoni/core/error/failure.dart';

import 'package:shaoni/features/home/data/data_sources/remote_data_sources.dart';
import 'package:shaoni/features/home/domain/entities/all_status_count.dart';

import '../../../../core/utils/usecases/base_usecase.dart';
import '../../domain/repositories/home_repositories.dart';

class HomeRepositoriesImp extends HomeRepositories {
  final HomeRemoteDataSources _remoteDataSources;
  final NetworkInfo _networkInfo;

  HomeRepositoriesImp(this._remoteDataSources, this._networkInfo);

  @override
  Future<Either<Failure, List<AllStatusCount>>> getAllStatusCountForAllServices(
      {required NoParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSources.getAllStatusCountForAllServices();
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
