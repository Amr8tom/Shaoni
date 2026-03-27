import 'package:shaoni/core/constants/api_constants.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/auth/domain/entities/user_entity.dart';
import 'package:shaoni/features/navigation/data/model/user_model.dart';
import 'package:shaoni/features/navigation/data/model/user_model.dart';

import '../../../../core/dio/dio_helper.dart';
import '../../../navigation/domain/use_cases/get_user_data_use_case.dart';

abstract class HomeRemoteDataSources {
}

class HomeRemoteDataSourcesImp implements HomeRemoteDataSources {

  final DioHelper _dio;

  HomeRemoteDataSourcesImp(this._dio);



  }