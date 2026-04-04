import 'package:get_it/get_it.dart';
import 'package:shaoni/features/profile/presentation/controllers/profile_cubit.dart';

class ProfileServiceLocator {
  static Future<void> execute({required GetIt serviceLocator}) async {
    // /// data sources
    // serviceLocator.registerLazySingleton<LocalProfileDataSources>(
    //   () => LocalProfileDataSourcesImp(),
    // );
    // serviceLocator.registerLazySingleton<RemoteProfileDataSources>(
    //   () => RemoteProfileDataSourcesImp(serviceLocator()),
    // );
    //
    // /// repositories
    // serviceLocator.registerLazySingleton<ProfileRepository>(
    //   () => ProfileRepositoryImp(
    //     serviceLocator(),
    //     serviceLocator(),
    //     serviceLocator(),
    //   ),
    // );
    //
    // /// use cases
    // serviceLocator.registerLazySingleton<GetGeneralProfileUseCase>(
    //   () => GetGeneralProfileUseCase(serviceLocator()),
    // );
    // serviceLocator.registerLazySingleton<UpdateGeneralProfileUseCase>(
    //   () => UpdateGeneralProfileUseCase(serviceLocator()),
    // );
    // serviceLocator.registerLazySingleton<GetMedicalProfileUseCase>(
    //   () => GetMedicalProfileUseCase(serviceLocator()),
    // );
    // serviceLocator.registerLazySingleton<UpdateMedicalProfileUseCase>(
    //   () => UpdateMedicalProfileUseCase(serviceLocator()),
    // );
    // serviceLocator.registerLazySingleton<UpdateArrivalPilgrimUseCase>(
    //   () => UpdateArrivalPilgrimUseCase(serviceLocator()),
    // );
    // serviceLocator.registerLazySingleton<AddLuggageUseCase>(
    //   () => AddLuggageUseCase(serviceLocator()),
    // );
    // serviceLocator.registerLazySingleton<GetLuggageUseCase>(
    //   () => GetLuggageUseCase(serviceLocator()),
    // );
    // serviceLocator.registerLazySingleton<GetArrivalUseCase>(
    //   () => GetArrivalUseCase(serviceLocator()),
    // );
    // serviceLocator.registerLazySingleton<AddProfileImageUseCase>(
    //   () => AddProfileImageUseCase(serviceLocator()),
    // );

    /// controller
    serviceLocator.registerFactory<ProfileCubit>(() => ProfileCubit());
  }
}
