import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entities/study/create_study_response.dart';
import '../../repository/repository.dart';

class CreateStudyUseCase
    extends UseCase<CreateStudyResponse, CreateStudyParams> {
  final StudyServicesRepository _repository;

  CreateStudyUseCase(this._repository);

  @override
  Future<Either<Failure, CreateStudyResponse>> call({
    required CreateStudyParams params,
  }) async {
    return await _repository.createStudyRequest(params: params);
  }
}

class CreateStudyParams {
  final int employeeId;
  final int officeId;
  final String requestType;
  final String study;
  final int studyDestinationId;
  final String studyStartDate;
  final String studyEndDate;
  final String note;
  final String reason;
  final String attachmentName;
  final String attachment;

  const CreateStudyParams({
    required this.employeeId,
    required this.officeId,
    required this.requestType,
    required this.study,
    required this.studyDestinationId,
    required this.studyStartDate,
    required this.studyEndDate,
    required this.note,
    required this.reason,
    required this.attachmentName,
    required this.attachment,
  });

  Map<String, dynamic> toMap() {
    final attachments = attachment.isNotEmpty
        ? [
            {
              'name': attachmentName,
              'attachment_ids': [
                {'name': attachmentName, 'attachment': attachment}
              ],
            }
          ]
        : <Map<String, dynamic>>[];

    return {
      'employee': employeeId,
      'office_id': officeId,
      'request_type': requestType,
      'study': study,
      'study_destination_id': studyDestinationId,
      'study_start_date': studyStartDate,
      'study_end_date': studyEndDate,
      'note': note,
      'reason': reason,
      'comment': note,
      'study_request_attachment_ids': attachments,
    };
  }
}
