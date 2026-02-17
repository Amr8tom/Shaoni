// import 'package:get_it/get_it.dart';
// import '../../features/auth/data/repositories/auth_repositories_imp.dart';
// import '../../features/auth/domain/repositories/auth_repositories.dart';
// import '../../features/auth/domain/usecases/login_pilgrim_use_case.dart';
// import '../../features/auth/domain/usecases/register_pilgrim_use_case.dart';
// import '../../features/auth/domain/usecases/resend_otp_use_case.dart';
// import '../../features/auth/domain/usecases/send_otp_use_case.dart';
// import '../../features/auth/presentation/controller/forget_password/forget_password_cubit.dart';
// import '../../features/auth/presentation/controller/login/login_cubit.dart';
// import '../../features/auth/presentation/controller/register/register_cubit.dart';
// import '../../features/auth/presentation/controller/set_password/set_password_cubit.dart';
// import '../../features/auth/data/data_source/auth_local_data_sources.dart';
// import '../../features/auth/data/data_source/auth_remote_data_sources.dart';
// import '../../features/auth/domain/usecases/forget_password_use_case.dart';
// import '../../features/auth/domain/usecases/set_password_use_case.dart';
//
// class AuthServiceLocator {
//   static Future<void> execute({required GetIt serviceLocator}) async {
//     /// data sources
//     serviceLocator.registerLazySingleton<AuthLocalDataSources>(
//       () => AuthLocalDataSourcesImp(),
//     );
//     serviceLocator.registerLazySingleton<AuthRemoteDataSources>(
//       () => AuthRemoteDataSourcesImp(serviceLocator()),
//     );
//
//     /// repositories
//     serviceLocator.registerLazySingleton<AuthRepositories>(
//       () => AuthRepositoriesImp(
//         serviceLocator(),
//         serviceLocator(),
//         serviceLocator(),
//       ),
//     );
//
//     /// use cases
//     serviceLocator.registerLazySingleton<LoginPilgrimUseCase>(
//       () => LoginPilgrimUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<RegisterPilgrimUseCase>(
//       () => RegisterPilgrimUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<SendOtpUseCase>(
//       () => SendOtpUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<ResendOtpUseCase>(
//       () => ResendOtpUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<ForgetPasswordUseCase>(
//       () => ForgetPasswordUseCase(serviceLocator()),
//     );
//     serviceLocator.registerLazySingleton<SetPasswordUseCase>(
//       () => SetPasswordUseCase(serviceLocator()),
//     );
//
//     /// controller
//     serviceLocator.registerFactory<LoginCubit>(
//       () => LoginCubit(serviceLocator(), serviceLocator(), serviceLocator()),
//     );
//     serviceLocator.registerFactory<RegisterCubit>(
//       () => RegisterCubit(serviceLocator()),
//     );
//     serviceLocator.registerFactory<SetPasswordCubit>(
//       () => SetPasswordCubit(serviceLocator()),
//     );
//
//     /// forget password controllers
//     serviceLocator.registerFactory<ForgetPasswordCubit>(
//       () => ForgetPasswordCubit(serviceLocator()),
//     );
//   }
// }
