import 'package:shaoni/features/home/data/model/status_count_model.dart';
import 'package:shaoni/features/home/domain/entities/all_status_count.dart';

class AllStatusCountModel extends AllStatusCount {
  AllStatusCountModel(
      {required super.serviceId,
      required super.serviceCode,
      required super.serviceNameAr,
      required super.serviceNameEn,
      required super.statusCounts});

  /// fromJson
  factory AllStatusCountModel.fromJson(Map<String, dynamic> json) {
    return AllStatusCountModel(
      serviceId: json['serviceId'],
      serviceCode: json['serviceCode'],
      serviceNameAr: json['serviceNameAr'],
      serviceNameEn: json['serviceNameEn'],
      statusCounts: (json['statusCounts'] as List)
          .map((e) => StatusCountModel.fromJson(e))
          .toList(),
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'serviceId': serviceId,
      'serviceCode': serviceCode,
      'serviceNameAr': serviceNameAr,
      'serviceNameEn': serviceNameEn,
      'statusCounts':
          statusCounts?.map((e) => (e as StatusCountModel).toJson()).toList(),
    };
  }
}
