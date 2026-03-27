import 'package:shaoni/core/constants/api_constants.dart';
import 'package:shaoni/core/dio/dio_helper.dart';
import 'package:shaoni/features/my-requests/domain/entities/all_requests_with_stages.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/use_cases/get_all_user_requests_use_case.dart';

abstract class MyRequestsRemoteDataSources {
  Future<AllRequestsWithStages> getAllUserRequests({
    required GetAllUserRequestsParams params,
  });
}

class MyRequestsRemoteDataSourcesImp implements MyRequestsRemoteDataSources {
  final DioHelper _dio;

  const MyRequestsRemoteDataSourcesImp(this._dio);

  @override
  Future<AllRequestsWithStages> getAllUserRequests({
    required GetAllUserRequestsParams params,
  }) async {
    try {
      final response = await _dio.postData(
        URL: URL.getAllRequestsWithStages,
        body: params.toMap(),
      );
      return AllRequestsWithStages.fromJson(response!);
    } on ServerFailure {
      rethrow;
    }
  }
}
