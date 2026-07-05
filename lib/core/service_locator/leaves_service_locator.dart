import 'package:get_it/get_it.dart';
import 'package:shaoni/features/leaves/data/data_sources/remote_data_sources.dart';
import 'package:shaoni/features/leaves/data/repositories/repository.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/create_leave_interruption_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/get_interruption_types_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/get_leave_types_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/search_employee_leaves_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/update_leave_interruption_use_case.dart';
import 'package:shaoni/features/leaves/presentation/controller/leave_interruption/leave_interruption_cubit.dart';

class LeavesServiceLocator {
  static Future<void> execute({required GetIt serviceLocator}) async {
    /// data sources
    serviceLocator.registerLazySingleton<LeavesRemoteDataSources>(
      () => LeavesRemoteDataSourcesImp(serviceLocator()),
    );

    /// repository
    serviceLocator.registerLazySingleton<LeavesRepository>(
      () => LeavesRepositoryImp(serviceLocator()),
    );

    /// ============================ leave interruption ============================
    serviceLocator.registerLazySingleton<GetInterruptionTypesUseCase>(
      () => GetInterruptionTypesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetLeaveTypesUseCase>(
      () => GetLeaveTypesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<SearchEmployeeLeavesUseCase>(
      () => SearchEmployeeLeavesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateLeaveInterruptionUseCase>(
      () => CreateLeaveInterruptionUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateLeaveInterruptionUseCase>(
      () => UpdateLeaveInterruptionUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<LeaveInterruptionCubit>(
      () => LeaveInterruptionCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
  }
}
