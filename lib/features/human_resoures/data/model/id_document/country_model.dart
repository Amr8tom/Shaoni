import 'package:shaoni/features/human_resoures/domain/entity/id_document/country.dart';

class CountryModel extends Country {
  const CountryModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        id: json['id'] as int,
        nameAr: json['name_ar'] as String? ?? '',
        nameEn: json['name_en'] as String? ?? '',
      );
}
