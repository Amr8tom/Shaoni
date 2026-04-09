import 'package:shaoni/core/constants/api_constants.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/auth/domain/entities/user_entity.dart';
import 'package:shaoni/features/home/data/model/all_status_count_model.dart';
import 'package:shaoni/features/home/domain/entities/all_status_count.dart';
import 'package:shaoni/features/navigation/data/model/user_model.dart';
import 'package:shaoni/features/navigation/data/model/user_model.dart';

import '../../../../core/dio/dio_helper.dart';
import '../../../navigation/domain/use_cases/get_user_data_use_case.dart';

abstract class HomeRemoteDataSources {
  Future<List<AllStatusCountModel>> GetAllStatusCountForAllServices();
}

class HomeRemoteDataSourcesImp implements HomeRemoteDataSources {
  final DioHelper _dio;

  HomeRemoteDataSourcesImp(this._dio);

  @override
  Future<List<AllStatusCountModel>> GetAllStatusCountForAllServices() async {
    try {
      final response = await _dio.getData(URL: URL.getAllRequestsStatusCount);
      if (response == null) {
        throw ServerFailure(message: 'No Data');
      }
      return (response.data as List)
          .map((e) => AllStatusCountModel.fromJson(e))
          .toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}
