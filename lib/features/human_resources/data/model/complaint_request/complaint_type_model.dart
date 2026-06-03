import '../../../domain/entity/complaint_request/complaint_type.dart';

class ComplaintTypeModel extends ComplaintType {
  const ComplaintTypeModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory ComplaintTypeModel.fromJson(Map<String, dynamic> json) {
    return ComplaintTypeModel(
      id: json['id'] ?? 0,
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
    );
  }
}
