import '../../../../core/constants/api_constants.dart';
import '../../../../core/dio/dio_helper.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecases/base_usecase.dart';

abstract class DeleteRemoteDataSources {
  Future<dynamic> deleteAccount({required NoParams params});
}

class DeleteRemoteDataSourcesImp implements DeleteRemoteDataSources {
  final DioHelper _dio;

  const DeleteRemoteDataSourcesImp(this._dio);

  @override
  Future<dynamic> deleteAccount({required NoParams params}) async {
    try {
      final response = await _dio.deleteData(URL: URL.deleteAccount);
      return response.data;
    } on ServerFailure {
      throw ServerFailure(message: "Server Failure");
    }
  }
}
