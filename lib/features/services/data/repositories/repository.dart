import 'package:dartz/dartz.dart';

import '../../../../core/connection/checkNetwork.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../../domain/entity/all_services.dart';
import '../../domain/repository/repository.dart';
import '../data_sources/local_data_sources.dart';
import '../data_sources/remote_data_sources.dart';

class ServicesRepositoryImp extends ServicesRepository {
  final ServicesLocalDataSources _local;
  final ServicesRemoteDataSources _remote;
  final NetworkInfo _networkInfo;

  ServicesRepositoryImp(this._local, this._remote, this._networkInfo);



  @override
  Future<Either<Failure, AllServices>> getAllPermissionServices({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getAllServices();
        await _local.cacheAllServices(response);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final response = await _local.getAllServices();
        return Right(response);
      } on CacheFailure catch (e) {
        return Left(CacheFailure());
      }
    }
  }

}
