import 'package:get_it/get_it.dart';

import '../../features/my-services/presentation/controller/request_service_cubit.dart';

class RequestServiceLocator {
  static Future<void> execute({required GetIt serviceLocator}) async {
    /// register cubit
    serviceLocator.registerFactory<RequestServiceCubit>(
      () => RequestServiceCubit(),
    );


  }

  }