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
  final int employeeId;
  final int officeId;
  final String date;

  /// Request type code: 'new' or 'update'
  final String requestTypes;

  /// Document type code: national_id | residency | passport | family_card | driving_license
  final String identificationType;

  /// Country of issue — integer ID from /Lookup/GetCountries
  final int? countryOfIssue;

  /// رقم المستند / identification number
  final String? identificationId;

  /// رقم الإصدار
  final String? issueNumber;

  /// تاريخ الإصدار (issuer_date in API)
  final String? issuerDate;

  /// تاريخ الانتهاء
  final String? endDate;

  /// طبق (apply in API)
  final bool apply;

  /// هل علي كفالة
  final bool kafala;
  final String? kafeelName;

  /// Passport extras
  final String? passportNumber;
  final String? passportAddress;

  /// Family Card extra
  final String? familyCardNumber;

  /// Driving License extra
  final String? drivingLicenseNumber;

  final List<Map<String, dynamic>> attachmentIds;

  const CreateIDDocumentParams({
    required this.employeeId,
    required this.officeId,
    required this.date,
    required this.requestTypes,
    required this.identificationType,
    this.countryOfIssue,
    this.identificationId,
    this.issueNumber,
    this.issuerDate,
    this.endDate,
    this.apply = false,
    this.kafala = false,
    this.kafeelName,
    this.passportNumber,
    this.passportAddress,
    this.familyCardNumber,
    this.drivingLicenseNumber,
    this.attachmentIds = const [],
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'employee_id': employeeId,
      'office_id': officeId,
      'date': date,
      'request_types': requestTypes,
      'identification_type': identificationType,
      'apply': apply,
    };

    if (countryOfIssue != null) map['country_of_issue'] = countryOfIssue;
    if (identificationId != null && identificationId!.isNotEmpty) {
      map['identification_id'] = identificationId;
    }
    if (issueNumber != null && issueNumber!.isNotEmpty) {
      map['issue_number'] = issueNumber;
    }
    if (issuerDate != null && issuerDate!.isNotEmpty) {
      map['issuer_date'] = issuerDate;
    }
    if (endDate != null && endDate!.isNotEmpty) {
      map['end_date'] = endDate;
    }
    if (kafala) {
      map['kafala'] = kafala;
      if (kafeelName != null && kafeelName!.isNotEmpty) {
        map['kafeel_name'] = kafeelName;
      }
    }
    if (passportNumber != null && passportNumber!.isNotEmpty) {
      map['passport_number'] = passportNumber;
    }
    if (passportAddress != null && passportAddress!.isNotEmpty) {
      map['passport_address'] = passportAddress;
    }
    if (familyCardNumber != null && familyCardNumber!.isNotEmpty) {
      map['family_card_number'] = familyCardNumber;
    }
    if (drivingLicenseNumber != null && drivingLicenseNumber!.isNotEmpty) {
      map['driving_license_number'] = drivingLicenseNumber;
    }
    if (attachmentIds.isNotEmpty) map['attachment_ids'] = attachmentIds;

    return map;
  }

  @override
  List<Object?> get props => [
        employeeId,
        officeId,
        date,
        requestTypes,
        identificationType,
        countryOfIssue,
        identificationId,
        issueNumber,
        issuerDate,
        endDate,
        apply,
        kafala,
        kafeelName,
        passportNumber,
        passportAddress,
        familyCardNumber,
        drivingLicenseNumber,
        attachmentIds,
      ];
}
