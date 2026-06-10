import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/salary_requests/create_salary_response.dart';
import '../../repository/salaries_repository.dart';

class CreateSalaryUseCase {
  final SalariesRepository repository;

  CreateSalaryUseCase(this.repository);

  Future<Either<Failure, CreateSalaryResponse>> call({
    required CreateSalaryParams params,
  }) async {
    return await repository.createSalaryRequest(params: params);
  }
}

class CreateSalaryParams {
  final int employeeId;
  final String date;
  final String salaryRequest; // e.g. "salary_transfer_request"
  final String? requiredDocument;
  final int officeId;
  final String? note;

  // Bank details fields
  final int? countryOfBank;
  final int? bankId;
  final String? accountNumber;
  final String? iban;
  final String? ibanAttachment;
  final String? disclaimerAttachment;

  // Salary definition fields
  final String? salaryType; // e.g. "basic" or "total"
  final int? destinationOfLettersId;
  final String? reason;

  const CreateSalaryParams({
    required this.employeeId,
    required this.date,
    required this.salaryRequest,
    this.requiredDocument,
    required this.officeId,
    this.note,
    this.countryOfBank,
    this.bankId,
    this.accountNumber,
    this.iban,
    this.ibanAttachment,
    this.disclaimerAttachment,
    this.salaryType,
    this.destinationOfLettersId,
    this.reason,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'employee_id': employeeId,
      'date': date,
      'salary_request': salaryRequest,
      'office_id': officeId,
    };

    if (requiredDocument != null && requiredDocument!.isNotEmpty) {
      map['required_document'] = requiredDocument;
    }
    if (note != null && note!.isNotEmpty) {
      map['note'] = note;
    }

    if (countryOfBank != null) {
      map['country_of_bank'] = countryOfBank;
    }
    if (bankId != null) {
      map['bank_id'] = bankId;
    }
    if (accountNumber != null && accountNumber!.isNotEmpty) {
      map['account_number'] = accountNumber;
    }
    if (iban != null && iban!.isNotEmpty) {
      map['iban'] = iban;
    }
    if (ibanAttachment != null && ibanAttachment!.isNotEmpty) {
      map['iban_attachment'] = ibanAttachment;
    }
    if (disclaimerAttachment != null && disclaimerAttachment!.isNotEmpty) {
      map['disclaimer_attachment'] = disclaimerAttachment;
    }

    if (salaryType != null && salaryType!.isNotEmpty) {
      map['salary_type'] = salaryType;
    }
    if (destinationOfLettersId != null) {
      map['destination_of_letters_id'] = destinationOfLettersId;
    }
    if (reason != null && reason!.isNotEmpty) {
      map['reason'] = reason;
    }

    return map;
  }
}
