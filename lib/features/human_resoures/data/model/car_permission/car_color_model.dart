import '../../../domain/entity/car_permission/car_color.dart';

class CarColorModel extends CarColor {
  const CarColorModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory CarColorModel.fromJson(Map<String, dynamic> json) {
    return CarColorModel(
      id: json['id'] ?? 0,
      nameAr: json['name'] ?? '',
      nameEn: json['name'] ?? '',
    );
  }
}
