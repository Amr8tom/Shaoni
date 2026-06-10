import 'package:get_it/get_it.dart';
import '../../features/salaries/data/data_sources/salaries_local_data_source.dart';
import '../../features/salaries/data/data_sources/salaries_remote_data_source.dart';
import '../../features/salaries/data/repositories/salaries_repository_impl.dart';
import '../../features/salaries/domain/repository/salaries_repository.dart';
import '../../features/salaries/domain/use_cases/salary_requests/create_salary_use_case.dart';
import '../../features/salaries/domain/use_cases/salary_requests/edit_salary_use_case.dart';
import '../../features/salaries/domain/use_cases/salary_requests/get_banks_use_case.dart';
import '../../features/salaries/domain/use_cases/salary_requests/get_countries_use_case.dart';
import '../../features/salaries/domain/use_cases/salary_requests/get_letter_destinations_use_case.dart';
import '../../features/salaries/domain/use_cases/salary_requests/get_salary_document_types_use_case.dart';
import '../../features/salaries/domain/use_cases/salary_requests/get_salary_sub_types_use_case.dart';
import '../../features/salaries/domain/use_cases/salary_requests/get_salary_types_use_case.dart';
import '../../features/salaries/domain/use_cases/salary_requests/update_salary_use_case.dart';
import '../../features/salaries/presentation/controller/salary_requests/salary_requests_cubit.dart';

class SalariesServiceLocator {
  static Future<void> execute({required GetIt serviceLocator}) async {
    /// data sources
    serviceLocator.registerLazySingleton<SalariesRemoteDataSource>(
      () => SalariesRemoteDataSourceImpl(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<SalariesLocalDataSource>(
      () => SalariesLocalDataSourceImpl(serviceLocator()),
    );

    /// repositories
    serviceLocator.registerLazySingleton<SalariesRepository>(
      () => SalariesRepositoryImpl(
        remoteDataSource: serviceLocator(),
        localDataSource: serviceLocator(),
        networkInfo: serviceLocator(),
      ),
    );

    /// use Cases
    serviceLocator.registerLazySingleton<CreateSalaryUseCase>(
      () => CreateSalaryUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<UpdateSalaryUseCase>(
      () => UpdateSalaryUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<EditSalaryUseCase>(
      () => EditSalaryUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetSalaryTypesUseCase>(
      () => GetSalaryTypesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetSalarySubTypesUseCase>(
      () => GetSalarySubTypesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetSalaryDocumentTypesUseCase>(
      () => GetSalaryDocumentTypesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetCountriesUseCase>(
      () => GetCountriesUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetBanksUseCase>(
      () => GetBanksUseCase(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<GetLetterDestinationsUseCase>(
      () => GetLetterDestinationsUseCase(serviceLocator()),
    );

    /// cubit
    serviceLocator.registerFactory<SalaryRequestsCubit>(
      () => SalaryRequestsCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
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
