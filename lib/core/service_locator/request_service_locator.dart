import 'package:get_it/get_it.dart';
import 'package:shaoni/features/my-services/domain/use_cases/get_permission_time_use_case.dart';
import 'package:shaoni/features/my-services/domain/use_cases/get_permission_types_use_case.dart';

import '../../features/my-services/data/data_sources/local_data_sources.dart';
import '../../features/my-services/data/data_sources/remote_data_sources.dart';
import '../../features/my-services/data/repositories/repository.dart';
import '../../features/my-services/domain/repository/repository.dart';
import '../../features/my-services/domain/use_cases/create_exit_permission_use_case.dart';
import '../../features/my-services/domain/use_cases/get_all_permission_services_use_case.dart';
import '../../features/my-services/presentation/controller/my_services/my_services_cubit.dart';
import '../../features/my-services/presentation/controller/request_services/request_service_cubit.dart';

class RequestServiceLocator {
  static Future<void> execute({required GetIt serviceLocator}) async {
    /// data sources
    serviceLocator.registerLazySingleton<MyServicesRemoteDataSources>(
      () => MyServicesRemoteDataSourcesImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<MyServicesLocalDataSources>(
      () => MyServicesLocalDataSourcesImp(),
    );

    /// repositories
    serviceLocator.registerLazySingleton<ServicesRepository>(
      () => ServicesRepositoryImp(
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
    serviceLocator.registerFactory<MyServicesCubit>(
      () => MyServicesCubit(serviceLocator()),
    );
  }
}
