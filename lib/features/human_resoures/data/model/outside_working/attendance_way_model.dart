import 'package:shaoni/features/human_resoures/domain/entity/outside_working/attendance_way.dart';

class AttendanceWayModel extends AttendanceWay {
  const AttendanceWayModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory AttendanceWayModel.fromJson(Map<String, dynamic> json) =>
      AttendanceWayModel(
        id: json['id'] as int,
        nameAr: json['nameAr'] as String? ?? '',
        nameEn: json['nameEn'] as String? ?? '',
      );
}
