import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import '../../entities/training_request/course.dart';
import '../../repository/repository.dart';

class GetCoursesUseCase extends UseCase<List<Course>, NoParams> {
  final StudyServicesRepository _repository;

  GetCoursesUseCase(this._repository);

  @override
  Future<Either<Failure, List<Course>>> call({
    required NoParams params,
  }) async {
    return await _repository.getCourses();
  }
}
