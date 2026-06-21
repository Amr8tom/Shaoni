import 'package:equatable/equatable.dart';

class IDDocument extends Equatable {
  final int? id;
  final String? externalName;
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
  final String? editReasons;
  final String? rejectReasons;

  const IDDocument({
    this.id,
    this.externalName,
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
    this.editReasons,
    this.rejectReasons,
  });

  @override
  List<Object?> get props => [
        id,
        externalName,
        requestType,
        documentType,
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
        date,
        editReasons,
        rejectReasons,
      ];
}
