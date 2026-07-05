import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shaoni/core/service_locator/booking_management_service_locator.dart';
import 'package:shaoni/core/service_locator/my_requests_service_locator.dart';
import 'package:shaoni/core/service_locator/profile_service_locator.dart';
import 'package:shaoni/core/service_locator/request_service_locator.dart';
import 'package:shaoni/core/service_locator/leaves_service_locator.dart';
import 'package:shaoni/core/service_locator/services_service_locator.dart';
import 'package:shaoni/core/service_locator/study_training_service_locator.dart';
import 'package:shaoni/core/service_locator/salaries_service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../connection/check_network.dart';
import '../dio/dio_helper.dart';
import '../local_storage/local_storage.dart';
import '../local_storage/session_storage/session_storage.dart';
import '../local_storage/session_storage/session_storage_impl.dart';
import '../local_storage/shared_preferences_local_storage.dart';
import 'auth_service_locator.dart';
import 'delete_account_service_locator.dart';
import 'home_service_locator.dart';
import 'language_service_locator.dart';
import 'navigation_service_locator.dart';

final serviceLocator = GetIt.instance;

class DI {
  static execute() async {
    /// local storage
    final sharedPreferences = await SharedPreferences.getInstance();
    serviceLocator.registerLazySingleton<SharedPreferences>(
      () => sharedPreferences,
    );
    serviceLocator.registerLazySingleton<LocalStorage>(
      () => SharedPreferencesLocalStorage(serviceLocator()),
    );
    serviceLocator.registerLazySingleton<SessionStorage>(
      () => SessionStorageImpl(serviceLocator()),
    );

    /// initial depended classes for all services
    serviceLocator.registerLazySingleton(() => DioHelper(serviceLocator()));
    serviceLocator.registerLazySingleton(() => DataConnectionChecker());
    // serviceLocator.registerLazySingleton(() => GeolocatorService());
    serviceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(serviceLocator()),
    );

    /// home
    await HomeServiceLocator.execute(serviceLocator: serviceLocator);

    /// authentication
    await AuthServiceLocator.execute(serviceLocator: serviceLocator);

    /// navigation
    await NavigationServiceLocator.execute(serviceLocator: serviceLocator);

    /// language
    await LanguageServiceLocator.execute(serviceLocator: serviceLocator);

    /// profile
    await ProfileServiceLocator.execute(serviceLocator: serviceLocator);

    /// My-requests
    await MyRequestsServiceLocator.execute(serviceLocator: serviceLocator);

    /// HR request service
    await HRServiceLocator.execute(serviceLocator: serviceLocator);

    /// Booking management
    await BookingManagementServiceLocator.execute(
        serviceLocator: serviceLocator);

    /// Leaves
    await LeavesServiceLocator.execute(serviceLocator: serviceLocator);

    /// Study & training
    await StudyTrainingServiceLocator.execute(serviceLocator: serviceLocator);

    /// Salaries
    await SalariesServiceLocator.execute(serviceLocator: serviceLocator);

    /// delete account
    await DeleteAccountServiceLocator.execute(serviceLocator: serviceLocator);

    /// services
    await ServicesServiceLocator.execute(serviceLocator: serviceLocator);
  }
}
