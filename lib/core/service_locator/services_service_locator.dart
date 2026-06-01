
import 'package:get_it/get_it.dart';
import 'package:shaoni/features/services/data/data_sources/local_data_sources.dart';
import '../../features/services/data/data_sources/remote_data_sources.dart';
import '../../features/services/data/repositories/repository.dart';
import '../../features/services/domain/repository/repository.dart';
import '../../features/services/domain/use_cases/get_all_permission_services_use_case.dart';
import '../../features/services/presentation/controllers/services_cubit.dart';

class ServicesServiceLocator {
  static Future<void> execute({required GetIt serviceLocator}) async {
    /// data sources
    serviceLocator.registerLazySingleton<ServicesRemoteDataSources>(
          () => ServicesRemoteDataSourcesImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<ServicesLocalDataSources>(
          () => ServicesLocalDataSourcesImp(),
    );

    /// repositories

    serviceLocator.registerLazySingleton<ServicesRepository>(
          () => ServicesRepositoryImp(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );

    /// use cases

    serviceLocator.registerLazySingleton<GetAllPermissionServicesUseCase>(
          () => GetAllPermissionServicesUseCase(serviceLocator()),
    );

    /// controller
    serviceLocator.registerFactory<ServicesCubit>(()=>
        ServicesCubit(serviceLocator()),
    );
  }
}
