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
import '../../features/human_resoures/presentation/controller/study/study_cubit.dart';

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
    serviceLocator.registerFactory<StudyCubit>(
      () => StudyCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
  }
}
