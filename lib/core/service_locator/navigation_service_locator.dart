import 'package:get_it/get_it.dart';
import 'package:shaoni/features/navigation/domain/use_cases/get_user_data_use_case.dart';
import 'package:shaoni/features/navigation/domain/use_cases/get_user_data_use_case.dart';

import '../../features/navigation/data/data_sources/local_data_sources.dart';
import '../../features/navigation/data/data_sources/remote_data_sources.dart';
import '../../features/navigation/data/repositories/repository.dart';
import '../../features/navigation/domain/repositories/repositories.dart';
import '../../features/navigation/domain/use_cases/get_count_unreaded_notification_use_case.dart';
import '../../features/navigation/presentation/controllers/navigation_cubit.dart';

class NavigationServiceLocator {
  static Future<void> execute({required GetIt serviceLocator}) async {
    /// data sources
    serviceLocator.registerLazySingleton<NavigationRemoteDataSources>(
      () => NavigationRemoteDataSourcesImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<NavigationLocalDataSources>(
      () => NavigationLocalDataSourcesImp(),
    );

    /// repositories

    serviceLocator.registerLazySingleton<NavigationRepository>(
      () => NavigationRepositoryImp(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );

    /// use cases
    // serviceLocator.registerLazySingleton<GetCountUnreadedNotificationUseCase>(
    //   () => GetCountUnreadedNotificationUseCase(serviceLocator()),
    // );
    serviceLocator.registerLazySingleton<GetUserDataUseCase>(
      () => GetUserDataUseCase(serviceLocator()),
    );

    /// controller
    serviceLocator.registerFactory<NavigationCubit>(()=>
      NavigationCubit(serviceLocator()),
    );
  }
}

