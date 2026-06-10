import '../../../domain/entity/salary_requests/country.dart';

class CountryModel extends Country {
  const CountryModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] as int,
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(Country entity) {
    return {
      'id': entity.id,
      'name_en': entity.nameEn,
      'name_ar': entity.nameAr,
    };
  }
}
