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
import 'package:shaoni/features/human_resoures/data/model/start_work/start_work_type_model.dart';
import 'package:shaoni/features/human_resoures/data/model/start_work/employee_model.dart';
import 'package:shaoni/features/human_resoures/data/model/start_work/create_start_work_model.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/start_work/create_start_work_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/start_work/update_start_work_use_case.dart';
import 'package:shaoni/features/human_resoures/data/model/experience_certificate/certificate_reason_model.dart';
import 'package:shaoni/features/human_resoures/data/model/experience_certificate/create_experience_certificate_model.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/experience_certificate/create_experience_certificate_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/experience_certificate/update_experience_certificate_use_case.dart';
import 'package:shaoni/features/human_resoures/data/model/id_document/department_model.dart';
import 'package:shaoni/features/human_resoures/data/model/id_document/id_renewal_request_type_model.dart';
import 'package:shaoni/features/human_resoures/data/model/id_document/create_id_document_model.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/id_document/create_id_document_use_case.dart';
import 'package:shaoni/features/human_resoures/data/model/medical_insurance/medical_insurance_class_model.dart';
import 'package:shaoni/features/human_resoures/data/model/medical_insurance/employee_relative_model.dart';
import 'package:shaoni/features/human_resoures/data/model/medical_insurance/create_medical_insurance_model.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/medical_insurance/get_employee_relatives_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/medical_insurance/create_medical_insurance_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/medical_insurance/update_medical_insurance_use_case.dart';
import 'package:shaoni/features/human_resoures/data/model/product_order/product_category_model.dart';
import 'package:shaoni/features/human_resoures/data/model/product_order/product_model.dart';
import 'package:shaoni/features/human_resoures/data/model/product_order/create_product_order_response_model.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/product_order/get_products_by_category_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/product_order/create_product_order_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/product_order/update_product_order_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/complaint_request/create_complaint_request_use_case.dart';
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

  /// ============================= start work =============================
  Future<List<StartWorkTypeModel>> getStartWorkTypes({
    required NoParams params,
  });

  Future<List<EmployeeModel>> getEmployees({
    required NoParams params,
  });

  Future<CreateStartWorkModel> createStartWorkRequest({
    required CreateStartWorkParams params,
  });

  Future<CreateStartWorkModel> updateStartWorkRequest({
    required UpdateStartWorkParams params,
  });

  /// ============================= experience certificate =============================
  Future<List<CertificateReasonModel>> getCertificateReasons({
    required NoParams params,
  });

  Future<CreateExperienceCertificateModel> createExperienceCertificate({
    required CreateExperienceCertificateParams params,
  });

  Future<CreateExperienceCertificateModel> updateExperienceCertificate({
    required UpdateExperienceCertificateParams params,
  });

  /// ============================= id document =============================
  Future<List<DepartmentModel>> getDepartments({required NoParams params});

  Future<List<IDRenewalRequestTypeModel>> getIDRenewalRequestTypes({
    required NoParams params,
  });

  Future<CreateIDDocumentModel> createIDDocument({
    required CreateIDDocumentParams params,
  });

  /// ============================= medical insurance =============================
  Future<List<MedicalInsuranceClassModel>> getMedicalInsuranceClasses({
    required NoParams params,
  });

  Future<List<EmployeeRelativeModel>> getEmployeeRelatives({
    required GetEmployeeRelativesParams params,
  });

  Future<CreateMedicalInsuranceModel> createMedicalInsurance({
    required CreateMedicalInsuranceParams params,
  });

  Future<CreateMedicalInsuranceModel> updateMedicalInsurance({
    required UpdateMedicalInsuranceParams params,
  });

  /// ============================= product order =============================
  Future<List<ProductCategoryModel>> getProductCategories();

  Future<List<OdooProductModel>> getProductsByCategory({
    required GetProductsByCategoryParams params,
  });

  Future<CreateProductOrderResponseModel> createProductOrder({
    required CreateProductOrderParams params,
  });

  Future<CreateProductOrderResponseModel> updateProductOrder({
    required UpdateProductOrderParams params,
  });
}

class HRServicesRemoteDataSourcesImp implements HRServicesRemoteDataSources {
  final DioHelper _dio;

  const HRServicesRemoteDataSourcesImp(this._dio);


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
        /// Handle both a plain List response and a wrapped {data: [...]} response.
        final List raw = response is List
            ? response
            : (response as Map<String, dynamic>)['data'] as List;
        return raw.map((e) => ForgetReasonModel.fromJson(e)).toList();
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

  /// ============================= start work =============================

  @override
  Future<List<StartWorkTypeModel>> getStartWorkTypes({
    required NoParams params,
  }) async {
    try {
      final response = await _dio.getData(URL: URL.getStartWorkTypes);
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw =
          response is List ? response : (response as Map<String, dynamic>)['data'] as List;
      return raw.map((e) => StartWorkTypeModel.fromJson(e)).toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<EmployeeModel>> getEmployees({
    required NoParams params,
  }) async {
    try {
      final response = await _dio.getData(URL: URL.getEmployees);
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw =
          response is List ? response : (response as Map<String, dynamic>)['data'] as List;
      return raw.map((e) => EmployeeModel.fromJson(e)).toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateStartWorkModel> createStartWorkRequest({
    required CreateStartWorkParams params,
  }) async {
    try {
      final response = await _dio.postData(
        URL: URL.createStartWork,
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateStartWorkModel.fromJson(response);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateStartWorkModel> updateStartWorkRequest({
    required UpdateStartWorkParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.updateStartWork}${params.requestId}',
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateStartWorkModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  /// ============================= experience certificate =============================

  @override
  Future<List<CertificateReasonModel>> getCertificateReasons({
    required NoParams params,
  }) async {
    try {
      final response = await _dio.getData(URL: URL.getCertificateReasons);
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw =
          response is List ? response : (response as Map<String, dynamic>)['data'] as List;
      return raw.map((e) => CertificateReasonModel.fromJson(e)).toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateExperienceCertificateModel> createExperienceCertificate({
    required CreateExperienceCertificateParams params,
  }) async {
    try {
      final response = await _dio.postData(
        URL: URL.createExperienceCertificate,
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateExperienceCertificateModel.fromJson(response);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateExperienceCertificateModel> updateExperienceCertificate({
    required UpdateExperienceCertificateParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.updateExperienceCertificate}${params.requestId}',
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateExperienceCertificateModel.fromJson(
          response.data as Map<String, dynamic>);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  /// ============================= id document =============================

  @override
  Future<List<DepartmentModel>> getDepartments({
    required NoParams params,
  }) async {
    try {
      final response = await _dio.getData(URL: URL.getDepartments);
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw =
          response is List ? response : (response as Map<String, dynamic>)['data'] as List;
      return raw.map((e) => DepartmentModel.fromJson(e)).toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<IDRenewalRequestTypeModel>> getIDRenewalRequestTypes({
    required NoParams params,
  }) async {
    try {
      final response = await _dio.getData(URL: URL.getIDRenewalRequestTypes);
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw =
          response is List ? response : (response as Map<String, dynamic>)['data'] as List;
      return raw.map((e) => IDRenewalRequestTypeModel.fromJson(e)).toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateIDDocumentModel> createIDDocument({
    required CreateIDDocumentParams params,
  }) async {
    try {
      final response = await _dio.postData(
        URL: URL.createIDDocument,
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateIDDocumentModel.fromJson(response);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  /// ============================= medical insurance =============================

  @override
  Future<List<MedicalInsuranceClassModel>> getMedicalInsuranceClasses({
    required NoParams params,
  }) async {
    try {
      final response = await _dio.getData(URL: URL.getMedicalInsuranceClasses);
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw =
          response is List ? response : (response as Map<String, dynamic>)['data'] as List;
      return raw.map((e) => MedicalInsuranceClassModel.fromJson(e)).toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<EmployeeRelativeModel>> getEmployeeRelatives({
    required GetEmployeeRelativesParams params,
  }) async {
    try {
      final response = await _dio.getData(
        URL: '${URL.getEmployeeRelatives}${params.employeeId}',
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      // API returns: {code, message, count, body: [...]}
      final List raw = response is List
          ? response
          : (response as Map<String, dynamic>)['body'] as List;
      return raw.map((e) => EmployeeRelativeModel.fromJson(e)).toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateMedicalInsuranceModel> createMedicalInsurance({
    required CreateMedicalInsuranceParams params,
  }) async {
    try {
      final response = await _dio.postData(
        URL: URL.createMedicalInsurance,
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateMedicalInsuranceModel.fromJson(response);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateMedicalInsuranceModel> updateMedicalInsurance({
    required UpdateMedicalInsuranceParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.updateMedicalInsurance}${params.requestId}',
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateMedicalInsuranceModel.fromJson(
          response.data as Map<String, dynamic>);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  /// ============================= product order =============================

  @override
  Future<List<ProductCategoryModel>> getProductCategories() async {
    try {
      final response = await _dio.getData(URL: URL.getProductCategories);
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw =
          response is List ? response : (response as Map<String, dynamic>)['data'] as List;
      return raw.map((e) => ProductCategoryModel.fromJson(e)).toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<OdooProductModel>> getProductsByCategory({
    required GetProductsByCategoryParams params,
  }) async {
    try {
      final url = params.categoryId != null
          ? '${URL.getProductsByCategory}?categId=${params.categoryId}'
          : URL.getProductsByCategory;
      final response = await _dio.getData(URL: url);
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw =
          response is List ? response : (response as Map<String, dynamic>)['data'] as List;
      return raw.map((e) => OdooProductModel.fromJson(e)).toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateProductOrderResponseModel> createProductOrder({
    required CreateProductOrderParams params,
  }) async {
    try {
      final response = await _dio.postData(
        URL: URL.createProductOrder,
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateProductOrderResponseModel.fromJson(response);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateProductOrderResponseModel> updateProductOrder({
    required UpdateProductOrderParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.updateProductOrder}${params.requestId}',
        body: params.data.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateProductOrderResponseModel.fromJson(
          response.data as Map<String, dynamic>);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}
