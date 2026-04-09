import 'package:get_it/get_it.dart';
import 'package:shaoni/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:shaoni/features/profile/presentation/controllers/profile_cubit.dart';

import '../../features/profile/data/data_sources/remote_data_sources.dart';
import '../../features/profile/data/repositories/repository.dart';
import '../../features/profile/domain/repositories/repository.dart';

class ProfileServiceLocator {
  static Future<void> execute({required GetIt serviceLocator}) async {
    /// data sources

    serviceLocator.registerLazySingleton<ProfileRemoteDataSources>(
      () => ProfileRemoteDataSourcesImpl(serviceLocator()),
    );

    /// repositories
    serviceLocator.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImp(
        serviceLocator(),
        serviceLocator(),
      ),
    );

    /// use cases
    serviceLocator.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(serviceLocator()),
    );

    /// controller
    serviceLocator.registerFactory<ProfileCubit>(() => ProfileCubit(
          updateProfileUseCase: serviceLocator(),
        ));
  }
}
