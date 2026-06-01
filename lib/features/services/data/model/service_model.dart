

import '../../domain/entity/service.dart';

class ServiceModel extends Service {
  const ServiceModel({
    super.id,
    super.code,
    super.nameAr,
    super.nameEn,
    super.isActive,
    super.updatedAt,
    super.isDeleted,
  });

  @override
  List<Object?> get props => [
    id,
    code,
    nameAr,
    nameEn,
    isActive,
    updatedAt,
    isDeleted,
  ];

  /// fromJson
  factory ServiceModel.fromJson(Map<String, dynamic>? json) {
    return ServiceModel(
      id: json?['id'],
      code: json?['code'],
      nameAr: json?['nameAr'],
      nameEn: json?['nameEn'],
      isActive: json?['isActive'],
      updatedAt: json?['updatedAt'],
      isDeleted: json?['isDeleted'],
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'isActive': isActive,
      'updatedAt': updatedAt,
      'isDeleted': isDeleted,
    };
  }
}
