import 'package:get_it/get_it.dart';
import 'package:shaoni/features/auth/domain/usecases/change_password_use_case.dart';

import '../../features/auth/data/data_sources/remote_data_sources.dart';
import '../../features/auth/data/repositories/auth_repositories.dart';
import '../../features/auth/domain/repositories/auth_repositories.dart';
import '../../features/auth/domain/usecases/login_use_case.dart';
import '../../features/auth/domain/usecases/request_otp_use_case.dart';
import '../../features/auth/domain/usecases/verify_otp_use_case.dart';
import '../../features/auth/presentation/controller/login/login_cubit.dart';
import '../../features/auth/presentation/controller/otp/otp_cubit.dart';

class AuthServiceLocator {
  static Future<void> execute({required GetIt serviceLocator}) async {

    serviceLocator.registerLazySingleton<AuthRemoteDataSources>(
      () => AuthRemoteDataSourcesImp(serviceLocator()),
    );

    /// repositories
    serviceLocator.registerLazySingleton<AuthRepositories>(
      () => AuthRepositoriesImp(
        serviceLocator(),
        serviceLocator(),
      ),
    );

    /// use cases
    serviceLocator.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<RequestOtpUseCase>(
      () => RequestOtpUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(serviceLocator()),
    );

    /// controller
    serviceLocator.registerFactory<LoginCubit>(
      () => LoginCubit(serviceLocator(), serviceLocator(), serviceLocator()),
    );
    serviceLocator.registerFactory<OtpCubit>(
      () => OtpCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
    // serviceLocator.registerFactory<RegisterCubit>(
    //   () => RegisterCubit(serviceLocator()),
    // );
    // serviceLocator.registerFactory<SetPasswordCubit>(
    //   () => SetPasswordCubit(serviceLocator()),
    // );

    // /// forget password controllers
    // serviceLocator.registerFactory<ForgetPasswordCubit>(
    //   () => ForgetPasswordCubit(serviceLocator()),
    // );
  }
}
