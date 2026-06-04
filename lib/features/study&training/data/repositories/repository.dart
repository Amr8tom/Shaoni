import 'package:dartz/dartz.dart';
import '../../../../core/connection/checkNetwork.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../../domain/entities/study/create_study_response.dart';
import '../../domain/entities/study/study_destination.dart';
import '../../domain/entities/study/study_type.dart';
import '../../domain/entities/training_request/course.dart';
import '../../domain/entities/training_request/create_training_response.dart';
import '../../domain/repository/repository.dart';
import '../../domain/use_cases/study/create_study_use_case.dart';
import '../../domain/use_cases/study/update_study_use_case.dart';
import '../../domain/use_cases/training_request/create_training_request_use_case.dart';
import '../../domain/use_cases/training_request/update_training_request_use_case.dart';
import '../data_sources/local_data_sources.dart';
import '../data_sources/remote_data_sources.dart';

class StudyServicesRepositoryImp extends StudyServicesRepository {
  final StudyServicesLocalDataSources _local;
  final StudyServicesRemoteDataSources _remote;
  final NetworkInfo _networkInfo;

  StudyServicesRepositoryImp(this._local, this._remote, this._networkInfo);

  /// ===================== study request =====================

  @override
  Future<Either<Failure, List<StudyType>>> getStudyTypes({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getStudyTypes(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<StudyDestination>>> getStudyDestinations({
    required NoParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getStudyDestinations(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateStudyResponse>> createStudyRequest({
    required CreateStudyParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.createStudyRequest(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateStudyResponse>> updateStudyRequest({
    required UpdateStudyParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.updateStudyRequest(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  /// ===================== training request =====================

  @override
  Future<Either<Failure, List<Course>>> getCourses() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.getCourses();
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateTrainingResponse>> createTrainingRequest({
    required CreateTrainingRequestParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.createTrainingRequest(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreateTrainingResponse>> updateTrainingRequest({
    required UpdateTrainingRequestParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remote.updateTrainingRequest(params: params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
