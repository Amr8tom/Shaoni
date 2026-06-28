import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_type.dart';

class VisaTypeModel extends VisaType {
  const VisaTypeModel({
    required super.id,
    required super.code,
    required super.nameAr,
    required super.nameEn,
  });

  factory VisaTypeModel.fromJson(Map<String, dynamic> json) {
    return VisaTypeModel(
      id: json['id'] as int? ?? 0,
      code: json['code'] as String? ?? '',
      nameAr: json['nameAr'] as String? ?? '',
      nameEn: json['nameEn'] as String? ?? '',
    );
  }
}
