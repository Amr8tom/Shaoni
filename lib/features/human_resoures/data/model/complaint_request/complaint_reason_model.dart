import '../../../domain/entity/complaint_request/complaint_reason.dart';

class ComplaintReasonModel extends ComplaintReason {
  const ComplaintReasonModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory ComplaintReasonModel.fromJson(Map<String, dynamic> json) {
    return ComplaintReasonModel(
      id: json['id'] ?? 0,
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
    );
  }
}
