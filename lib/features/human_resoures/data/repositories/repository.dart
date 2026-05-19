import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/data/model/car_permission/create_car_permission_model.dart';
import 'package:shaoni/features/human_resoures/domain/entity/attendance/attendance_lookup.dart';
import 'package:shaoni/features/human_resoures/domain/entity/attendance/forget_reason.dart';
import 'package:shaoni/features/human_resoures/domain/entity/car_permission/car_brand.dart';
import 'package:shaoni/features/human_resoures/domain/entity/car_permission/car_color.dart';
import 'package:shaoni/features/human_resoures/domain/entity/complaint_request/complaint_reason.dart';
import 'package:shaoni/features/human_resoures/domain/entity/complaint_request/complaint_type.dart';
import 'package:shaoni/features/human_resoures/domain/entity/exit_permisstion.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/create_attendance_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/get_all_missing_attendance_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/car_permission/create_car_permission_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/car_permission/update_car_permission_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/update_attendance_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/entity/attendance/update_attendance.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/exit/update_exit_permission_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/entity/exit_permission/update_exit_permission.dart';
import 'package:shaoni/features/human_resoures/domain/entity/study/create_study_response.dart';
import 'package:shaoni/features/human_resoures/domain/entity/study/study_destination.dart';
import 'package:shaoni/features/human_resoures/domain/entity/study/study_type.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/complaint_request/create_complaint_request_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/study/create_study_use_case.dart';
import '../model/car_permission/update_car_permission_model.dart';
import '../model/complaint_request/create_complaint_request_model.dart';
import '../../../../core/connection/checkNetwork.dart';
import '../../domain/entity/all_attendance_record_model.dart';
import '../../domain/entity/all_services.dart';
import '../../domain/entity/permission_time.dart';
import '../../domain/entity/permission_type.dart';
import '../../domain/repository/repository.dart';
import '../../domain/use_cases/exit/create_exit_permission_use_case.dart';
import '../data_sources/local_data_sources.dart';
import '../data_sources/remote_data_sources.dart';
import '../model/attendance/attendance_model.dart';

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
  Future<Either<Failure, AttendanceModel>> createAttendance(
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
  Future<Either<Failure, List<AttendanceLookup>>> getAttendanceLookup(
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
    }
  }

  @override
  Future<Either<Failure, UpdateAttendance>> updateAttendance({
    required UpdateAttendanceParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.updateAttendance(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UpdateExitPermission>> updateExitPermission({
    required UpdateExitPermissionParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.updateExitPermission(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  /// ===================== car permission =====================

  @override
  Future<Either<Failure, List<CarColor>>> getCarColors(
      {required NoParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getCarColors(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<CarBrand>>> getCarBrands(
      {required NoParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getCarBrands(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateCarPermissionModel>> createCarPermission(
      {required CreateCarPermissionParams params}) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.createCarPermission(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  /// ===================== complaint request =====================

  @override
  Future<Either<Failure, List<ComplaintType>>> getComplaintTypes(
      {required NoParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getComplaintTypes(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ComplaintReason>>> getComplaintReasons(
      {required NoParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getComplaintReasons(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateComplaintRequestModel>> createComplaintRequest(
      {required CreateComplaintRequestParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.createComplaintRequest(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UpdateCarPermissionModel>> updateCarPermission(
      {required UpdateCarPermissionParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.updateCarPermission(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  /// ===================== study request =====================

  @override
  Future<Either<Failure, List<StudyType>>> getStudyTypes({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getStudyTypes(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<StudyDestination>>> getStudyDestinations({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getStudyDestinations(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateStudyResponse>> createStudyRequest({
    required CreateStudyParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.createStudyRequest(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
