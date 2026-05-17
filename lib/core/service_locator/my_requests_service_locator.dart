import 'package:get_it/get_it.dart';
import 'package:shaoni/features/my-requests/domain/use_cases/get_request_details_use_case.dart';

import '../../features/my-requests/data/data_sources/local_data_sources.dart';
import '../../features/my-requests/data/data_sources/remote_data_sources.dart';
import '../../features/my-requests/data/repositories/repository.dart';
import '../../features/my-requests/domain/repositories/repository.dart';
import '../../features/my-requests/domain/use_cases/approve_request_use_case.dart';
import '../../features/my-requests/domain/use_cases/get_all_manager_requests_use_case.dart';
import '../../features/my-requests/domain/use_cases/get_all_user_requests_use_case.dart';
import '../../features/my-requests/domain/use_cases/get_attendance_edit_use_case.dart';
import '../../features/my-requests/domain/use_cases/get_car_permission_edit_use_case.dart';
import '../../features/my-requests/domain/use_cases/get_exit_permission_edit_use_case.dart';
import '../../features/my-requests/presentation/controller/edit/edit_cubit.dart';
import '../../features/my-requests/presentation/controller/my_requests_cubit.dart';

class MyRequestsServiceLocator {
  static Future execute({required GetIt serviceLocator}) async {
    /// data sources
    serviceLocator.registerLazySingleton<MyRequestsRemoteDataSources>(
      () => MyRequestsRemoteDataSourcesImp(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<MyRequestsLocalDataSources>(
        () => MyRequestsLocalDataSourcesImp());

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
    serviceLocator.registerLazySingleton<GetAllManagerRequestsUseCase>(
      () => GetAllManagerRequestsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<ApproveRequestUseCase>(
      () => ApproveRequestUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetRequestDetailsUseCase>(
      () => GetRequestDetailsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetCarPermissionEditUseCase>(
      () => GetCarPermissionEditUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetExitPermissionEditUseCase>(
      () => GetExitPermissionEditUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetAttendanceEditUseCase>(
      () => GetAttendanceEditUseCase(serviceLocator()),
    );

    /// controllers
    serviceLocator.registerFactory(() => MyRequestsCubit(
        serviceLocator(), serviceLocator(), serviceLocator(), serviceLocator()));
    serviceLocator.registerFactory<EditCubit>(
      () => EditCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
  }
}
