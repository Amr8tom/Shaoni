import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/status.dart';

class StatusModel extends Status {
  const StatusModel({
    required super.id,
    super.code,
    super.nameAr,
    super.nameEn,
    super.techName,
    required super.isActive,
    super.updatedAt,
    required super.isDeleted,
  });

  factory StatusModel.empty() {
    return const StatusModel(
      id: 0,
      code: '',
      nameAr: 'Unknown',
      nameEn: 'Unknown',
      techName: 'unknown',
      isActive: false,
      updatedAt: null,
      isDeleted: false,
    );
  }

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: json['id'],
      code: json['code'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      techName: json['techName'],
      isActive: json['isActive'] ?? false,
      updatedAt: json['updatedAt'],
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(Status status) {
    return {
      'id': status.id,
      'code': status.code,
      'nameAr': status.nameAr,
      'nameEn': status.nameEn,
      'techName': status.techName,
      'isActive': status.isActive,
      'updatedAt': status.updatedAt,
      'isDeleted': status.isDeleted,
    };
  }
}
