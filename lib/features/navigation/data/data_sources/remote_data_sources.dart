import 'package:shaoni/core/constants/api_constants.dart';
import '../../../../core/dio/dio_helper.dart';
import '../../../../core/error/failure.dart';
import '../../domain/use_cases/get_user_data_use_case.dart';
import '../model/user_model.dart';

abstract class NavigationRemoteDataSources {
  Future<int> getUnreadedNotifications();
  Future<UserModel> getUserData({required GetUserDataParams params});

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

  @override
  Future<UserModel> getUserData({required GetUserDataParams params}) async {

    try{
      final response = await _dio.getData(URL: URL.user+"${params.id}");
      if (response== null) {
        throw ServerFailure(message: "Server Failure");
      }
      return UserModel.fromJson(response);


    } on ServerFailure{
      throw ServerFailure(message: "Server Failure");
    }
  }
}
