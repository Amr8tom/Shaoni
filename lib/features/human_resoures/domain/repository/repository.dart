import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/human_resoures/domain/entity/attendance/attendance_lookup.dart';
import 'package:shaoni/features/human_resoures/domain/entity/attendance/forget_reason.dart';
import 'package:shaoni/features/human_resoures/domain/entity/car_permission/car_brand.dart';
import 'package:shaoni/features/human_resoures/domain/entity/car_permission/car_color.dart';
import 'package:shaoni/features/human_resoures/domain/entity/complaint_request/complaint_reason.dart';
import 'package:shaoni/features/human_resoures/domain/entity/complaint_request/complaint_type.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../../data/model/attendance/attendance_model.dart';
import '../../data/model/car_permission/create_car_permission_model.dart';
import '../../data/model/car_permission/update_car_permission_model.dart';
import '../../data/model/complaint_request/create_complaint_request_model.dart';
import '../entity/all_attendance_record_model.dart';
import '../entity/all_services.dart';
import '../entity/exit_permisstion.dart';
import '../entity/permission_time.dart';
import '../entity/permission_type.dart';
import '../use_cases/attendance/create_attendance_use_case.dart';
import '../use_cases/car_permission/create_car_permission_use_case.dart';
import '../use_cases/car_permission/update_car_permission_use_case.dart';
import '../use_cases/attendance/update_attendance_use_case.dart';
import '../entity/attendance/update_attendance.dart';
import '../use_cases/exit/update_exit_permission_use_case.dart';
import '../entity/exit_permission/update_exit_permission.dart';
import '../entity/study/create_study_response.dart';
import '../entity/study/study_destination.dart';
import '../entity/study/study_type.dart';
import '../use_cases/complaint_request/create_complaint_request_use_case.dart';
import '../use_cases/exit/create_exit_permission_use_case.dart';
import '../use_cases/attendance/get_all_missing_attendance_use_case.dart';
import '../use_cases/study/create_study_use_case.dart';

abstract class HRServicesRepository {
  Future<Either<Failure, AllServices>> getAllPermissionServices({
    required NoParams params,
  });

  Future<Either<Failure, ExitPermission>> createExitPermission({
    required CreateExitPermissionParams params,
  });

  Future<Either<Failure, UpdateExitPermission>> updateExitPermission({
    required UpdateExitPermissionParams params,
  });

  Future<Either<Failure, List<PermissionType>>> getAllPermissionTypes({
    required NoParams params,
  });

  Future<Either<Failure, List<PermissionTime>>> getAllPermissionTimes({
    required NoParams params,
  });
/// ///////////////////////////////////// attendance /////////////////////////////////////////////////////
  Future<Either<Failure, AllAttendanceRecordModel>> getAllMissingAttendance(
      {required AllMissingAttendanceParams params});
  Future<Either<Failure, AttendanceModel>> createAttendance({
    required CreateAttendanceParams params,
  });

  Future<Either<Failure, UpdateAttendance>> updateAttendance({
    required UpdateAttendanceParams params,
  });
  Future<Either<Failure, List<AttendanceLookup>>> getAttendanceLookup({
    required NoParams params,
  });  Future<Either<Failure, List<ForgetReason>>> getForgetReason({
    required NoParams params,
  });

  /// ///////////////////////////////////// car permission /////////////////////////////////////////////////////
  Future<Either<Failure, List<CarColor>>> getCarColors({
    required NoParams params,
  });

  Future<Either<Failure, List<CarBrand>>> getCarBrands({
    required NoParams params,
  });
  Future<Either<Failure, CreateCarPermissionModel>> createCarPermission({
    required CreateCarPermissionParams params,
  });

  Future<Either<Failure, UpdateCarPermissionModel>> updateCarPermission({
    required UpdateCarPermissionParams params,
  });

  /// ///////////////////////////////////// complaint request /////////////////////////////////////////////////////
  Future<Either<Failure, List<ComplaintType>>> getComplaintTypes({
    required NoParams params,
  });

  Future<Either<Failure, List<ComplaintReason>>> getComplaintReasons({
    required NoParams params,
  });

  Future<Either<Failure, CreateComplaintRequestModel>> createComplaintRequest({
    required CreateComplaintRequestParams params,
  });

  /// ///////////////////////////////////// study request /////////////////////////////////////////////////////
  Future<Either<Failure, List<StudyType>>> getStudyTypes({
    required NoParams params,
  });

  Future<Either<Failure, List<StudyDestination>>> getStudyDestinations({
    required NoParams params,
  });

  Future<Either<Failure, CreateStudyResponse>> createStudyRequest({
    required CreateStudyParams params,
  });
}
