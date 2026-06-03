import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

import '../../../data/model/complaint_request/create_complaint_request_model.dart';

class CreateComplaintRequestUseCase
    extends UseCase<CreateComplaintRequestModel, CreateComplaintRequestParams> {
  final HRServicesRepository repository;

  CreateComplaintRequestUseCase(this.repository);

  @override
  Future<Either<Failure, CreateComplaintRequestModel>> call({
    required CreateComplaintRequestParams params,
  }) async {
    return await repository.createComplaintRequest(params: params);
  }
}

class CreateComplaintRequestParams {
  final int employeeId;
  final int? officeId;
  final int? complaintTypeId;
  final int? complaintReasonId;
  final String? complaintDescription;
  final String? date;
  final String? attachmentName;
  final String? attachment;

  CreateComplaintRequestParams({
    required this.employeeId,
    required this.officeId,
    required this.complaintTypeId,
    required this.complaintReasonId,
    required this.complaintDescription,
    required this.date,
    required this.attachmentName,
    required this.attachment,
  });

  /// Converts to the JSON body expected by the API.
  Map<String, dynamic> toMap() {
    return {
      'employee_id': employeeId,
      'office_id': officeId ?? 0,
      'complaint_type_id': complaintTypeId,
      'complaint_reason_id': complaintReasonId,
      'complaint_description': complaintDescription ?? '',
      'date': date,
      'complaint_attachment_ids': [
        {
          'name': attachmentName ?? '',
          'attachment': attachment ?? '',
        }
      ],
    };
  }
}
