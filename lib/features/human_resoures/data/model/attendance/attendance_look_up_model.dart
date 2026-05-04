import 'package:shaoni/features/human_resoures/domain/entity/attendance/attendance_lookup.dart';



class AttendanceLookUpModel extends AttendanceLookup {
  AttendanceLookUpModel(
      {required super.id,
      required super.nameAr,
      required super.nameEn

  });

  /// from json
  factory AttendanceLookUpModel.fromJson(Map<String, dynamic> json) {
    return AttendanceLookUpModel(
      id: json['id'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],

    );
  }
}
