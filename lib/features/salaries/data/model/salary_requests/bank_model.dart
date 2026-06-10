import '../../../domain/entity/salary_requests/bank.dart';

class BankModel extends Bank {
  const BankModel({
    required super.id,
    required super.name,
    required super.code,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'] as int,
      name: json['name'] as String,
      code: json['code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(Bank entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'code': entity.code,
    };
  }
}
