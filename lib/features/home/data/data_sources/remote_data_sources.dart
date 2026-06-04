import 'package:shaoni/core/constants/api_constants.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/home/data/model/all_status_count_model.dart';

import '../../../../core/dio/dio_helper.dart';

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
      return (response as List)
          .map((e) => AllStatusCountModel.fromJson(e))
          .toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}
