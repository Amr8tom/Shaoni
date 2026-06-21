import 'package:equatable/equatable.dart';
import 'loan_installment.dart';

class LoanRequestDetails extends Equatable {
  final int? id;
  final String? externalName;
  final String? state;
  final int? loanTypeId;
  final String? loanTypeName;
  final double? loanRequestAmount;
  final int? loanPaymentPeriod;
  final String? firstInstallmentDate;
  final bool? needEmp;
  final int? employeeId;
  final int? kafeelId;
  final String? editReasons;
  final String? rejectReasons;
  final List<LoanInstallment>? installments;
  final int? installmentsCount;

  const LoanRequestDetails({
    this.id,
    this.externalName,
    this.state,
    this.loanTypeId,
    this.loanTypeName,
    this.loanRequestAmount,
    this.loanPaymentPeriod,
    this.firstInstallmentDate,
    this.needEmp,
    this.employeeId,
    this.kafeelId,
    this.editReasons,
    this.rejectReasons,
    this.installments,
    this.installmentsCount,
  });

  @override
  List<Object?> get props => [
        id,
        externalName,
        state,
        loanTypeId,
        loanTypeName,
        loanRequestAmount,
        loanPaymentPeriod,
        firstInstallmentDate,
        needEmp,
        employeeId,
        kafeelId,
        editReasons,
        rejectReasons,
        installments,
        installmentsCount,
      ];
}
