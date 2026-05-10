import '../../../domain/entity/car_permission/car_brand.dart';
class CarBrandModel extends CarBrand {
  const CarBrandModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory CarBrandModel.fromJson(Map<String, dynamic> json) {
    return CarBrandModel(
      id: json['id'] ?? 0,
      nameAr: json['name'] ?? '',
      nameEn: json['name'] ?? '',
    );
  }
}
