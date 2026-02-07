import 'package:dartz/dartz.dart';
import 'package:shaoni/features/navigation/data/data_sources/local_data_sources.dart';
import 'package:shaoni/features/navigation/data/data_sources/remote_data_sources.dart';

import '../../../../core/connection/checkNetwork.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/repositories.dart';

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
}
