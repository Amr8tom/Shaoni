import 'package:dartz/dartz.dart';
import 'package:shaoni/core/connection/checkNetwork.dart';
import 'package:shaoni/core/dio/dio_helper.dart';

import 'package:shaoni/core/error/failure.dart';

import 'package:shaoni/features/my-requests/domain/entities/request_with_stage.dart';

import 'package:shaoni/features/my-requests/domain/use_cases/get_all_user_requests_use_case.dart';

import '../../../domain/entities/all_requests_with_stages.dart';
import '../../../domain/repositories/repository.dart';
import '../data_sources/local_data_sources.dart';
import '../data_sources/remote_data_sources.dart';

class MyRequestsRepositoryImp extends MyRequestsRepository {
  final MyRequestsRemoteDataSources _remoteDataSources;
  final MyRequestsLocalDataSources _localDataSources;
  final NetworkInfo _networkInfo;

  MyRequestsRepositoryImp(
    this._remoteDataSources,
    this._localDataSources,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, AllRequestsWithStages>> getAllUserRequests({
    required GetAllUserRequestsParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final requests = await _remoteDataSources.getAllUserRequests(
          params: params,
        );
        await _localDataSources.cacheAllMyRequests(requests: requests);
        return Right(requests);
      } on ServerFailure {
        return Left(
          ServerFailure(
            message: ' ===================== Server Failure ===============',
          ),
        );
      }
    } else {
      try {
        final requests = await _localDataSources.getAllMyRequests();
        return Right(requests);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }
}
