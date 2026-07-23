import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entities/training_request/create_training_response.dart';
import '../../repository/repository.dart';
import 'create_training_request_use_case.dart';

class UpdateTrainingRequestUseCase
    extends UseCase<CreateTrainingResponse, UpdateTrainingRequestParams> {
  final StudyServicesRepository _repository;

  UpdateTrainingRequestUseCase(this._repository);

  @override
  Future<Either<Failure, CreateTrainingResponse>> call({
    required UpdateTrainingRequestParams params,
  }) async {
    return await _repository.updateTrainingRequest(params: params);
  }
}

class UpdateTrainingRequestParams extends Equatable {
  final int requestId;
  final CreateTrainingRequestParams data;

  /// Base64 payload of the attachment. Must never be the API's `"false"`
  /// sentinel — the server tries to base64-decode it and fails with
  /// "Invalid base64-encoded string".
  final String attachment;

  const UpdateTrainingRequestParams({
    required this.requestId,
    required this.data,
    this.attachment = '',
  });

  /// The update endpoint takes a flatter body than create: a single
  /// `attachment` string instead of `attachment_ids`, and no `stage_id`.
  Map<String, dynamic> toMap() => {
        'employee': data.employeeId,
        'office_id': data.officeId,
        'date': data.date,
        'course_id': data.courseId,
        'note': data.note,
        'attachment': attachment,
      };

  @override
  List<Object?> get props => [requestId, data, attachment];
}
