import 'package:shaoni/features/human_resources/data/model/attendance/attendance_look_up_model.dart';
import 'package:shaoni/features/human_resources/data/model/attendance/attendance_model.dart';
import 'package:shaoni/features/human_resources/data/model/attendance/forget_reason_model.dart';
import 'package:shaoni/features/human_resources/data/model/car_permission/car_brand_model.dart';
import 'package:shaoni/features/human_resources/data/model/car_permission/car_color_model.dart';
import 'package:shaoni/features/human_resources/data/model/car_permission/create_car_permission_model.dart';
import 'package:shaoni/features/human_resources/data/model/car_permission/update_car_permission_model.dart';
import 'package:shaoni/features/human_resources/data/model/complaint_request/complaint_reason_model.dart';
import 'package:shaoni/features/human_resources/data/model/complaint_request/complaint_type_model.dart';
import 'package:shaoni/features/human_resources/data/model/complaint_request/create_complaint_request_model.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/attendance/create_attendance_use_case.dart';
import 'package:shaoni/features/human_resources/data/model/attendance/update_attendance_model.dart';
import 'package:shaoni/features/human_resources/data/model/exit_permission/update_exit_permission_model.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/car_permission/update_car_permission_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/attendance/update_attendance_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/exit/update_exit_permission_use_case.dart';
import 'package:shaoni/features/human_resources/data/model/start_work/start_work_type_model.dart';
import 'package:shaoni/features/human_resources/data/model/start_work/employee_model.dart';
import 'package:shaoni/features/human_resources/data/model/start_work/start_work_option_model.dart';
import 'package:shaoni/features/human_resources/data/model/start_work/employee_leave_type_model.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/get_employee_contracts_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/get_employee_leave_types_use_case.dart';
import 'package:shaoni/features/human_resources/data/model/start_work/create_start_work_model.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/create_start_work_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/update_start_work_use_case.dart';
import 'package:shaoni/features/human_resources/data/model/experience_certificate/certificate_reason_model.dart';
import 'package:shaoni/features/human_resources/data/model/experience_certificate/create_experience_certificate_model.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/experience_certificate/create_experience_certificate_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/experience_certificate/update_experience_certificate_use_case.dart';
import 'package:shaoni/features/human_resources/data/model/id_document/country_model.dart';
import 'package:shaoni/features/human_resources/data/model/id_document/department_model.dart';
import 'package:shaoni/features/human_resources/data/model/id_document/id_renewal_request_type_model.dart';
import 'package:shaoni/features/human_resources/data/model/id_document/create_id_document_model.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/id_document/create_id_document_use_case.dart';
import 'package:shaoni/features/human_resources/data/model/medical_insurance/medical_insurance_class_model.dart';
import 'package:shaoni/features/human_resources/data/model/medical_insurance/employee_relative_model.dart';
import 'package:shaoni/features/human_resources/data/model/medical_insurance/create_medical_insurance_model.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/medical_insurance/get_employee_relatives_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/medical_insurance/create_medical_insurance_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/medical_insurance/update_medical_insurance_use_case.dart';
import 'package:shaoni/features/human_resources/data/model/product_order/product_category_model.dart';
import 'package:shaoni/features/human_resources/data/model/product_order/product_model.dart';
import 'package:shaoni/features/human_resources/data/model/product_order/create_product_order_response_model.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/product_order/get_products_by_category_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/product_order/create_product_order_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/product_order/update_product_order_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/complaint_request/create_complaint_request_use_case.dart';
import 'package:shaoni/features/human_resources/data/model/outside_working/attendance_way_model.dart';
import 'package:shaoni/features/human_resources/data/model/outside_working/department_type_lookup_model.dart';
import 'package:shaoni/features/human_resources/data/model/outside_working/project_type_lookup_model.dart';
import 'package:shaoni/features/human_resources/data/model/outside_working/outside_working_employee_model.dart';
import 'package:shaoni/features/human_resources/data/model/outside_working/outside_working_project_model.dart';
import 'package:shaoni/features/human_resources/data/model/outside_working/create_outside_working_response_model.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/create_outside_working_use_case.dart';
import 'package:shaoni/features/human_resources/data/model/scrap_request/scrap_custody_model.dart';
import 'package:shaoni/features/human_resources/data/model/scrap_request/scrap_lot_model.dart';
import 'package:shaoni/features/human_resources/data/model/scrap_request/stock_request_model.dart';
import 'package:shaoni/features/human_resources/data/model/scrap_request/scrap_reason_model.dart';
import 'package:shaoni/features/human_resources/data/model/scrap_request/create_scrap_request_response_model.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/get_custodies_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/get_product_lots_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/create_scrap_request_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/update_scrap_request_use_case.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../../domain/entity/exit_permisstion.dart';
import '../../domain/use_cases/car_permission/create_car_permission_use_case.dart';
import '../../domain/use_cases/exit/create_exit_permission_use_case.dart';
import '../../domain/use_cases/attendance/get_all_missing_attendance_use_case.dart';
import '../model/all_attendance_record_model.dart';
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

  Future<AttendanceModel> createAttendance(
      {required CreateAttendanceParams params});

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
  Future<List<ComplaintTypeModel>> getComplaintTypes(
      {required NoParams params});

  Future<List<ComplaintReasonModel>> getComplaintReasons(
      {required NoParams params});

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

  Future<List<StartWorkOptionModel>> getEmployeeContracts({
    required GetEmployeeContractsParams params,
  });

  Future<List<StartWorkOptionModel>> getTaskManagement({
    required NoParams params,
  });

  Future<List<EmployeeLeaveTypeModel>> getEmployeeLeaveTypes({
    required GetEmployeeLeaveTypesParams params,
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
  Future<List<CountryModel>> getCountries({required NoParams params});

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

  /// ============================= outside working =============================
  Future<List<AttendanceWayModel>> getAttendanceWay({required NoParams params});

  Future<List<DepartmentTypeLookupModel>> getDepartmentTypeLookup(
      {required NoParams params});

  Future<List<ProjectTypeLookupModel>> getProjectTypeLookup(
      {required NoParams params});

  Future<List<OutsideWorkingEmployeeModel>> getOutsideWorkingEmployees(
      {required NoParams params});

  Future<List<OutsideWorkingProjectModel>> getOutsideWorkingProjects(
      {required NoParams params});

  Future<CreateOutsideWorkingResponseModel> createOutsideWorking({
    required CreateOutsideWorkingParams params,
  });

  /// ============================= scrap request =============================
  Future<List<ScrapCustodyModel>> getCustodies({
    required GetCustodiesParams params,
  });

  Future<List<StockRequestModel>> getStockRequests();

  Future<List<ScrapReasonModel>> getScrapReasons();

  Future<List<ScrapLotModel>> getProductLots({
    required GetProductLotsParams params,
  });

  Future<CreateScrapRequestResponseModel> createScrapRequest({
    required CreateScrapRequestParams params,
  });

  Future<CreateScrapRequestResponseModel> updateScrapRequest({
    required UpdateScrapRequestParams params,
  });
}
