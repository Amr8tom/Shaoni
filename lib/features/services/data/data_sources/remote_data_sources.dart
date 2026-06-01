import '../../../../core/constants/api_constants.dart';
import '../../../../core/dio/dio_helper.dart';
import '../../../../core/error/failure.dart';

import '../model/all_services_model.dart';

abstract class ServicesRemoteDataSources {
  /// get all services
  Future<AllServicesModel> getAllServices();
}

class ServicesRemoteDataSourcesImp implements ServicesRemoteDataSources {
  final DioHelper _dio;

  const ServicesRemoteDataSourcesImp(this._dio);

  @override
  Future<AllServicesModel> getAllServices() async {
    try {
      final response = await _dio.getData(URL: URL.getAllServices);
      if (response != null) {
        return AllServicesModel.fromJson(response);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}
