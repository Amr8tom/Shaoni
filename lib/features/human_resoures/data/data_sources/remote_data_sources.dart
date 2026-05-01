import 'package:shaoni/features/human_resoures/data/model/attendance_record_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/dio/dio_helper.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/all_attendance_record_model.dart';
import '../../domain/entity/exit_permisstion.dart';
import '../../domain/use_cases/create_exit_permission_use_case.dart';
import '../../domain/use_cases/get_all_missing_attendance_use_case.dart';
import '../model/all_services_model.dart';
import '../model/permission_time_model.dart';
import '../model/permission_type_model.dart';

abstract class HRServicesRemoteDataSources {
  /// get all services
  Future<AllServicesModel> getAllServices();

  /// create exit permission
  Future<ExitPermission> createExitPermission(
    CreateExitPermissionParams params,
  );
  /// get all exit permission types
  Future<List<PermissionTypeModel>> getAllPermissionTypes();
  /// get all exit permission times
  Future<List<PermissionTimeModel>> getAllPermissionTimes();
  Future<AllAttendanceRecordModel> getAllMissingAttendance({required AllMissingAttendanceParams params});
}

class HRServicesRemoteDataSourcesImp implements HRServicesRemoteDataSources {
  final DioHelper _dio;

  const HRServicesRemoteDataSourcesImp(this._dio);

  @override
  Future<AllServicesModel> getAllServices() async {
    try {
      final response = await _dio.getData(URL: URL.getAllServices);
      if (response != null) {
        return AllServicesModel.fromJson(response);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<ExitPermission> createExitPermission(
    CreateExitPermissionParams params,
  ) async {
    try {
      final response = await _dio.postData(
        URL: URL.exitPermission,
        body: params.toMap(),
      );
      if (response != null) {
        return ExitPermission.fromJson(response);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<List<PermissionTimeModel>> getAllPermissionTimes() async {
    try {
      final List response = await _dio.getData(URL: URL.getPermissionTime);
      if (response != null) {
        print("============================ response ===========================");
        print(response);
        return response.map((e) => PermissionTimeModel.fromJson(e))
            .toList();

      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<PermissionTypeModel>> getAllPermissionTypes() async {
    try {
      final response = await _dio.getData(URL: URL.getPermissionTypes);
      if (response != null) {
        /// Extract the data field from the response Map
        final List data = response['data'] as List;
        return data.map((e) => PermissionTypeModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<AllAttendanceRecordModel> getAllMissingAttendance({required AllMissingAttendanceParams params}) async{
    try {
      final response = await _dio.postData(URL: URL.getAttendanceRecord,body: params.toJson());
      if (response != null) {
        /// Extract the data field from the response Map
        return AllAttendanceRecordModel.fromJson(response);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}
