import 'package:shaoni/features/human_resoures/domain/entity/experience_certificate/certificate_reason.dart';

class CertificateReasonModel extends CertificateReason {
  const CertificateReasonModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory CertificateReasonModel.fromJson(Map<String, dynamic> json) {
    return CertificateReasonModel(
      id: json['id'] ?? 0,
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
    );
  }
}
