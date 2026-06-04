import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/current_status.dart';

class CurrentStatusModel extends CurrentStatus {
  const CurrentStatusModel({
    super.nameAr,
    super.nameEn,
    super.techName,
    super.colorHex,
  });

  factory CurrentStatusModel.fromJson(Map<String, dynamic> json) {
    return CurrentStatusModel(
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      techName: json['techName'],
      colorHex: json['colorHex'],
    );
  }

  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(CurrentStatus status) {
    return {
      'nameAr': status.nameAr,
      'nameEn': status.nameEn,
      'techName': status.techName,
      'colorHex': status.colorHex,
    };
  }
}
