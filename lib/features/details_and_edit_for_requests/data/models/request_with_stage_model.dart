import 'package:shaoni/features/details_and_edit_for_requests/data/models/current_status_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/extra_data_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/history_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/request_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/request_with_stage.dart';
import 'package:shaoni/features/services/data/model/service_model.dart';

class RequestWithStageModel extends RequestWithStage {
  const RequestWithStageModel({
    required super.odooStageId,
    super.extraData,
    required super.requesterFullName,
    required super.managerFullName,
    super.request,
    super.service,
    super.histories,
    super.currentStatus,
  });

  /// from Json
  factory RequestWithStageModel.fromJson(Map<String, dynamic> json) {
    List<HistoryModel>? parsedHistories;

    if (json['histories'] != null && json['histories'] is List) {
      try {
        parsedHistories = (json['histories'] as List)
            .where((x) => x != null && x is Map)
            .map((x) {
              try {
                return HistoryModel.fromJson(x as Map<String, dynamic>);
              } catch (_) {
                return null;
              }
            })
            .whereType<HistoryModel>()
            .toList();
      } catch (_) {
        parsedHistories = null;
      }
    }

    return RequestWithStageModel(
      odooStageId: json['odooStageId'],
      extraData: json['extraData'] != null
          ? ExtraDataModel.fromJson(json['extraData'])
          : null,
      requesterFullName: json['requesterFullName'],
      managerFullName: json['managerFullName'],
      request: json['request'] != null
          ? RequestModel.fromJson(json['request'])
          : null,
      service: json['service'] != null
          ? ServiceModel.fromJson(json['service'])
          : null,
      histories: parsedHistories,
      currentStatus: json['currentStatus'] != null
          ? CurrentStatusModel.fromJson(json['currentStatus'])
          : null,
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'odooStageId': odooStageId,
      'extraData': (extraData as ExtraDataModel?)?.toJson(),
      'requesterFullName': requesterFullName,
      'managerFullName': managerFullName,
      'request': (request as RequestModel?)?.toJson(),
      'service': (service as ServiceModel?)?.toJson(),
      'currentStatus': (currentStatus as CurrentStatusModel?)?.toJson(),
      'histories': histories != null
          ? List<dynamic>.from(
              histories!.map((x) => (x as HistoryModel).toJson()))
          : null,
    };
  }
}
