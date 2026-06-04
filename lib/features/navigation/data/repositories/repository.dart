import 'package:dartz/dartz.dart';
import 'package:shaoni/features/navigation/data/data_sources/local_data_sources.dart';
import 'package:shaoni/features/navigation/data/data_sources/remote_data_sources.dart';

import '../../../../core/connection/checkNetwork.dart';
import '../../../../core/error/failure.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/use_cases/get_user_data_use_case.dart';

class NavigationRepositoryImp implements NavigationRepository {
  final NavigationRemoteDataSources _remote;
  final NavigationLocalDataSources _local;
  final NetworkInfo _networkInfo;

  const NavigationRepositoryImp(this._remote, this._local, this._networkInfo);

  @override
  Future<Either<Failure, int>> getCountUnreadedNotification() async {
    if (await _networkInfo.isConnected) {
      try {
        return right(await _remote.getUnreadedNotifications());
      } on ServerFailure {
        return left(ServerFailure(message: "server failure "));
      }
    } else {
      return left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData({
    required GetUserDataParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remote.getUserData(params: params);
        await _local.cacheUserData(user: result);
        return right(result);
      } on ServerFailure {
        return left(ServerFailure(message: "Server Failure"));
      }
    } else {
      try {
        final result = await _local.getUserData();
        return right(result);
      } on CacheFailure {
        return left(CacheFailure());
      }
    }
  }
}
