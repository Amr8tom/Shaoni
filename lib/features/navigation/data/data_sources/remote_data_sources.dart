import 'package:shaoni/core/constants/api_constants.dart';
import '../../../../core/dio/dio_helper.dart';
import '../../../../core/error/failure.dart';

abstract class NavigationRemoteDataSources {
  Future<int> getUnreadedNotifications();
}

class NavigationRemoteDataSourcesImp implements NavigationRemoteDataSources {
  final DioHelper _dio;

  const NavigationRemoteDataSourcesImp(this._dio);

  @override
  Future<int> getUnreadedNotifications() async {
    try {
      final response =
          await _dio.getData(URL: URL.getCountUnreadedNotificaion) as int;
      return response;
    } on ServerFailure {
      throw ServerFailure(message: "Server Failure");
    }
  }
}
