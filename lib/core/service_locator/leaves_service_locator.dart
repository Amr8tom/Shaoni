import 'package:get_it/get_it.dart';
import 'package:shaoni/features/leaves/data/data_sources/remote_data_sources.dart';
import 'package:shaoni/features/leaves/data/repositories/repository.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/create_leave_interruption_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/get_interruption_types_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/get_leave_types_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/search_employee_leaves_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/update_leave_interruption_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_replace/create_leave_replace_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_replace/update_leave_replace_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/get_leave_appointments_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/create_leave_request_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/update_leave_request_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/get_leave_employees_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/get_leave_request_for_edit_use_case.dart';
import 'package:shaoni/features/leaves/presentation/controller/leave_request/leave_request_cubit.dart';
import 'package:shaoni/features/leaves/presentation/controller/leave_interruption/leave_interruption_cubit.dart';
import 'package:shaoni/features/leaves/presentation/controller/leave_replace/leave_replace_cubit.dart';

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

    /// ============================ leave replace ============================
    serviceLocator.registerLazySingleton<CreateLeaveReplaceUseCase>(
      () => CreateLeaveReplaceUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateLeaveReplaceUseCase>(
      () => UpdateLeaveReplaceUseCase(serviceLocator()),
    );

    /// ============================ leave request ============================
    serviceLocator.registerLazySingleton<GetLeaveAppointmentsUseCase>(
      () => GetLeaveAppointmentsUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateLeaveRequestUseCase>(
      () => CreateLeaveRequestUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateLeaveRequestUseCase>(
      () => UpdateLeaveRequestUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetLeaveEmployeesUseCase>(
      () => GetLeaveEmployeesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetLeaveRequestForEditUseCase>(
      () => GetLeaveRequestForEditUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<LeaveRequestCubit>(
      () => LeaveRequestCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
    serviceLocator.registerFactory<LeaveReplaceCubit>(
      () => LeaveReplaceCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
  }
}
