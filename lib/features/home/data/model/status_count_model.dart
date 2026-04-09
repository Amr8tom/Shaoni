import 'package:shaoni/features/home/domain/entities/status_count.dart';

class StatusCountModel extends StatusCount {
  StatusCountModel(
      {required super.statusId,
      required super.nameAr,
      required super.nameEn,
      required super.techName,
      required super.count});

  factory StatusCountModel.fromJson(Map<String, dynamic> json) {
    return StatusCountModel(
      statusId: json['statusId'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      techName: json['techName'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusId': statusId,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'techName': techName,
      'count': count,
    };
  }
}
