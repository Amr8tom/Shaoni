import '../../../../core/constants/api_constants.dart';
import '../../../../core/dio/dio_helper.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../../domain/use_cases/study/create_study_use_case.dart';
import '../../domain/use_cases/study/update_study_use_case.dart';
import '../../domain/use_cases/training_request/create_training_request_use_case.dart';
import '../../domain/use_cases/training_request/update_training_request_use_case.dart';
import '../model/study/create_study_model.dart';
import '../model/study/study_destination_model.dart';
import '../model/study/study_type_model.dart';
import '../model/training_request/course_model.dart';
import '../model/training_request/create_training_response_model.dart';

abstract class StudyServicesRemoteDataSources {
  /// ============================= study request =============================
  Future<List<StudyTypeModel>> getStudyTypes({required NoParams params});

  Future<List<StudyDestinationModel>> getStudyDestinations({
    required NoParams params,
  });

  Future<CreateStudyModel> createStudyRequest({
    required CreateStudyParams params,
  });

  Future<CreateStudyModel> updateStudyRequest({
    required UpdateStudyParams params,
  });

  /// ============================= training request =============================
  Future<List<CourseModel>> getCourses();

  Future<CreateTrainingResponseModel> createTrainingRequest({
    required CreateTrainingRequestParams params,
  });

  Future<CreateTrainingResponseModel> updateTrainingRequest({
    required UpdateTrainingRequestParams params,
  });
}

class StudyServicesRemoteDataSourcesImp
    implements StudyServicesRemoteDataSources {
  final DioHelper _dio;

  const StudyServicesRemoteDataSourcesImp(this._dio);

  /// ============================= study request =============================

  @override
  Future<List<StudyTypeModel>> getStudyTypes({required NoParams params}) async {
    try {
      final List response = await _dio.getData(URL: URL.getStudyTypes);
      if (response != null) {
        return response.map((e) => StudyTypeModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<StudyDestinationModel>> getStudyDestinations({
    required NoParams params,
  }) async {
    try {
      final response = await _dio.getData(URL: URL.getStudyDestinations);
      if (response != null) {
        final List data = response['data'] as List;
        return data.map((e) => StudyDestinationModel.fromJson(e)).toList();
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateStudyModel> createStudyRequest({
    required CreateStudyParams params,
  }) async {
    try {
      final response = await _dio.postData(
        URL: URL.createStudyRequest,
        body: params.toMap(),
      );
      if (response != null) {
        return CreateStudyModel.fromJson(response);
      } else {
        throw ServerFailure(message: 'server failure');
      }
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateStudyModel> updateStudyRequest({
    required UpdateStudyParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.updateStudyRequest}${params.requestId}',
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateStudyModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  /// ============================= training request =============================

  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      final response = await _dio.getData(URL: URL.getCourses);
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw = response is List
          ? response
          : (response as Map<String, dynamic>)['data'] as List;
      return raw.map((e) => CourseModel.fromJson(e)).toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateTrainingResponseModel> createTrainingRequest({
    required CreateTrainingRequestParams params,
  }) async {
    try {
      final response = await _dio.postData(
        URL: URL.createTrainingRequest,
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateTrainingResponseModel.fromJson(response);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateTrainingResponseModel> updateTrainingRequest({
    required UpdateTrainingRequestParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.updateTrainingRequest}${params.requestId}',
        body: params.data.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateTrainingResponseModel.fromJson(
          response.data as Map<String, dynamic>);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}
