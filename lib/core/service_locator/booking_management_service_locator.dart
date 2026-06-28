import 'package:get_it/get_it.dart';
import 'package:shaoni/features/booking_managment/data/data_sources/remote_data_sources.dart';
import 'package:shaoni/features/booking_managment/data/repositories/repository.dart';
import 'package:shaoni/features/booking_managment/domain/repository/repository.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/create_visa_request_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/get_active_languages_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/get_visa_employees_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/get_visa_types_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/update_visa_request_use_case.dart';
import 'package:shaoni/features/booking_managment/presentation/controller/visa_request/visa_request_cubit.dart';

class BookingManagementServiceLocator {
  static Future<void> execute({required GetIt serviceLocator}) async {
    /// data sources
    serviceLocator.registerLazySingleton<BookingManagementRemoteDataSources>(
      () => BookingManagementRemoteDataSourcesImp(serviceLocator()),
    );

    /// repository
    serviceLocator.registerLazySingleton<BookingManagementRepository>(
      () => BookingManagementRepositoryImp(serviceLocator()),
    );

    /// ============================ visa request ============================
    serviceLocator.registerLazySingleton<GetVisaTypesUseCase>(
      () => GetVisaTypesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetActiveLanguagesUseCase>(
      () => GetActiveLanguagesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetVisaEmployeesUseCase>(
      () => GetVisaEmployeesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<CreateVisaRequestUseCase>(
      () => CreateVisaRequestUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateVisaRequestUseCase>(
      () => UpdateVisaRequestUseCase(serviceLocator()),
    );
    serviceLocator.registerFactory<VisaRequestCubit>(
      () => VisaRequestCubit(
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
