import 'package:shaoni/features/human_resoures/data/model/attendance/attendance_look_up_model.dart';
import 'package:shaoni/features/human_resoures/data/model/attendance/attendance_model.dart';
import 'package:shaoni/features/human_resoures/data/model/attendance/forget_reason_model.dart';
import 'package:shaoni/features/human_resoures/data/model/attendance_record_model.dart';
import 'package:shaoni/features/human_resoures/data/model/car_permission/car_brand_model.dart';
import 'package:shaoni/features/human_resoures/data/model/car_permission/car_color_model.dart';
import 'package:shaoni/features/human_resoures/data/model/car_permission/create_car_permission_model.dart';
import 'package:shaoni/features/human_resoures/data/model/car_permission/update_car_permission_model.dart';
import 'package:shaoni/features/human_resoures/data/model/complaint_request/complaint_reason_model.dart';
import 'package:shaoni/features/human_resoures/data/model/complaint_request/complaint_type_model.dart';
import 'package:shaoni/features/human_resoures/data/model/complaint_request/create_complaint_request_model.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/create_attendance_use_case.dart';
import 'package:shaoni/features/human_resoures/data/model/attendance/update_attendance_model.dart';
import 'package:shaoni/features/human_resoures/data/model/exit_permission/update_exit_permission_model.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/car_permission/update_car_permission_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/update_attendance_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/exit/update_exit_permission_use_case.dart';
import 'package:shaoni/features/human_resoures/data/model/study/create_study_model.dart';
import 'package:shaoni/features/human_resoures/data/model/study/study_destination_model.dart';
import 'package:shaoni/features/human_resoures/data/model/study/study_type_model.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/complaint_request/create_complaint_request_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/study/create_study_use_case.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/dio/dio_helper.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../../domain/entity/all_attendance_record_model.dart';
import '../../domain/entity/exit_permisstion.dart';
import '../../domain/use_cases/car_permission/create_car_permission_use_case.dart';
import '../../domain/use_cases/exit/create_exit_permission_use_case.dart';
import '../../domain/use_cases/attendance/get_all_missing_attendance_use_case.dart';
import '../model/all_services_model.dart';
import '../model/permission_time_model.dart';
import '../model/permission_type_model.dart';

abstract class HRServicesRemoteDataSources {
  /// get all services
  Future<AllServicesModel> getAllServices();

  /// ============================= exit permission  =============================
  Future<ExitPermission> createExitPermission(
    CreateExitPermissionParams params,
  );

  Future<UpdateExitPermissionModel> updateExitPermission({
    required UpdateExitPermissionParams params,
  });

  Future<List<PermissionTypeModel>> getAllPermissionTypes();

  Future<List<PermissionTimeModel>> getAllPermissionTimes();

  /// ============================= attendance  =============================
  Future<AllAttendanceRecordModel> getAllMissingAttendance(
      {required AllMissingAttendanceParams params});

  Future<AttendanceModel> createAttendance({required CreateAttendanceParams params});

  Future<UpdateAttendanceModel> updateAttendance({
    required UpdateAttendanceParams params,
  });

  Future<List<AttendanceLookUpModel>> getAttendanceLookup({
    required NoParams params,
  });

  Future<List<ForgetReasonModel>> getForgetReason({
    required NoParams params,
  });

  /// ============================= car permission =============================
  Future<List<CarColorModel>> getCarColors({required NoParams params});

  Future<List<CarBrandModel>> getCarBrands({required NoParams params});
  Future<CreateCarPermissionModel> createCarPermission({
    required CreateCarPermissionParams params,
  });

  Future<UpdateCarPermissionModel> updateCarPermission({
    required UpdateCarPermissionParams params,
  });

  /// ============================= complaint request =============================
  Future<List<ComplaintTypeModel>> getComplaintTypes({required NoParams params});

  Future<List<ComplaintReasonModel>> getComplaintReasons({required NoParams params});

  Future<CreateComplaintRequestModel> createComplaintRequest({
    required CreateComplaintRequestParams params,
  });

  /// ============================= study request =============================
  Future<List<StudyTypeModel>> getStudyTypes({required NoParams params});

  Future<List<StudyDestinationModel>> getStudyDestinations({
    required NoParams params,
  });

  Future<CreateStudyModel> createStudyRequest({
    required CreateStudyParams params,
  });
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
  Future<UpdateExitPermissionModel> updateExitPermission({
    required UpdateExitPermissionParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.updateExitPermission}${params.requestId}',
        body: params.toMap(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return UpdateExitPermissionModel.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<PermissionTimeModel>> getAllPermissionTimes() async {
    try {
      final List response = await _dio.getData(URL: URL.getPermissionTime);
      if (response != null) {
        print(
            "============================ response ===========================");
        print(response);
        return response.map((e) => PermissionTimeModel.fromJson(e)).toList();
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
  Future<AllAttendanceRecordModel> getAllMissingAttendance(
      {required AllMissingAttendanceParams params}) async {
    try {
      final response = await _dio.postData(
          URL: URL.getAttendanceRecord, body: params.toJson());
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

  @override
  Future<AttendanceModel> createAttendance(
      {required CreateAttendanceParams params}) async {
    try {
      final response = await _dio.postData(
          URL: URL.createAttendanceRequest, body: params.toMap());
      if (response != null) {
        /// Extract the data field from the response Map
        return AttendanceModel.fromJson(response);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<UpdateAttendanceModel> updateAttendance({
    required UpdateAttendanceParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.updateAttendanceRequest}${params.requestId}',
        body: params.toMap(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return UpdateAttendanceModel.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<AttendanceLookUpModel>>getAttendanceLookup(
      {required NoParams params}) async {
    try {
      final List response = await _dio.getData(URL: URL.getAttendanceLookUp);
      if (response != null) {

        /// Extract the data field from the response Map
        return response.map((e){return AttendanceLookUpModel.fromJson(e);}).toList() ;
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<ForgetReasonModel>> getForgetReason(
      {required NoParams params}) async {
    try {
      final response = await _dio.getData(URL: URL.getAttendanceForgetReason);
      if (response != null) {
        /// Extract the data field from the response Map
        final List data = response as List;
        return data.map((e) => ForgetReasonModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  /// ============================= car permission =============================

  @override
  Future<List<CarColorModel>> getCarColors({required NoParams params}) async {
    try {
      final response = await _dio.getData(URL: URL.getCarColors);
      if (response != null) {
        final List data = response as List;
        return data.map((e) => CarColorModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<CarBrandModel>> getCarBrands({required NoParams params}) async {
    try {
      final response = await _dio.getData(URL: URL.getCarBrands);
      if (response != null) {
        final List data = response as List;
        return data.map((e) => CarBrandModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateCarPermissionModel> createCarPermission({required CreateCarPermissionParams params}) async{
    try {
      final response = await _dio.postData(URL: URL.createCarPermission, body: params.toMap());
      if (response != null) {
        return CreateCarPermissionModel.fromJson(response);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<UpdateCarPermissionModel> updateCarPermission({required UpdateCarPermissionParams params}) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.updateCarPermission}${params.requestId}',
        body: params.toMap(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return UpdateCarPermissionModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  /// ============================= complaint request =============================

  @override
  Future<List<ComplaintTypeModel>> getComplaintTypes({required NoParams params}) async {
    try {
      final response = await _dio.getData(URL: URL.getComplaintTypes);
      if (response != null) {
        final List data = response as List;
        return data.map((e) => ComplaintTypeModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<ComplaintReasonModel>> getComplaintReasons({required NoParams params}) async {
    try {
      final response = await _dio.getData(URL: URL.getComplaintReasons);
      if (response != null) {
        final List data = response as List;
        return data.map((e) => ComplaintReasonModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateComplaintRequestModel> createComplaintRequest({required CreateComplaintRequestParams params}) async {
    try {
      final response = await _dio.postData(URL: URL.createComplaintRequest, body: params.toMap());
      if (response != null) {
        return CreateComplaintRequestModel.fromJson(response);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  /// ============================= study request =============================

  @override
  Future<List<StudyTypeModel>> getStudyTypes({required NoParams params}) async {
    try {
      final List response = await _dio.getData(URL: URL.getStudyTypes);
      if (response != null) {
        return response.map((e) => StudyTypeModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<StudyDestinationModel>> getStudyDestinations({
    required NoParams params,
  }) async {
    try {
      final response = await _dio.getData(URL: URL.getStudyDestinations);
      if (response != null) {
        final List data = response['data'] as List;
        return data.map((e) => StudyDestinationModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateStudyModel> createStudyRequest({
    required CreateStudyParams params,
  }) async {
    try {
      final response = await _dio.postData(
        URL: URL.createStudyRequest,
        body: params.toMap(),
      );
      if (response != null) {
        return CreateStudyModel.fromJson(response);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}
