import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/salary_request.dart';

class SalaryRequestModel extends SalaryRequest {
  const SalaryRequestModel({
    super.id,
    super.salaryRequestOdooId,
    super.salaryRequestOdooName,
    super.salaryRequestType,
    super.countryOfBankId,
    super.bankId,
    super.accountNumber,
    super.iban,
    super.ibanAttachment,
  });

  factory SalaryRequestModel.fromJson(Map<String, dynamic> json) {
    return SalaryRequestModel(
      id: json['id'] as int?,
      salaryRequestOdooId: json['salaryRequestOdooId'] as int?,
      salaryRequestOdooName: json['salaryRequestOdooName']?.toString(),
      salaryRequestType: json['salaryRequestType']?.toString(),
      countryOfBankId: json['countryOfBankId'] as int?,
      bankId: json['bankId'] as int?,
      accountNumber: json['accountNumber']?.toString(),
      iban: json['iban']?.toString(),
      ibanAttachment: json['ibanAttachment']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'salaryRequestOdooId': salaryRequestOdooId,
      'salaryRequestOdooName': salaryRequestOdooName,
      'salaryRequestType': salaryRequestType,
      'countryOfBankId': countryOfBankId,
      'bankId': bankId,
      'accountNumber': accountNumber,
      'iban': iban,
      'ibanAttachment': ibanAttachment,
    };
  }

  static Map<String, dynamic> toJsonFromEntity(SalaryRequest entity) {
    return {
      'id': entity.id,
      'salaryRequestOdooId': entity.salaryRequestOdooId,
      'salaryRequestOdooName': entity.salaryRequestOdooName,
      'salaryRequestType': entity.salaryRequestType,
      'countryOfBankId': entity.countryOfBankId,
      'bankId': entity.bankId,
      'accountNumber': entity.accountNumber,
      'iban': entity.iban,
      'ibanAttachment': entity.ibanAttachment,
    };
  }
}
