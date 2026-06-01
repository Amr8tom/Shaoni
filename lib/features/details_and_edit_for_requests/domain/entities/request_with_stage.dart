
import 'package:equatable/equatable.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/request.dart';
import '../../../human_resoures/data/model/service_model.dart';
import '../../../services/data/model/service_model.dart';
import 'current_status.dart';
import 'extra_data.dart';
import 'history.dart';

class RequestWithStage extends Equatable {
  final int? odooStageId;
  final ExtraData? extraData;
  final String? requesterFullName;
  final String? managerFullName;
  final Request? request;
  final ServiceModel? service;
  final List<History>? histories;
  final CurrentStatus? currentStatus;


  const RequestWithStage({
    required this.odooStageId,
    this.extraData,
    required this.requesterFullName,
    required this.managerFullName,
    this.request,
    this.service,
    this.histories,
     this.currentStatus,
  });

  /// from Json
  factory RequestWithStage.fromJson(Map<String, dynamic> json) {
    List<History>? parsedHistories;
    
    if (json['histories'] != null && json['histories'] is List) {
      try {
        parsedHistories = (json['histories'] as List)
            .where((x) => x != null && x is Map)
            .map((x) {
              try {
                return History.fromJson(x as Map<String, dynamic>);
              } catch (e) {
                print('Error parsing history item: $e');
                return null;
              }
            })
            .whereType<History>()
            .toList();
      } catch (e) {
        print('Error parsing histories list: $e');
        parsedHistories = null;
      }
    }

    return RequestWithStage(
      odooStageId: json['odooStageId'],
      extraData: json['extraData'] != null ? ExtraData.fromJson(json['extraData']) : null,
      requesterFullName: json['requesterFullName'],
      managerFullName: json['managerFullName'],
      request: json['request'] != null ? Request.fromJson(json['request']) : null,
      service: json['service'] != null ? ServiceModel.fromJson(json['service']) : null,
      histories: parsedHistories,
      currentStatus: json['currentStatus'] != null ? CurrentStatus.fromJson(json['currentStatus']) : null,
    );
  }
  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'odooStageId': odooStageId,
      'extraData': extraData?.toJson(),
      'requesterFullName': requesterFullName,
      'managerFullName': managerFullName,
      'request': request?.toJson(),
      'service': service?.toJson(),
      'currentStatus': currentStatus?.toJson(),
      'histories': histories != null ? List<dynamic>.from(histories!.map((x) => x.toJson())) : null,
    };
  }

  @override
  List<Object?> get props => [
    odooStageId,
    extraData,
    requesterFullName,
    managerFullName,
    currentStatus,
    request,
    service,
    histories,
  ];
}
