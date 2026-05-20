import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/id_document/create_id_document_response.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';

class CreateIDDocumentUseCase
    extends UseCase<CreateIDDocumentResponse, CreateIDDocumentParams> {
  final HRServicesRepository _repository;

  CreateIDDocumentUseCase(this._repository);

  @override
  Future<Either<Failure, CreateIDDocumentResponse>> call({
    required CreateIDDocumentParams params,
  }) async {
    return await _repository.createIDDocument(params: params);
  }
}

class CreateIDDocumentParams extends Equatable {
  final int employee;
  final int officeId;
  final String date;

  /// Request type: 'update' or 'new'
  final int requestTypeId;

  /// Document type code: national_id | residency | passport | family_card | driving_license
  final String documentTypeCode;

  /// Document data fields (used when requestType == 'new')
  final String? issuingCountry;
  final String? documentNumber;
  final String? issueNumber;
  final String? issueDate;
  final String? endDate;
  final bool tabaq;
  final bool kafala;
  final String? kafeelName;

  /// Type-specific extras
  final String? passportNumber;
  final String? passportAddress;
  final String? familyCardNumber;
  final String? drivingLicenseNumber;

  final List<Map<String, dynamic>> attachmentIds;

  const CreateIDDocumentParams({
    required this.employee,
    required this.officeId,
    required this.date,
    required this.requestTypeId,
    required this.documentTypeCode,
    this.issuingCountry,
    this.documentNumber,
    this.issueNumber,
    this.issueDate,
    this.endDate,
    this.tabaq = false,
    this.kafala = false,
    this.kafeelName,
    this.passportNumber,
    this.passportAddress,
    this.familyCardNumber,
    this.drivingLicenseNumber,
    this.attachmentIds = const [],
  });

  Map<String, dynamic> toMap() => {
        'employee': employee,
        'office_id': officeId,
        'date': date,
        'request_type_id': requestTypeId,
        'document_type_code': documentTypeCode,
        'issuing_country': issuingCountry,
        'document_number': documentNumber,
        'issue_number': issueNumber,
        'issue_date': issueDate,
        'end_date': endDate,
        'tabaq': tabaq,
        'kafala': kafala,
        'kafeel_name': kafeelName,
        'passport_number': passportNumber,
        'passport_address': passportAddress,
        'family_card_number': familyCardNumber,
        'driving_license_number': drivingLicenseNumber,
        'attachment_ids': attachmentIds,
      };

  @override
  List<Object?> get props => [
        employee,
        officeId,
        date,
        requestTypeId,
        documentTypeCode,
        issuingCountry,
        documentNumber,
        issueNumber,
        issueDate,
        endDate,
        tabaq,
        kafala,
        kafeelName,
        passportNumber,
        passportAddress,
        familyCardNumber,
        drivingLicenseNumber,
        attachmentIds,
      ];
}
