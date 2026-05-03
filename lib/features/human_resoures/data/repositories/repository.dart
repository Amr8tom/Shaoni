import 'package:dartz/dartz.dart';

import 'package:shaoni/core/error/failure.dart';

import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/attendance/attendance_lookup.dart';
import 'package:shaoni/features/human_resoures/domain/entity/attendance/forget_reason.dart';
import 'package:shaoni/features/human_resoures/domain/entity/attendance_record.dart';
import 'package:shaoni/features/human_resoures/domain/entity/exit_permisstion.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/create_attendance_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/get_all_missing_attendance_use_case.dart';

import '../../../../core/connection/checkNetwork.dart';
import '../../domain/entity/all_attendance_record_model.dart';
import '../../domain/entity/all_services.dart';
import '../../domain/entity/permission_time.dart';
import '../../domain/entity/permission_type.dart';
import '../../domain/repository/repository.dart';
import '../../domain/use_cases/create_exit_permission_use_case.dart';
import '../data_sources/local_data_sources.dart';
import '../data_sources/remote_data_sources.dart';

class HRServicesRepositoryImp extends HRServicesRepository {
  final HRServicesLocalDataSources _local;
  final HRServicesRemoteDataSources _remote;
  final NetworkInfo _networkInfo;

  HRServicesRepositoryImp(this._local, this._remote, this._networkInfo);

  @override
  Future<Either<Failure, ExitPermission>> createExitPermission({
    required CreateExitPermissionParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.createExitPermission(params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
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

  @override
  Future<Either<Failure, AllAttendanceRecordModel>> getAllMissingAttendance(
      {required AllMissingAttendanceParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getAllMissingAttendance(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final response = await _local.getAllAttendanceRecords();
        return Right(response);
      } on CacheFailure catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> createAttendance(
      {required CreateAttendanceParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.createAttendance(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, AttendanceLookup>> getAttendanceLookup(
      {required NoParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getAttendanceLookup(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      throw CacheFailure();
      // try {
      //   final response = await _local.getAttendanceLookup();
      //   return Right(response);
      // } on CacheFailure catch (e) {
      //   return Left(CacheFailure());
      // }
    }
  }

  @override
  Future<Either<Failure, List<ForgetReason>>> getForgetReason(
      {required NoParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getForgetReason(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      throw CacheFailure();
      // try {
      //   final response = await _local.getForgetReason();
      //   return Right(response);
      // } on CacheFailure catch (e) {
      //   return Left(CacheFailure());
      // }
    }
  }
}
