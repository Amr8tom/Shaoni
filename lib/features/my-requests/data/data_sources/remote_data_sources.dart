import 'package:shaoni/core/constants/api_constants.dart';
import 'package:shaoni/core/dio/dio_helper.dart';
import 'package:shaoni/features/my-requests/domain/entities/all_requests_with_stages.dart';
import 'package:shaoni/features/my-requests/domain/entities/request_with_stage.dart';
import 'package:shaoni/features/my-requests/domain/use_cases/approve_request_use_case.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/use_cases/get_all_manager_requests_use_case.dart';
import '../../domain/use_cases/get_all_user_requests_use_case.dart';
import '../../domain/use_cases/get_request_details_use_case.dart';
import '../models/approve_request_model.dart';

abstract class MyRequestsRemoteDataSources {
  Future<AllRequestsWithStages> getAllUserRequests({
    required GetAllUserRequestsParams params,
  });

  Future<RequestWithStage> getRequestDetails(
      {required GetRequestDetailsParams params});

  Future<AllRequestsWithStages> getAllManagerRequests({
    required GetAllManagerRequestsParams params,
  });

  Future<ApproveRequestModel> acceptRequest({
    required AcceptRequestParams params,
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
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return AllRequestsWithStages.fromJson(response);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<AllRequestsWithStages> getAllManagerRequests(
      {required GetAllManagerRequestsParams params}) async {
    try {
      final response = await _dio.postData(
        URL: URL.getAllRequestsWithStagesByManager,
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return AllRequestsWithStages.fromJson(response);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<ApproveRequestModel> acceptRequest(
      {required AcceptRequestParams params}) async {
    try {
      final response = await _dio.putData(
          URL: '${URL.approveRequest}${params.id}', body: params.toJson());
      return ApproveRequestModel.fromJson(response.data);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<RequestWithStage> getRequestDetails(
      {required GetRequestDetailsParams params}) async {
    try {
      final response = await _dio.getData(
        URL: URL.getRequestDetailsStages +
            params.requestId.toString() +
            '/with-stages',
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return RequestWithStage.fromJson(response);
    } on ServerFailure {
      rethrow;
    }
  }
}
