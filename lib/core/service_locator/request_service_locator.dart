import 'package:get_it/get_it.dart';
import 'package:shaoni/features/human_resoures/presentation/controller/human_resources/human_resources_cubit.dart';

import '../../features/human_resoures/data/data_sources/local_data_sources.dart';
import '../../features/human_resoures/data/data_sources/remote_data_sources.dart';
import '../../features/human_resoures/data/repositories/repository.dart';
import '../../features/human_resoures/domain/repository/repository.dart';
import '../../features/human_resoures/domain/use_cases/create_exit_permission_use_case.dart';
import '../../features/human_resoures/domain/use_cases/get_all_permission_services_use_case.dart';
import '../../features/human_resoures/domain/use_cases/get_permission_time_use_case.dart';
import '../../features/human_resoures/domain/use_cases/get_permission_types_use_case.dart';
import '../../features/human_resoures/presentation/controller/request_services/request_service_cubit.dart';

class RequestServiceLocator {
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

    /// register cubit
    serviceLocator.registerFactory<RequestServiceCubit>(
      () => RequestServiceCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
    serviceLocator.registerFactory<HumanResourcesCubit>(
      () => HumanResourcesCubit(serviceLocator()),
    );
  }
}
