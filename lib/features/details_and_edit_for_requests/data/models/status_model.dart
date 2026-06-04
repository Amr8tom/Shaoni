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
    return {
      'id': id,
      'code': code,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'techName': techName,
      'isActive': isActive,
      'updatedAt': updatedAt,
      'isDeleted': isDeleted,
    };
  }
}
