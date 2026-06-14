import 'package:equatable/equatable.dart';

class SalaryRequest extends Equatable {
  final int? id;
  final int? salaryRequestOdooId;
  final String? salaryRequestOdooName;
  final String? salaryRequestType;
  final int? countryOfBankId;
  final int? bankId;
  final String? accountNumber;
  final String? iban;
  final String? ibanAttachment;
  final String? disclaimerAttachment;
  final String? requiredDocument;
  final String? salaryType;
  final String? note;

  const SalaryRequest({
    this.id,
    this.salaryRequestOdooId,
    this.salaryRequestOdooName,
    this.salaryRequestType,
    this.countryOfBankId,
    this.bankId,
    this.accountNumber,
    this.iban,
    this.ibanAttachment,
    this.disclaimerAttachment,
    this.requiredDocument,
    this.salaryType,
    this.note,
  });

  @override
  List<Object?> get props => [
        id,
        salaryRequestOdooId,
        salaryRequestOdooName,
        salaryRequestType,
        countryOfBankId,
        bankId,
        accountNumber,
        iban,
        ibanAttachment,
        disclaimerAttachment,
        requiredDocument,
        salaryType,
        note,
      ];
}
