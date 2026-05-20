import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/experience_certificate/create_experience_certificate_response.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';

class CreateExperienceCertificateUseCase extends UseCase<
    CreateExperienceCertificateResponse, CreateExperienceCertificateParams> {
  final HRServicesRepository _repository;

  CreateExperienceCertificateUseCase(this._repository);

  @override
  Future<Either<Failure, CreateExperienceCertificateResponse>> call({
    required CreateExperienceCertificateParams params,
  }) async {
    return await _repository.createExperienceCertificate(params: params);
  }
}

class CreateExperienceCertificateParams extends Equatable {
  final int employee;
  final int officeId;
  final int certificateReasonId;
  final String reason;
  final String note;
  final String date;
  final List<Map<String, dynamic>> attachmentIds;

  const CreateExperienceCertificateParams({
    required this.employee,
    required this.officeId,
    required this.certificateReasonId,
    required this.reason,
    this.note = '',
    required this.date,
    this.attachmentIds = const [],
  });

  Map<String, dynamic> toMap() => {
        'employee': employee,
        'office_id': officeId,
        'certificate_reason_id': certificateReasonId,
        'reason': reason,
        'note': note,
        'date': date,
        'attachment_ids': attachmentIds,
      };

  @override
  List<Object?> get props =>
      [employee, officeId, certificateReasonId, reason, note, date, attachmentIds];
}
