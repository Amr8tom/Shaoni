class IDDocumentModel {
  final int? id;
  final String? requestType;
  final String? documentType;
  final String? issuingCountry;
  final String? documentNumber;
  final String? issueNumber;
  final String? issueDate;
  final String? endDate;
  final bool? tabaq;
  final bool? kafala;
  final String? kafeelName;
  final String? passportNumber;
  final String? passportAddress;
  final String? familyCardNumber;
  final String? drivingLicenseNumber;
  final String? date;

  const IDDocumentModel({
    this.id,
    this.requestType,
    this.documentType,
    this.issuingCountry,
    this.documentNumber,
    this.issueNumber,
    this.issueDate,
    this.endDate,
    this.tabaq,
    this.kafala,
    this.kafeelName,
    this.passportNumber,
    this.passportAddress,
    this.familyCardNumber,
    this.drivingLicenseNumber,
    this.date,
  });

  factory IDDocumentModel.fromJson(Map<String, dynamic> json) {
    return IDDocumentModel(
      id: json['id'] as int?,
      requestType: json['requestType']?.toString() ??
          json['request_type']?.toString(),
      documentType: json['documentType']?.toString() ??
          json['document_type']?.toString(),
      issuingCountry: json['issuingCountry']?.toString() ??
          json['issuing_country']?.toString(),
      documentNumber: json['documentNumber']?.toString() ??
          json['document_number']?.toString(),
      issueNumber: json['issueNumber']?.toString() ??
          json['issue_number']?.toString(),
      issueDate: json['issueDate']?.toString() ??
          json['issue_date']?.toString(),
      endDate: json['endDate']?.toString() ?? json['end_date']?.toString(),
      tabaq: json['tabaq'] as bool?,
      kafala: json['kafala'] as bool?,
      kafeelName: json['kafeelName']?.toString() ??
          json['kafeel_name']?.toString(),
      passportNumber: json['passportNumber']?.toString() ??
          json['passport_number']?.toString(),
      passportAddress: json['passportAddress']?.toString() ??
          json['passport_address']?.toString(),
      familyCardNumber: json['familyCardNumber']?.toString() ??
          json['family_card_number']?.toString(),
      drivingLicenseNumber: json['drivingLicenseNumber']?.toString() ??
          json['driving_license_number']?.toString(),
      date: json['date']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'requestType': requestType,
        'documentType': documentType,
        'issuingCountry': issuingCountry,
        'documentNumber': documentNumber,
        'issueNumber': issueNumber,
        'issueDate': issueDate,
        'endDate': endDate,
        'tabaq': tabaq,
        'kafala': kafala,
        'kafeelName': kafeelName,
        'passportNumber': passportNumber,
        'passportAddress': passportAddress,
        'familyCardNumber': familyCardNumber,
        'drivingLicenseNumber': drivingLicenseNumber,
        'date': date,
      };
}
