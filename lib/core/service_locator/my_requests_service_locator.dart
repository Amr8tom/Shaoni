import 'package:get_it/get_it.dart';

import '../../features/my-requests/domain/repositories/repository.dart';
import '../../features/my-requests/domain/use_cases/get_all_user_requests_use_case.dart';
import '../../features/my-requests/presentation/controller/my_requests_cubit.dart';
import '../../features/my-requests/presentation/data/data_sources/local_data_sources.dart';
import '../../features/my-requests/presentation/data/data_sources/remote_data_sources.dart';
import '../../features/my-requests/presentation/data/repositories/repository.dart';

class MyRequestsServiceLocator {
 static Future execute({required GetIt serviceLocator}) async {
    /// data sources
    serviceLocator.registerLazySingleton<MyRequestsRemoteDataSources>(
      () => MyRequestsRemoteDataSourcesImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<MyRequestsLocalDataSources>(() => MyRequestsLocalDataSourcesImp());

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

    /// controllers
    serviceLocator.registerFactory(() => MyRequestsCubit(serviceLocator()));
  }
}
