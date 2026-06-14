import '../../domain/entities/loan_installment.dart';
import '../../domain/entities/loan_request_details.dart';
import 'loan_installment_model.dart';

class LoanRequestDetailsModel extends LoanRequestDetails {
  const LoanRequestDetailsModel({
    super.id,
    super.externalName,
    super.loanTypeId,
    super.loanTypeName,
    super.loanRequestAmount,
    super.loanPaymentPeriod,
    super.firstInstallmentDate,
    super.needEmp,
    super.employeeId,
    super.kafeelId,
    super.installments,
    super.installmentsCount,
  });

  factory LoanRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    final installmentsRaw = json['installment_ids'];
    final List<LoanInstallmentModel> installments = installmentsRaw is List
        ? installmentsRaw
            .whereType<Map<String, dynamic>>()
            .map((e) => LoanInstallmentModel.fromJson(e))
            .toList()
        : [];

    return LoanRequestDetailsModel(
      id: json['id'] as int?,
      externalName: json['externalName']?.toString(),
      loanTypeId: json['loanTypeId'] as int?,
      loanTypeName:
          (json['loanTypeName'] ?? json['loan_type_name'])?.toString(),
      loanRequestAmount:
          (json['loanRequestAmount'] ?? json['loan_request_amount'])
              ?.toDouble(),
      loanPaymentPeriod:
          (json['loanPaymentPeriod'] ?? json['loan_payment_period']) as int?,
      firstInstallmentDate:
          (json['firstInstallmentDate'] ?? json['first_installment_date'])
              ?.toString(),
      needEmp: json['needEmp'] as bool?,
      employeeId: json['employeeId'] as int?,
      kafeelId: json['kafeelId'] as int?,
      installments: installments,
      installmentsCount: json['installment_ids_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => toJsonFromEntity(this);

  static Map<String, dynamic> toJsonFromEntity(LoanRequestDetails entity) {
    return {
      'id': entity.id,
      'externalName': entity.externalName,
      'loanTypeId': entity.loanTypeId,
      'loanTypeName': entity.loanTypeName,
      'loanRequestAmount': entity.loanRequestAmount,
      'loanPaymentPeriod': entity.loanPaymentPeriod,
      'firstInstallmentDate': entity.firstInstallmentDate,
      'needEmp': entity.needEmp,
      'employeeId': entity.employeeId,
      'kafeelId': entity.kafeelId,
      'installment_ids': entity.installments
          ?.map((i) => LoanInstallmentModel.toJsonFromEntity(i))
          .toList(),
      'installment_ids_count': entity.installmentsCount,
    };
  }
}
