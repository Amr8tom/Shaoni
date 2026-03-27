import 'package:dartz/dartz.dart';

import 'package:shaoni/core/error/failure.dart';

import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import 'package:shaoni/features/my-services/domain/entity/all_services.dart';

import 'package:shaoni/features/my-services/domain/entity/exit_permisstion.dart';
import 'package:shaoni/features/my-services/domain/entity/permission_time.dart';
import 'package:shaoni/features/my-services/domain/entity/permission_type.dart';

import 'package:shaoni/features/my-services/domain/use_cases/create_exit_permission_use_case.dart';

import '../../../../core/connection/checkNetwork.dart';
import '../../domain/repository/repository.dart';
import '../data_sources/local_data_sources.dart';
import '../data_sources/remote_data_sources.dart';

class ServicesRepositoryImp extends ServicesRepository {
  final MyServicesLocalDataSources _local;
  final MyServicesRemoteDataSources _remote;
  final NetworkInfo _networkInfo;

  ServicesRepositoryImp(this._local, this._remote, this._networkInfo);

  @override
  Future<Either<Failure, ExitPermission>> createExitPermission({
    required CreateExitPermissionParams params,
  }) async {
    if(await _networkInfo.isConnected){
      try {
        final response = await _remote.createExitPermission(params);
        return Right(response);
        } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }

    } else{
      return Left(CacheFailure());
    }
  }

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

  @override
  Future<Either<Failure, List<PermissionTime>>> getAllPermissionTimes({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getAllPermissionTimes();
        await _local.cacheAllPermissionTimes(response);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final response = await _local.getAllPermissionTimes();
        return Right(response);
      } on CacheFailure catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<PermissionType>>> getAllPermissionTypes({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getAllPermissionTypes();
        await _local.cacheAllPermissionTypes(response);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final response = await _local.getAllPermissionTypes();
        return Right(response);
      } on CacheFailure catch (e) {
        return Left(CacheFailure());
      }
    }
  }
}
