import '../../domain/entities/loan_installment.dart';

class LoanInstallmentModel extends LoanInstallment {
  const LoanInstallmentModel({
    super.id,
    super.name,
    super.installmentDate,
    super.hijriDate,
    super.installmentAmount,
    super.status,
  });

  factory LoanInstallmentModel.fromJson(Map<String, dynamic> json) {
    return LoanInstallmentModel(
      id: json['id'] as int?,
      name: json['name']?.toString(),
      installmentDate: json['installment_date']?.toString(),
      hijriDate: json['hijri_date']?.toString(),
      installmentAmount:
          (json['installment_amount'] as num?)?.toDouble(),
      status: json['status']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => toJsonFromEntity(this);

  static Map<String, dynamic> toJsonFromEntity(LoanInstallment entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'installment_date': entity.installmentDate,
      'hijri_date': entity.hijriDate,
      'installment_amount': entity.installmentAmount,
      'status': entity.status,
    };
  }
}
