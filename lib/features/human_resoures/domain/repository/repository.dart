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
import '../use_cases/complaint_request/create_complaint_request_use_case.dart';
import '../use_cases/exit/create_exit_permission_use_case.dart';
import '../use_cases/attendance/get_all_missing_attendance_use_case.dart';
import '../entity/start_work/start_work_type.dart';
import '../entity/start_work/employee.dart';
import '../entity/start_work/create_start_work_response.dart';
import '../use_cases/start_work/create_start_work_use_case.dart';
import '../use_cases/start_work/update_start_work_use_case.dart';
import '../entity/experience_certificate/certificate_reason.dart';
import '../entity/experience_certificate/create_experience_certificate_response.dart';
import '../use_cases/experience_certificate/create_experience_certificate_use_case.dart';
import '../use_cases/experience_certificate/update_experience_certificate_use_case.dart';
import '../entity/id_document/country.dart';
import '../entity/id_document/department.dart';
import '../entity/id_document/id_renewal_request_type.dart';
import '../entity/id_document/create_id_document_response.dart';
import '../use_cases/id_document/create_id_document_use_case.dart';
import '../entity/medical_insurance/medical_insurance_class.dart';
import '../entity/medical_insurance/employee_relative.dart';
import '../entity/medical_insurance/create_medical_insurance_response.dart';
import '../use_cases/medical_insurance/get_employee_relatives_use_case.dart';
import '../use_cases/medical_insurance/create_medical_insurance_use_case.dart';
import '../use_cases/medical_insurance/update_medical_insurance_use_case.dart';
import '../entity/product_order/product_category.dart';
import '../entity/product_order/product.dart';
import '../entity/product_order/create_product_order_response.dart';
import '../use_cases/product_order/get_products_by_category_use_case.dart';
import '../use_cases/product_order/create_product_order_use_case.dart';
import '../use_cases/product_order/update_product_order_use_case.dart';

abstract class HRServicesRepository {


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

  /// ///////////////////////////////////// start work /////////////////////////////////////////////////////
  Future<Either<Failure, List<StartWorkType>>> getStartWorkTypes({
    required NoParams params,
  });

  Future<Either<Failure, List<Employee>>> getEmployees({
    required NoParams params,
  });

  Future<Either<Failure, CreateStartWorkResponse>> createStartWorkRequest({
    required CreateStartWorkParams params,
  });

  Future<Either<Failure, CreateStartWorkResponse>> updateStartWorkRequest({
    required UpdateStartWorkParams params,
  });

  /// ///////////////////////////////////// experience certificate /////////////////////////////////////////////////////
  Future<Either<Failure, List<CertificateReason>>> getCertificateReasons({
    required NoParams params,
  });

  Future<Either<Failure, CreateExperienceCertificateResponse>>
      createExperienceCertificate({
    required CreateExperienceCertificateParams params,
  });

  Future<Either<Failure, CreateExperienceCertificateResponse>>
      updateExperienceCertificate({
    required UpdateExperienceCertificateParams params,
  });

  /// ///////////////////////////////////// id document /////////////////////////////////////////////////////
  Future<Either<Failure, List<Country>>> getCountries({
    required NoParams params,
  });

  Future<Either<Failure, List<Department>>> getDepartments({
    required NoParams params,
  });

  Future<Either<Failure, List<IDRenewalRequestType>>> getIDRenewalRequestTypes({
    required NoParams params,
  });

  Future<Either<Failure, CreateIDDocumentResponse>> createIDDocument({
    required CreateIDDocumentParams params,
  });

  /// ///////////////////////////////////// medical insurance /////////////////////////////////////////////////////
  Future<Either<Failure, List<MedicalInsuranceClass>>> getMedicalInsuranceClasses({
    required NoParams params,
  });

  Future<Either<Failure, List<EmployeeRelative>>> getEmployeeRelatives({
    required GetEmployeeRelativesParams params,
  });

  Future<Either<Failure, CreateMedicalInsuranceResponse>> createMedicalInsurance({
    required CreateMedicalInsuranceParams params,
  });

  Future<Either<Failure, CreateMedicalInsuranceResponse>> updateMedicalInsurance({
    required UpdateMedicalInsuranceParams params,
  });

  /// ///////////////////////////////////// product order /////////////////////////////////////////////////////
  Future<Either<Failure, List<ProductCategory>>> getProductCategories();

  Future<Either<Failure, List<OdooProduct>>> getProductsByCategory({
    required GetProductsByCategoryParams params,
  });

  Future<Either<Failure, CreateProductOrderResponse>> createProductOrder({
    required CreateProductOrderParams params,
  });

  Future<Either<Failure, CreateProductOrderResponse>> updateProductOrder({
    required UpdateProductOrderParams params,
  });
}
