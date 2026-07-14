import 'package:dartz/dartz.dart';
import 'package:shaoni/core/connection/check_network.dart';

import 'package:shaoni/core/error/failure.dart';

import 'package:shaoni/features/home/data/data_sources/local_data_sources.dart';
import 'package:shaoni/features/home/data/data_sources/remote_data_sources.dart';
import 'package:shaoni/features/home/domain/entities/all_status_count.dart';
import 'package:shaoni/features/home/domain/entities/annual_leave_balance.dart';

import '../../../../core/utils/usecases/base_usecase.dart';
import '../../domain/repositories/home_repositories.dart';

class HomeRepositoriesImp extends HomeRepositories {
  final HomeRemoteDataSources _remoteDataSources;
  final HomeLocalDataSources _localDataSources;
  final NetworkInfo _networkInfo;

  HomeRepositoriesImp(
    this._remoteDataSources,
    this._localDataSources,
    this._networkInfo,
  );

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

  @override
  Future<Either<Failure, AnnualLeaveBalance>> getAnnualLeaveBalance() async {
    if (await _networkInfo.isConnected) {
      try {
        final balance = await _remoteDataSources.getAnnualLeaveBalance();
        await _localDataSources.cacheAnnualLeaveBalance(balance: balance);
        return Right(balance);
      } on ServerFailure catch (failure) {
        return _cachedBalance(
          fallback: ServerFailure(message: failure.message),
        );
      }
    }
    return _cachedBalance(fallback: CacheFailure());
  }

  /// Falls back to the last cached balance, returning [fallback] when the cache
  /// is empty.
  Future<Either<Failure, AnnualLeaveBalance>> _cachedBalance({
    required Failure fallback,
  }) async {
    try {
      final cached = await _localDataSources.getAnnualLeaveBalance();
      return Right(cached);
    } on CacheFailure {
      return Left(fallback);
    }
  }
}
