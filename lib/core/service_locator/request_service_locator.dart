import 'package:get_it/get_it.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/outside_working/get_attendance_way_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/outside_working/get_department_type_lookup_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/outside_working/get_project_type_lookup_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/outside_working/get_outside_working_employees_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/outside_working/get_outside_working_projects_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/outside_working/create_outside_working_use_case.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/outside_working/outside_working_cubit.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/get_all_missing_attendance_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/get_attendance_lookup_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/attendance/get_forget_reason_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/car_permission/get_car_brands_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/car_permission/get_car_colors_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/complaint_request/create_complaint_request_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/complaint_request/get_complaint_reasons_use_case.dart';
import 'package:shaoni/features/human_resoures/domain/use_cases/complaint_request/get_complaint_types_use_case.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/car_permission/car_permission_cubit.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/complaint_request/complaint_request_cubit.dart';
import '../../features/human_resoures/data/data_sources/local_data_sources.dart';
import '../../features/human_resoures/data/data_sources/remote_data_sources.dart';
import '../../features/human_resoures/data/repositories/repository.dart';
import '../../features/human_resoures/domain/repository/repository.dart';
import '../../features/human_resoures/domain/use_cases/attendance/create_attendance_use_case.dart';
import '../../features/human_resoures/domain/use_cases/car_permission/create_car_permission_use_case.dart';
import '../../features/human_resoures/domain/use_cases/car_permission/update_car_permission_use_case.dart';
import '../../features/human_resoures/domain/use_cases/attendance/update_attendance_use_case.dart';
import '../../features/human_resoures/domain/use_cases/exit/create_exit_permission_use_case.dart';
import '../../features/human_resoures/domain/use_cases/exit/update_exit_permission_use_case.dart';
import '../../features/human_resoures/domain/use_cases/exit/get_permission_time_use_case.dart';
import '../../features/human_resoures/domain/use_cases/exit/get_permission_types_use_case.dart';
import '../../features/human_resoures/presentation/controller/attendance/attendance_cubit.dart';
import '../../features/human_resoures/presentation/controller/exit_permission/exit_request_service_cubit.dart';
import '../../features/human_resoures/domain/use_cases/start_work/get_start_work_types_use_case.dart';
import '../../features/human_resoures/domain/use_cases/start_work/get_employees_use_case.dart';
import '../../features/human_resoures/domain/use_cases/start_work/create_start_work_use_case.dart';
import '../../features/human_resoures/domain/use_cases/start_work/update_start_work_use_case.dart';
import '../../features/human_resoures/presentation/controller/start_work/start_work_cubit.dart';
import '../../features/human_resoures/domain/use_cases/experience_certificate/get_certificate_reasons_use_case.dart';
import '../../features/human_resoures/domain/use_cases/experience_certificate/create_experience_certificate_use_case.dart';
import '../../features/human_resoures/domain/use_cases/experience_certificate/update_experience_certificate_use_case.dart';
import '../../features/human_resoures/presentation/controller/experience_certificate/experience_certificate_cubit.dart';
import '../../features/human_resoures/domain/use_cases/id_document/get_countries_use_case.dart';
import '../../features/human_resoures/domain/use_cases/id_document/get_id_renewal_request_types_use_case.dart';
import '../../features/human_resoures/domain/use_cases/id_document/create_id_document_use_case.dart';
import '../../features/human_resoures/presentation/controller/id_document/id_document_cubit.dart';
import '../../features/human_resoures/domain/use_cases/medical_insurance/get_medical_insurance_classes_use_case.dart';
import '../../features/human_resoures/domain/use_cases/medical_insurance/get_employee_relatives_use_case.dart';
import '../../features/human_resoures/domain/use_cases/medical_insurance/create_medical_insurance_use_case.dart';
import '../../features/human_resoures/domain/use_cases/medical_insurance/update_medical_insurance_use_case.dart';
import '../../features/human_resoures/presentation/controller/medical_insurance/medical_insurance_cubit.dart';
import '../../features/human_resoures/domain/use_cases/product_order/get_product_categories_use_case.dart';
import '../../features/human_resoures/domain/use_cases/product_order/get_products_by_category_use_case.dart';
import '../../features/human_resoures/domain/use_cases/product_order/create_product_order_use_case.dart';
import '../../features/human_resoures/domain/use_cases/product_order/update_product_order_use_case.dart';
import '../../features/human_resoures/presentation/controller/product_order/product_order_cubit.dart';

class HRServiceLocator {
  static Future<void> execute({required GetIt serviceLocator}) async {
    /// data sources
    serviceLocator.registerLazySingleton<HRServicesRemoteDataSources>(
      () => HRServicesRemoteDataSourcesImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<HRServicesLocalDataSources>(
      () => HRServicesLocalDataSourcesImp(),
    );

    /// repositories
    serviceLocator.registerLazySingleton<HRServicesRepository>(
      () => HRServicesRepositoryImp(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );

    /// use Cases
    serviceLocator.registerLazySingleton<CreateExitPermissionUseCase>(
      () => CreateExitPermissionUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetPermissionTimeUseCase>(
      () => GetPermissionTimeUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetPermissionTypesUseCase>(
      () => GetPermissionTypesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateExitPermissionUseCase>(
      () => UpdateExitPermissionUseCase(serviceLocator()),
    );

    /// ============================= attendance  =============================
    serviceLocator.registerLazySingleton<UpdateAttendanceUseCase>(
      () => UpdateAttendanceUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetAllMissingAttendanceUseCase>(
      () => GetAllMissingAttendanceUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateAttendanceUseCase>(
      () => CreateAttendanceUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetAttendanceLookupUseCase>(
      () => GetAttendanceLookupUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetForgetReasonUseCase>(
      () => GetForgetReasonUseCase(serviceLocator()),
    );

    /// ============================= car permission =============================
    serviceLocator.registerLazySingleton<GetCarColorsUseCase>(
      () => GetCarColorsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetCarBrandsUseCase>(
      () => GetCarBrandsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateCarPermissionUseCase>(
      () => CreateCarPermissionUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateCarPermissionUseCase>(
      () => UpdateCarPermissionUseCase(serviceLocator()),
    );

    /// ============================= complaint request =============================
    serviceLocator.registerLazySingleton<GetComplaintTypesUseCase>(
      () => GetComplaintTypesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetComplaintReasonsUseCase>(
      () => GetComplaintReasonsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateComplaintRequestUseCase>(
      () => CreateComplaintRequestUseCase(serviceLocator()),
    );

    /// register cubit
    serviceLocator.registerFactory<ExitRequestServiceCubit>(
      () => ExitRequestServiceCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
    serviceLocator.registerFactory<AttendanceCubit>(
      () => AttendanceCubit(serviceLocator(), serviceLocator(),
          serviceLocator(), serviceLocator(), serviceLocator()),
    );

    serviceLocator.registerFactory<CarPermissionCubit>(
      () => CarPermissionCubit(serviceLocator(), serviceLocator(),
          serviceLocator(), serviceLocator()),
    );
    serviceLocator.registerFactory<ComplaintRequestCubit>(
      () => ComplaintRequestCubit(
          serviceLocator(), serviceLocator(), serviceLocator()),
    );

    /// ============================= start work =============================
    serviceLocator.registerLazySingleton<GetStartWorkTypesUseCase>(
      () => GetStartWorkTypesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetEmployeesUseCase>(
      () => GetEmployeesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateStartWorkUseCase>(
      () => CreateStartWorkUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateStartWorkUseCase>(
      () => UpdateStartWorkUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<StartWorkCubit>(
      () => StartWorkCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );

    /// ============================= experience certificate =============================
    serviceLocator.registerLazySingleton<GetCertificateReasonsUseCase>(
      () => GetCertificateReasonsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateExperienceCertificateUseCase>(
      () => CreateExperienceCertificateUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateExperienceCertificateUseCase>(
      () => UpdateExperienceCertificateUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<ExperienceCertificateCubit>(
      () => ExperienceCertificateCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );

    /// ============================= id document =============================
    serviceLocator.registerLazySingleton<GetCountriesUseCase>(
      () => GetCountriesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetIDRenewalRequestTypesUseCase>(
      () => GetIDRenewalRequestTypesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateIDDocumentUseCase>(
      () => CreateIDDocumentUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<IDDocumentCubit>(
      () => IDDocumentCubit(
        serviceLocator<GetCountriesUseCase>(),
        serviceLocator<GetIDRenewalRequestTypesUseCase>(),
        serviceLocator<CreateIDDocumentUseCase>(),
      ),
    );

    /// ============================= medical insurance =============================
    serviceLocator.registerLazySingleton<GetMedicalInsuranceClassesUseCase>(
      () => GetMedicalInsuranceClassesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetEmployeeRelativesUseCase>(
      () => GetEmployeeRelativesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateMedicalInsuranceUseCase>(
      () => CreateMedicalInsuranceUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateMedicalInsuranceUseCase>(
      () => UpdateMedicalInsuranceUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<MedicalInsuranceCubit>(
      () => MedicalInsuranceCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );

    /// ============================= product order =============================
    serviceLocator.registerLazySingleton<GetProductCategoriesUseCase>(
      () => GetProductCategoriesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetProductsByCategoryUseCase>(
      () => GetProductsByCategoryUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateProductOrderUseCase>(
      () => CreateProductOrderUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateProductOrderUseCase>(
      () => UpdateProductOrderUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<ProductOrderCubit>(
      () => ProductOrderCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );

    /// ============================ outside working ============================
    serviceLocator.registerLazySingleton<GetAttendanceWayUseCase>(
      () => GetAttendanceWayUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetDepartmentTypeLookupUseCase>(
      () => GetDepartmentTypeLookupUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetProjectTypeLookupUseCase>(
      () => GetProjectTypeLookupUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetOutsideWorkingEmployeesUseCase>(
      () => GetOutsideWorkingEmployeesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetOutsideWorkingProjectsUseCase>(
      () => GetOutsideWorkingProjectsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateOutsideWorkingUseCase>(
      () => CreateOutsideWorkingUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<OutsideWorkingCubit>(
      () => OutsideWorkingCubit(
        serviceLocator<GetAttendanceWayUseCase>(),
        serviceLocator<GetDepartmentTypeLookupUseCase>(),
        serviceLocator<GetProjectTypeLookupUseCase>(),
        serviceLocator<GetOutsideWorkingEmployeesUseCase>(),
        serviceLocator<GetOutsideWorkingProjectsUseCase>(),
        serviceLocator<CreateOutsideWorkingUseCase>(),
      ),
    );
  }
}
