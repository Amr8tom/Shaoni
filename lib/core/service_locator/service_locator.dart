import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shaoni/core/service_locator/profile_service_locator.dart';
import 'package:shaoni/core/service_locator/request_service_locator.dart';
import '../connection/checkNetwork.dart';
import '../dio/dio_helper.dart';
import '../utils/helpers/geolocator.dart';
import 'auth_service_locator.dart';
import 'home_service_locator.dart';
import 'language_service_locator.dart';
import 'navigation_servise_locator.dart';

final serviceLocator = GetIt.instance;

class DI {
  static execute() async {
    /// initial depended classes for all services
    serviceLocator.registerLazySingleton(() => DioHelper());
    serviceLocator.registerLazySingleton(() => DataConnectionChecker());
    // serviceLocator.registerLazySingleton(() => GeolocatorService());
    serviceLocator.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(serviceLocator()),
    );
    /// home
    // await HomeServiceLocator.execute(serviceLocator: serviceLocator);
    /// authentication
    await AuthServiceLocator.execute(serviceLocator: serviceLocator);
    /// navigation
    await NavigationServiseLocator.execute(serviceLocator: serviceLocator);
    /// language
    await LanguageServiceLocator.execute(serviceLocator: serviceLocator);
    /// profile
    await ProfileServiceLocator.execute(serviceLocator: serviceLocator);
    /// request service
    await RequestServiceLocator.execute(serviceLocator: serviceLocator);


    // /// delete account
    // await DeleteAccountServiceLocator.execute(serviceLocator: serviceLocator);

  }
}
