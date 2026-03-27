import 'package:shaoni/core/constants/api_constants.dart';
import 'package:shaoni/core/dio/dio_helper.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/auth/data/model/login_model.dart';
import 'package:shaoni/features/auth/data/model/login_model.dart';
import 'package:shaoni/features/auth/domain/entities/login.dart';
import 'package:shaoni/features/auth/domain/entities/login.dart';
import 'package:shaoni/features/auth/presentation/controller/login/login_cubit.dart';

import '../../domain/usecases/login_use_case.dart';

abstract class AuthRemoteDataSources {
  /// login
  Future<LoginEntity> login({required LoginParams params});
}


class AuthRemoteDataSourcesImp implements AuthRemoteDataSources {
  final DioHelper _dio;

  const AuthRemoteDataSourcesImp(this._dio);

  @override
  Future<LoginEntity> login({required LoginParams params}) async {
    final reponse = await _dio.postData(URL: URL.login,body: params.toJson());
   if (reponse != null) {
      return LoginModel.fromJson(reponse);
    } else {
      throw ServerFailure(message: 'server failure');
    }
  
  }

}