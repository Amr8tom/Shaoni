import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/loan/create_loan_response.dart';
import '../../repository/salaries_repository.dart';

class CreateLoanUseCase {
  final SalariesRepository repository;

  CreateLoanUseCase(this.repository);

  Future<Either<Failure, CreateLoanResponse>> call({
    required CreateLoanParams params,
  }) async {
    return await repository.createLoanRequest(params: params);
  }
}

class CreateLoanParams {
  final int employeeId;
  final int officeId;
  final int loanType;
  final int? otherEmployeeId;
  final double loanRequestAmount;
  final int loanPaymentPeriod;
  final String firstInstallmentDate;
  final bool needEmp;

  const CreateLoanParams({
    required this.employeeId,
    required this.officeId,
    required this.loanType,
    this.otherEmployeeId,
    required this.loanRequestAmount,
    required this.loanPaymentPeriod,
    required this.firstInstallmentDate,
    required this.needEmp,
  });

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employeeId,
      'office_id': officeId,
      'loan_type': loanType,
      'other_employee_id': otherEmployeeId,
      'loan_request_amount': loanRequestAmount,
      'loan_payment_period': loanPaymentPeriod,
      'first_installment_date': firstInstallmentDate,
      'need_emp': needEmp,
    };
  }
}
