import '../../../domain/entity/loan/loan_type.dart';

class LoanTypeModel extends LoanType {
  const LoanTypeModel({
    required super.id,
    required super.name,
    required super.needEmp,
  });

  factory LoanTypeModel.fromJson(Map<String, dynamic> json) {
    return LoanTypeModel(
      id: json['id'] as int,
      name: (json['name'] ?? '').toString(),
      needEmp: json['needEmp'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => toJsonFromEntity(this);

  static Map<String, dynamic> toJsonFromEntity(LoanType entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'needEmp': entity.needEmp,
    };
  }
}
