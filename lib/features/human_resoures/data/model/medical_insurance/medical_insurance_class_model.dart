import 'package:shaoni/features/human_resoures/domain/entity/medical_insurance/medical_insurance_class.dart';

class MedicalInsuranceClassModel extends MedicalInsuranceClass {
  const MedicalInsuranceClassModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
    required super.value,
  });

  factory MedicalInsuranceClassModel.fromJson(Map<String, dynamic> json) {
    return MedicalInsuranceClassModel(
      id: json['id'] ?? 0,
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
      value: (json['value'] ?? 0).toDouble(),
    );
  }
}
