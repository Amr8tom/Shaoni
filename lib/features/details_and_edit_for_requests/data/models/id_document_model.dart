import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/id_document.dart';

class IDDocumentModel extends IDDocument {
  const IDDocumentModel({
    super.id,
    super.externalName,
    super.requestType,
    super.documentType,
    super.issuingCountry,
    super.documentNumber,
    super.issueNumber,
    super.issueDate,
    super.endDate,
    super.tabaq,
    super.kafala,
    super.kafeelName,
    super.passportNumber,
    super.passportAddress,
    super.familyCardNumber,
    super.drivingLicenseNumber,
    super.date,
    super.editReasons,
    super.rejectReasons,
  });

  factory IDDocumentModel.fromJson(Map<String, dynamic> json) {
    return IDDocumentModel(
      id: json['id'] as int?,
      // "IDR/2026/00006" — the Odoo request number.
      externalName: json['idRenewalRequestOdooName']?.toString() ??
          json['externalName']?.toString(),
      // API sends "requestTypes" (plural), e.g. "update".
      requestType: json['requestTypes']?.toString() ??
          json['requestType']?.toString() ??
          json['request_type']?.toString(),
      // API sends "identificationType", e.g. "national_id".
      documentType: json['identificationType']?.toString() ??
          json['documentType']?.toString() ??
          json['document_type']?.toString(),
      // API sends "countryOfIssueId" (numeric FK, no name in payload yet).
      issuingCountry: json['issuingCountry']?.toString() ??
          json['issuing_country']?.toString() ??
          json['countryOfIssueId']?.toString(),
      // API sends "identificationId".
      documentNumber: json['identificationId']?.toString() ??
          json['documentNumber']?.toString() ??
          json['document_number']?.toString(),
      issueNumber:
          json['issueNumber']?.toString() ?? json['issue_number']?.toString(),
      // API sends "issuerDate" (note: issuer, not issue).
      issueDate: json['issuerDate']?.toString() ??
          json['issueDate']?.toString() ??
          json['issue_date']?.toString(),
      endDate: json['endDate']?.toString() ?? json['end_date']?.toString(),
      tabaq: json['tabaq'] as bool?,
      // API sends "haveGuarantee" for whether a kafeel/guarantor is needed.
      kafala: json['haveGuarantee'] as bool? ?? json['kafala'] as bool?,
      // API sends "nameOfGuarantee".
      kafeelName: json['nameOfGuarantee']?.toString() ??
          json['kafeelName']?.toString() ??
          json['kafeel_name']?.toString(),
      passportNumber: json['passportNumber']?.toString() ??
          json['passport_number']?.toString(),
      passportAddress: json['passportAddress']?.toString() ??
          json['passport_address']?.toString(),
      // API sends "familyCard".
      familyCardNumber: json['familyCard']?.toString() ??
          json['familyCardNumber']?.toString() ??
          json['family_card_number']?.toString(),
      // API sends "drivingLicense".
      drivingLicenseNumber: json['drivingLicense']?.toString() ??
          json['drivingLicenseNumber']?.toString() ??
          json['driving_license_number']?.toString(),
      date: json['date']?.toString(),
      editReasons: json['editReasons']?.toString(),
      rejectReasons: json['rejectReasons']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => toJsonFromEntity(this);

  static Map<String, dynamic> toJsonFromEntity(IDDocument entity) {
    return {
      'id': entity.id,
      'externalName': entity.externalName,
      'requestType': entity.requestType,
      'documentType': entity.documentType,
      'issuingCountry': entity.issuingCountry,
      'documentNumber': entity.documentNumber,
      'issueNumber': entity.issueNumber,
      'issueDate': entity.issueDate,
      'endDate': entity.endDate,
      'tabaq': entity.tabaq,
      'kafala': entity.kafala,
      'kafeelName': entity.kafeelName,
      'passportNumber': entity.passportNumber,
      'passportAddress': entity.passportAddress,
      'familyCardNumber': entity.familyCardNumber,
      'drivingLicenseNumber': entity.drivingLicenseNumber,
      'date': entity.date,
      'editReasons': entity.editReasons,
      'rejectReasons': entity.rejectReasons,
    };
  }
}
