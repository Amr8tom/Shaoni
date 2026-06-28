import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/attendance/attendance.dart';
import 'package:shaoni/features/human_resources/domain/entity/car_permission/create_car_permission.dart';
import 'package:shaoni/features/human_resources/domain/entity/car_permission/update_car_permission.dart';
import 'package:shaoni/features/human_resources/domain/entity/complaint_request/create_complaint_request.dart';
import 'package:shaoni/features/human_resources/domain/entity/all_attendance_record.dart';
import 'package:shaoni/features/human_resources/domain/entity/attendance/attendance_lookup.dart';
import 'package:shaoni/features/human_resources/domain/entity/attendance/forget_reason.dart';
import 'package:shaoni/features/human_resources/domain/entity/car_permission/car_brand.dart';
import 'package:shaoni/features/human_resources/domain/entity/car_permission/car_color.dart';
import 'package:shaoni/features/human_resources/domain/entity/complaint_request/complaint_reason.dart';
import 'package:shaoni/features/human_resources/domain/entity/complaint_request/complaint_type.dart';
import 'package:shaoni/features/human_resources/domain/entity/exit_permisstion.dart';
import 'package:shaoni/features/human_resources/domain/entity/attendance/update_attendance.dart';
import 'package:shaoni/features/human_resources/domain/entity/exit_permission/update_exit_permission.dart';
import 'package:shaoni/features/human_resources/domain/entity/start_work/start_work_type.dart';
import 'package:shaoni/features/human_resources/domain/entity/start_work/employee.dart';
import 'package:shaoni/features/human_resources/domain/entity/start_work/create_start_work_response.dart';
import 'package:shaoni/features/human_resources/domain/entity/experience_certificate/certificate_reason.dart';
import 'package:shaoni/features/human_resources/domain/entity/experience_certificate/create_experience_certificate_response.dart';
import 'package:shaoni/features/human_resources/domain/entity/id_document/country.dart';
import 'package:shaoni/features/human_resources/domain/entity/id_document/department.dart';
import 'package:shaoni/features/human_resources/domain/entity/id_document/id_renewal_request_type.dart';
import 'package:shaoni/features/human_resources/domain/entity/id_document/create_id_document_response.dart';
import 'package:shaoni/features/human_resources/domain/entity/medical_insurance/medical_insurance_class.dart';
import 'package:shaoni/features/human_resources/domain/entity/medical_insurance/employee_relative.dart';
import 'package:shaoni/features/human_resources/domain/entity/medical_insurance/create_medical_insurance_response.dart';
import 'package:shaoni/features/human_resources/domain/entity/product_order/product_category.dart';
import 'package:shaoni/features/human_resources/domain/entity/product_order/product.dart';
import 'package:shaoni/features/human_resources/domain/entity/product_order/create_product_order_response.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/attendance_way.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/department_type_lookup.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/project_type_lookup.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/outside_working_employee.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/outside_working_project.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/create_outside_working_response.dart';
import 'package:shaoni/features/human_resources/domain/entity/permission_time.dart';
import 'package:shaoni/features/human_resources/domain/entity/permission_type.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/attendance/create_attendance_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/attendance/get_all_missing_attendance_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/car_permission/create_car_permission_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/car_permission/update_car_permission_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/attendance/update_attendance_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/exit/update_exit_permission_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/complaint_request/create_complaint_request_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/exit/create_exit_permission_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/create_start_work_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/start_work/update_start_work_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/experience_certificate/create_experience_certificate_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/experience_certificate/update_experience_certificate_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/id_document/create_id_document_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/medical_insurance/get_employee_relatives_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/medical_insurance/create_medical_insurance_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/medical_insurance/update_medical_insurance_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/product_order/get_products_by_category_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/product_order/create_product_order_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/product_order/update_product_order_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/outside_working/create_outside_working_use_case.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/scrap_custody.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/scrap_lot.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/stock_request_entity.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/scrap_reason_entity.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/create_scrap_request_response.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/get_custodies_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/get_product_lots_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/create_scrap_request_use_case.dart';
import 'package:shaoni/features/human_resources/domain/use_cases/scrap_request/update_scrap_request_use_case.dart';
import 'package:shaoni/core/connection/check_network.dart';
import 'package:shaoni/features/human_resources/data/data_sources/local_data_sources.dart';
import 'package:shaoni/features/human_resources/data/data_sources/remote_data_sources.dart';

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
      } on CacheFailure {
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
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, AllAttendanceRecord>> getAllMissingAttendance(
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
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Attendance>> createAttendance(
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
  Future<Either<Failure, CreateCarPermission>> createCarPermission(
      {required CreateCarPermissionParams params}) async {
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
  Future<Either<Failure, CreateComplaintRequest>> createComplaintRequest(
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
  Future<Either<Failure, UpdateCarPermission>> updateCarPermission(
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

  /// ===================== start work =====================

  @override
  Future<Either<Failure, List<StartWorkType>>> getStartWorkTypes({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getStartWorkTypes(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Employee>>> getEmployees({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getEmployees(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateStartWorkResponse>> createStartWorkRequest({
    required CreateStartWorkParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.createStartWorkRequest(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateStartWorkResponse>> updateStartWorkRequest({
    required UpdateStartWorkParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.updateStartWorkRequest(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  /// ===================== experience certificate =====================

  @override
  Future<Either<Failure, List<CertificateReason>>> getCertificateReasons({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getCertificateReasons(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateExperienceCertificateResponse>>
      createExperienceCertificate({
    required CreateExperienceCertificateParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remote.createExperienceCertificate(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateExperienceCertificateResponse>>
      updateExperienceCertificate({
    required UpdateExperienceCertificateParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remote.updateExperienceCertificate(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  /// ===================== id document =====================

  @override
  Future<Either<Failure, List<Country>>> getCountries({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getCountries(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Department>>> getDepartments({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getDepartments(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<IDRenewalRequestType>>> getIDRenewalRequestTypes({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getIDRenewalRequestTypes(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateIDDocumentResponse>> createIDDocument({
    required CreateIDDocumentParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.createIDDocument(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  /// ===================== medical insurance =====================

  @override
  Future<Either<Failure, List<MedicalInsuranceClass>>>
      getMedicalInsuranceClasses({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remote.getMedicalInsuranceClasses(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<EmployeeRelative>>> getEmployeeRelatives({
    required GetEmployeeRelativesParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getEmployeeRelatives(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateMedicalInsuranceResponse>>
      createMedicalInsurance({
    required CreateMedicalInsuranceParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.createMedicalInsurance(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateMedicalInsuranceResponse>>
      updateMedicalInsurance({
    required UpdateMedicalInsuranceParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.updateMedicalInsurance(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  /// ===================== product order =====================

  @override
  Future<Either<Failure, List<ProductCategory>>> getProductCategories() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getProductCategories();
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<OdooProduct>>> getProductsByCategory({
    required GetProductsByCategoryParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getProductsByCategory(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateProductOrderResponse>> createProductOrder({
    required CreateProductOrderParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.createProductOrder(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateProductOrderResponse>> updateProductOrder({
    required UpdateProductOrderParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.updateProductOrder(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  /// ============================= outside working =============================

  @override
  Future<Either<Failure, List<AttendanceWay>>> getAttendanceWay({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getAttendanceWay(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<DepartmentTypeLookup>>> getDepartmentTypeLookup({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getDepartmentTypeLookup(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProjectTypeLookup>>> getProjectTypeLookup({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getProjectTypeLookup(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<OutsideWorkingEmployee>>>
      getOutsideWorkingEmployees({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remote.getOutsideWorkingEmployees(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<OutsideWorkingProject>>>
      getOutsideWorkingProjects({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remote.getOutsideWorkingProjects(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateOutsideWorkingResponse>> createOutsideWorking({
    required CreateOutsideWorkingParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.createOutsideWorking(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  /// ============================= scrap request =============================

  @override
  Future<Either<Failure, List<ScrapCustody>>> getCustodies({
    required GetCustodiesParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getCustodies(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<StockRequestEntity>>> getStockRequests() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getStockRequests();
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ScrapReasonEntity>>> getScrapReasons() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getScrapReasons();
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ScrapLot>>> getProductLots({
    required GetProductLotsParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getProductLots(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateScrapRequestResponse>> createScrapRequest({
    required CreateScrapRequestParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.createScrapRequest(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateScrapRequestResponse>> updateScrapRequest({
    required UpdateScrapRequestParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.updateScrapRequest(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
