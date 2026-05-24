import 'package:get_it/get_it.dart';
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
import 'package:shaoni/features/human_resoures/presentation/controller/human_resources/human_resources_cubit.dart';
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
import '../../features/human_resoures/domain/use_cases/get_all_permission_services_use_case.dart';
import '../../features/human_resoures/domain/use_cases/exit/get_permission_time_use_case.dart';
import '../../features/human_resoures/domain/use_cases/exit/get_permission_types_use_case.dart';
import '../../features/human_resoures/presentation/controller/attendance/attendance_cubit.dart';
import '../../features/human_resoures/presentation/controller/exit_permission/exit_request_service_cubit.dart';
import '../../features/human_resoures/domain/use_cases/study/create_study_use_case.dart';
import '../../features/human_resoures/domain/use_cases/study/get_study_destinations_use_case.dart';
import '../../features/human_resoures/domain/use_cases/study/get_study_types_use_case.dart';
import '../../features/human_resoures/domain/use_cases/study/update_study_use_case.dart';
import '../../features/human_resoures/presentation/controller/study/study_cubit.dart';
import '../../features/human_resoures/domain/use_cases/start_work/get_start_work_types_use_case.dart';
import '../../features/human_resoures/domain/use_cases/start_work/get_employees_use_case.dart';
import '../../features/human_resoures/domain/use_cases/start_work/create_start_work_use_case.dart';
import '../../features/human_resoures/domain/use_cases/start_work/update_start_work_use_case.dart';
import '../../features/human_resoures/presentation/controller/start_work/start_work_cubit.dart';
import '../../features/human_resoures/domain/use_cases/experience_certificate/get_certificate_reasons_use_case.dart';
import '../../features/human_resoures/domain/use_cases/experience_certificate/create_experience_certificate_use_case.dart';
import '../../features/human_resoures/domain/use_cases/experience_certificate/update_experience_certificate_use_case.dart';
import '../../features/human_resoures/presentation/controller/experience_certificate/experience_certificate_cubit.dart';
import '../../features/human_resoures/domain/use_cases/id_document/get_departments_use_case.dart';
import '../../features/human_resoures/domain/use_cases/id_document/get_id_renewal_request_types_use_case.dart';
import '../../features/human_resoures/domain/use_cases/id_document/create_id_document_use_case.dart';
import '../../features/human_resoures/presentation/controller/id_document/id_document_cubit.dart';
import '../../features/human_resoures/domain/use_cases/medical_insurance/get_medical_insurance_classes_use_case.dart';
import '../../features/human_resoures/domain/use_cases/medical_insurance/get_employee_relatives_use_case.dart';
import '../../features/human_resoures/domain/use_cases/medical_insurance/create_medical_insurance_use_case.dart';
import '../../features/human_resoures/domain/use_cases/medical_insurance/update_medical_insurance_use_case.dart';
import '../../features/human_resoures/presentation/controller/medical_insurance/medical_insurance_cubit.dart';
import '../../features/human_resoures/domain/use_cases/training_request/get_courses_use_case.dart';
import '../../features/human_resoures/domain/use_cases/training_request/create_training_request_use_case.dart';
import '../../features/human_resoures/domain/use_cases/training_request/update_training_request_use_case.dart';
import '../../features/human_resoures/presentation/controller/training_request/training_request_cubit.dart';

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
    serviceLocator.registerLazySingleton<GetAllPermissionServicesUseCase>(
      () => GetAllPermissionServicesUseCase(serviceLocator()),
    );
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
    serviceLocator.registerFactory<HumanResourcesCubit>(
      () => HumanResourcesCubit(serviceLocator()),
    );
    serviceLocator.registerFactory<CarPermissionCubit>(
      () => CarPermissionCubit(
          serviceLocator(), serviceLocator(), serviceLocator(), serviceLocator()),
    );
    serviceLocator.registerFactory<ComplaintRequestCubit>(
      () => ComplaintRequestCubit(
          serviceLocator(), serviceLocator(), serviceLocator()),
    );
    /// ============================= study request =============================
    serviceLocator.registerLazySingleton<GetStudyTypesUseCase>(
      () => GetStudyTypesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetStudyDestinationsUseCase>(
      () => GetStudyDestinationsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateStudyUseCase>(
      () => CreateStudyUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateStudyUseCase>(
      () => UpdateStudyUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<StudyCubit>(
      () => StudyCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
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
    serviceLocator.registerLazySingleton<GetDepartmentsUseCase>(
      () => GetDepartmentsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetIDRenewalRequestTypesUseCase>(
      () => GetIDRenewalRequestTypesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateIDDocumentUseCase>(
      () => CreateIDDocumentUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<IDDocumentCubit>(
      () => IDDocumentCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
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

    /// ============================= training request =============================
    serviceLocator.registerLazySingleton<GetCoursesUseCase>(
      () => GetCoursesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateTrainingRequestUseCase>(
      () => CreateTrainingRequestUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateTrainingRequestUseCase>(
      () => UpdateTrainingRequestUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<TrainingRequestCubit>(
      () => TrainingRequestCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
  }
}
