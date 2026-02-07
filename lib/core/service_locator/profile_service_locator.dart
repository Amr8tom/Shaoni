// import 'package:get_it/get_it.dart';
// import '../../features/profile/data/data_sources/local_profile_data_sources.dart';
// import '../../features/profile/data/data_sources/remote_profile_data_sources.dart';
// import '../../features/profile/data/repositories/profile_repository_imp.dart';
// import '../../features/profile/domain/repositories/profile_repository.dart';
// import '../../features/profile/domain/usecases/arrival/get_luggage_use_case.dart';
// import '../../features/profile/domain/usecases/general/add_profile_image_use_case.dart';
// import '../../features/profile/domain/usecases/medical/get_medical_profile_use_case.dart';
// import '../../features/profile/domain/usecases/general/update_general_profile_use_case.dart';
// import '../../features/profile/domain/usecases/medical/update_medical_profile_use_case.dart';
// import '../../features/profile/presentation/controllers/general/general_profile_cubit.dart';
// import '../../features/profile/presentation/controllers/medical/medical_profile_cubit.dart';
// import '../../features/profile/domain/usecases/arrival/add_luggage_use_case.dart';
// import '../../features/profile/domain/usecases/arrival/get_arrival_use_case.dart';
// import '../../features/profile/domain/usecases/arrival/update_arrival_pilgrim_use_case.dart';
// import '../../features/profile/domain/usecases/general/get_general_profile_use_case.dart';
// import '../../features/profile/presentation/controllers/arrival/arrival_cubit.dart';
//
// class ProfileServiceLocator {
//   static Future<void> execute({required GetIt serviceLocator}) async {
//     /// data sources
//     serviceLocator.registerLazySingleton<LocalProfileDataSources>(
//       () => LocalProfileDataSourcesImp(),
//     );
//     serviceLocator.registerLazySingleton<RemoteProfileDataSources>(
//       () => RemoteProfileDataSourcesImp(serviceLocator()),
//     );
//
//     /// repositories
//     serviceLocator.registerLazySingleton<ProfileRepository>(
//       () => ProfileRepositoryImp(
//         serviceLocator(),
//         serviceLocator(),
//         serviceLocator(),
//       ),
//     );
//
//     /// use cases
//     serviceLocator.registerLazySingleton<GetGeneralProfileUseCase>(
//       () => GetGeneralProfileUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<UpdateGeneralProfileUseCase>(
//       () => UpdateGeneralProfileUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<GetMedicalProfileUseCase>(
//       () => GetMedicalProfileUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<UpdateMedicalProfileUseCase>(
//       () => UpdateMedicalProfileUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<UpdateArrivalPilgrimUseCase>(
//       () => UpdateArrivalPilgrimUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<AddLuggageUseCase>(
//       () => AddLuggageUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<GetLuggageUseCase>(
//       () => GetLuggageUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<GetArrivalUseCase>(
//       () => GetArrivalUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<AddProfileImageUseCase>(
//       () => AddProfileImageUseCase(serviceLocator()),
//     );
//
//     /// controller
//     serviceLocator.registerFactory<GeneralProfileCubit>(
//       () => GeneralProfileCubit(
//         serviceLocator(),
//         serviceLocator(),
//         serviceLocator(),
//       ),
//     );
//     serviceLocator.registerFactory<MedicalProfileCubit>(
//       () => MedicalProfileCubit(serviceLocator(), serviceLocator()),
//     );
//     serviceLocator.registerFactory<ArrivalCubit>(
//       () => ArrivalCubit(
//         serviceLocator(),
//         serviceLocator(),
//         serviceLocator(),
//         serviceLocator(),
//       ),
//     );
//   }
// }
