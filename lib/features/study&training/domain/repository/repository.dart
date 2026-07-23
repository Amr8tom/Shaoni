import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../entities/study/create_study_response.dart';
import '../entities/study/study_edit_data.dart';
import '../entities/training_request/training_edit_data.dart';
import '../use_cases/study/get_study_for_edit_use_case.dart';
import '../use_cases/training_request/get_training_for_edit_use_case.dart';
import '../entities/study/study_destination.dart';
import '../entities/study/study_type.dart';
import '../entities/training_request/course.dart';
import '../entities/training_request/create_training_response.dart';
import '../use_cases/study/create_study_use_case.dart';
import '../use_cases/study/update_study_use_case.dart';
import '../use_cases/training_request/create_training_request_use_case.dart';
import '../use_cases/training_request/update_training_request_use_case.dart';

abstract class StudyServicesRepository {
  /// ///////////////////////////////////// study request /////////////////////////////////////////////////////
  Future<Either<Failure, List<StudyType>>> getStudyTypes({
    required NoParams params,
  });

  Future<Either<Failure, List<StudyDestination>>> getStudyDestinations({
    required NoParams params,
  });

  Future<Either<Failure, CreateStudyResponse>> createStudyRequest({
    required CreateStudyParams params,
  });

  Future<Either<Failure, StudyEditData>> getStudyForEdit({
    required GetStudyForEditParams params,
  });

  Future<Either<Failure, CreateStudyResponse>> updateStudyRequest({
    required UpdateStudyParams params,
  });

  /// ///////////////////////////////////// training request /////////////////////////////////////////////////////
  Future<Either<Failure, List<Course>>> getCourses();

  Future<Either<Failure, CreateTrainingResponse>> createTrainingRequest({
    required CreateTrainingRequestParams params,
  });

  Future<Either<Failure, TrainingEditData>> getTrainingForEdit({
    required GetTrainingForEditParams params,
  });

  Future<Either<Failure, CreateTrainingResponse>> updateTrainingRequest({
    required UpdateTrainingRequestParams params,
  });
}
