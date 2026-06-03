import 'package:shaoni/features/human_resources/domain/entity/id_document/id_renewal_request_type.dart';

class IDRenewalRequestTypeModel extends IDRenewalRequestType {
  const IDRenewalRequestTypeModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
    super.code,
  });

  factory IDRenewalRequestTypeModel.fromJson(Map<String, dynamic> json) {
    return IDRenewalRequestTypeModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      nameAr: json['nameAr']?.toString() ??
          json['name_ar']?.toString() ??
          json['name']?.toString() ??
          '',
      nameEn: json['nameEn']?.toString() ??
          json['name_en']?.toString() ??
          json['name']?.toString() ??
          '',
      code: json['code']?.toString(),
    );
  }
}
