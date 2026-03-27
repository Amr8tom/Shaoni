import 'package:get_it/get_it.dart';
import '../../features/home/data/data_sources/local_data_sources.dart';
import '../../features/home/data/data_sources/remote_data_sources.dart';
import '../../features/home/data/repositories/repository.dart';
import '../../features/home/domain/repositories/home_repositories.dart';
import '../../features/navigation/domain/use_cases/get_user_data_use_case.dart';
import '../../features/home/presentation/controller/home_cubit.dart';


class HomeServiceLocator {
  static Future<void> execute({required GetIt serviceLocator}) async {
    /// data sources
    serviceLocator.registerLazySingleton<HomeRemoteDataSources>(
      () => HomeRemoteDataSourcesImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<HomeLocalDataSources>(
      () => HomeLocalDataSourcesImp(),
    );

    /// repositories
    serviceLocator.registerLazySingleton<HomeRepositories>(
      () => HomeRepositoriesImp(
        // serviceLocator(),
        // serviceLocator(),
        // serviceLocator(),
      ),
    );

    /// use cases
    serviceLocator.registerLazySingleton<GetUserDataUseCase>(
      () => GetUserDataUseCase(serviceLocator()),
    );


    /// controller
    serviceLocator.registerFactory<HomeCubit>(
      () => HomeCubit(
        serviceLocator()
      ),
    );
  }
}
