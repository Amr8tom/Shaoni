import 'package:get_it/get_it.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_request_details_use_case.dart';
import '../../features/details_and_edit_for_requests/data/data_sources/local_data_sources.dart';
import '../../features/details_and_edit_for_requests/data/data_sources/remote_data_sources.dart';
import '../../features/details_and_edit_for_requests/data/repositories/repository.dart';
import '../../features/details_and_edit_for_requests/domain/repositories/repository.dart';
import '../../features/details_and_edit_for_requests/domain/use_cases/approve_request_use_case.dart';
import '../../features/details_and_edit_for_requests/domain/use_cases/get_all_manager_requests_use_case.dart';
import '../../features/details_and_edit_for_requests/domain/use_cases/get_all_user_requests_use_case.dart';
import '../../features/details_and_edit_for_requests/domain/use_cases/get_attendance_edit_use_case.dart';
import '../../features/details_and_edit_for_requests/domain/use_cases/get_car_permission_edit_use_case.dart';
import '../../features/details_and_edit_for_requests/domain/use_cases/get_exit_permission_edit_use_case.dart';
import '../../features/details_and_edit_for_requests/domain/use_cases/get_study_edit_use_case.dart';
import '../../features/details_and_edit_for_requests/domain/use_cases/get_start_work_edit_use_case.dart';
import '../../features/details_and_edit_for_requests/domain/use_cases/get_experience_certificate_edit_use_case.dart';
import '../../features/details_and_edit_for_requests/domain/use_cases/get_id_document_edit_use_case.dart';
import '../../features/details_and_edit_for_requests/domain/use_cases/get_medical_insurance_edit_use_case.dart';
import '../../features/details_and_edit_for_requests/domain/use_cases/get_training_request_edit_use_case.dart';
import '../../features/details_and_edit_for_requests/domain/use_cases/get_product_order_edit_use_case.dart';
import '../../features/details_and_edit_for_requests/presentation/controller/edit/edit_cubit.dart';
import '../../features/details_and_edit_for_requests/presentation/controller/my_requests_cubit.dart';

class MyRequestsServiceLocator {
  static Future execute({required GetIt serviceLocator}) async {
    /// data sources
    serviceLocator.registerLazySingleton<MyRequestsRemoteDataSources>(
      () => MyRequestsRemoteDataSourcesImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<MyRequestsLocalDataSources>(
        () => MyRequestsLocalDataSourcesImp());

    /// repositories
    serviceLocator.registerLazySingleton<MyRequestsRepository>(
      () => MyRequestsRepositoryImp(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );

    /// use cases
    serviceLocator.registerLazySingleton<GetAllUserRequestsUseCase>(
      () => GetAllUserRequestsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetAllManagerRequestsUseCase>(
      () => GetAllManagerRequestsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<ApproveRequestUseCase>(
      () => ApproveRequestUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetRequestDetailsUseCase>(
      () => GetRequestDetailsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetCarPermissionEditUseCase>(
      () => GetCarPermissionEditUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetExitPermissionEditUseCase>(
      () => GetExitPermissionEditUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetAttendanceEditUseCase>(
      () => GetAttendanceEditUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetStudyEditUseCase>(
      () => GetStudyEditUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetStartWorkEditUseCase>(
      () => GetStartWorkEditUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetExperienceCertificateEditUseCase>(
      () => GetExperienceCertificateEditUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetIDDocumentEditUseCase>(
      () => GetIDDocumentEditUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetMedicalInsuranceEditUseCase>(
      () => GetMedicalInsuranceEditUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetTrainingRequestEditUseCase>(
      () => GetTrainingRequestEditUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetProductOrderEditUseCase>(
      () => GetProductOrderEditUseCase(serviceLocator()),
    );

    /// controllers
    serviceLocator.registerFactory(() => MyRequestsCubit(
        serviceLocator(), serviceLocator(), serviceLocator(), serviceLocator()));
    serviceLocator.registerFactory<EditCubit>(
      () => EditCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
  }
}
