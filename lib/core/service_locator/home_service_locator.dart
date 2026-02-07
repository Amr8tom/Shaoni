// import 'package:get_it/get_it.dart';
// import '../../features/home/data/data_sources/local_data_sources.dart';
// import '../../features/home/domain/use_cases/get_azan_timing_use_case.dart';
// import '../../features/home/domain/use_cases/get_current_event_use_case.dart';
// import '../../features/home/presentation/controller/home_cubit.dart';
// import '../../features/home/domain/use_cases/get_all_activites_usecase.dart';
// import '../../features/home/data/data_sources/remote_data_sources.dart';
// import '../../features/home/data/repositories/home_repositories_imp.dart';
// import '../../features/home/domain/repositories/repositories.dart';
// import '../../features/home/domain/use_cases/get_pilgrim_use_case.dart';
// import '../../features/home/domain/use_cases/get_today_notification_use_case.dart';
//
// class HomeServiceLocator {
//   static Future<void> execute({required GetIt serviceLocator}) async {
//     /// data sources
//     serviceLocator.registerLazySingleton<HomeRemoteDataSources>(
//       () => HomeRemoteDataSourcesImp(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<HomeLocalDataSources>(
//       () => HomeLocalDataSourcesImp(),
//     );
//
//     /// repositories
//     serviceLocator.registerLazySingleton<HomeRepositories>(
//       () => HomeRepositoriesImp(
//         serviceLocator(),
//         serviceLocator(),
//         serviceLocator(),
//       ),
//     );
//
//     /// use cases
//     serviceLocator.registerLazySingleton<GetPilgrimUseCase>(
//       () => GetPilgrimUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<GetAzanTimingUseCase>(
//       () => GetAzanTimingUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<GetTodayNotificationUseCase>(
//       () => GetTodayNotificationUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<GetCurrentEventUseCase>(
//       () => GetCurrentEventUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<GetAllActivitesUseCase>(
//           () => GetAllActivitesUseCase(serviceLocator()),
//     );
//
//     /// controller
//     serviceLocator.registerFactory<HomeCubit>(
//       () => HomeCubit(
//         serviceLocator(),
//         serviceLocator(),
//         serviceLocator(),
//         serviceLocator(),
//       ),
//     );
//   }
// }
