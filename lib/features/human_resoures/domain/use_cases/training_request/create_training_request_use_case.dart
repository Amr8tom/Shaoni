import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/training_request/create_training_response.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';

class CreateTrainingRequestUseCase
    extends UseCase<CreateTrainingResponse, CreateTrainingRequestParams> {
  final HRServicesRepository _repository;

  CreateTrainingRequestUseCase(this._repository);

  @override
  Future<Either<Failure, CreateTrainingResponse>> call({
    required CreateTrainingRequestParams params,
  }) async {
    return await _repository.createTrainingRequest(params: params);
  }
}

class CreateTrainingRequestParams extends Equatable {
  final int employeeId;
  final int officeId;
  final int stageId;
  final String date;
  final int courseId;
  final String note;
  final List<Map<String, dynamic>> attachmentIds;

  const CreateTrainingRequestParams({
    required this.employeeId,
    required this.officeId,
    this.stageId = 0,
    required this.date,
    required this.courseId,
    this.note = '',
    this.attachmentIds = const [],
  });

  Map<String, dynamic> toMap() => {
        'employee': employeeId,
        'office_id': officeId,
        'stage_id': stageId,
        'date': date,
        'course_id': courseId,
        'note': note,
        'attachment_ids': attachmentIds,
      };

  @override
  List<Object?> get props => [
        employeeId,
        officeId,
        stageId,
        date,
        courseId,
        note,
        attachmentIds,
      ];
}
