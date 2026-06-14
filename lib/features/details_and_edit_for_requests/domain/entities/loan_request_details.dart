import 'package:equatable/equatable.dart';
import 'loan_installment.dart';

class LoanRequestDetails extends Equatable {
  final int? id;
  final String? externalName;
  final int? loanTypeId;
  final String? loanTypeName;
  final double? loanRequestAmount;
  final int? loanPaymentPeriod;
  final String? firstInstallmentDate;
  final bool? needEmp;
  final int? employeeId;
  final int? kafeelId;
  final List<LoanInstallment>? installments;
  final int? installmentsCount;

  const LoanRequestDetails({
    this.id,
    this.externalName,
    this.loanTypeId,
    this.loanTypeName,
    this.loanRequestAmount,
    this.loanPaymentPeriod,
    this.firstInstallmentDate,
    this.needEmp,
    this.employeeId,
    this.kafeelId,
    this.installments,
    this.installmentsCount,
  });

  @override
  List<Object?> get props => [
        id,
        externalName,
        loanTypeId,
        loanTypeName,
        loanRequestAmount,
        loanPaymentPeriod,
        firstInstallmentDate,
        needEmp,
        employeeId,
        kafeelId,
        installments,
        installmentsCount,
      ];
}
