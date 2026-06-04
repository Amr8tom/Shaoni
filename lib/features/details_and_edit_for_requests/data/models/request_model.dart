import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/request.dart';
import 'package:shaoni/features/services/data/model/service_model.dart';
import 'history_model.dart';

class RequestModel extends Request {
  const RequestModel({
    required super.id,
    required super.requestNumber,
    required super.requesterId,
    required super.requestId,
    required super.serviceId,
    required super.isGift,
    super.kafeelId,
    required super.needEmp,
    required super.odooStatus,
    required super.statusId,
    required super.createdAt,
    super.updatedAt,
    required super.service,
    required super.histories,
  });

  /// from json
  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      requestNumber: json['requestNumber'],
      requesterId: json['requesterId'],
      requestId: json['requestId'],
      serviceId: json['serviceId'],
      isGift: json['isGift'] ?? false,
      kafeelId: json['kafeelId'],
      needEmp: json['needEmp'] ?? false,
      odooStatus: json['odooStatus'] ?? '',
      statusId: json['statusId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      service: json['service'] != null
          ? ServiceModel.fromJson(json['service'])
          : null,
      histories: json['statusHistories'] != null
          ? List<HistoryModel>.from(
              json['statusHistories'].map((x) => HistoryModel.fromJson(x)))
          : [],
    );
  }

  /// to json
  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(Request request) {
    return {
      'id': request.id,
      'requestNumber': request.requestNumber,
      'requesterId': request.requesterId,
      'requestId': request.requestId,
      'serviceId': request.serviceId,
      'isGift': request.isGift,
      'kafeelId': request.kafeelId,
      'needEmp': request.needEmp,
      'odooStatus': request.odooStatus,
      'statusId': request.statusId,
      'createdAt': request.createdAt,
      'updatedAt': request.updatedAt,
      'service': request.service == null
          ? null
          : ServiceModel.toJsonFromEntity(request.service!),
      'histories':
          request.histories.map(HistoryModel.toJsonFromEntity).toList(),
    };
  }
}
