import 'package:equatable/equatable.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/request_with_stage.dart';

// {
// "pageNumber": 1,
// "pageSize": 2,
// "totalCount": 11,
// "totalPages": 6,
// "items": [
// {
// "odooStageId": 13,
// "extraData": {
// "attendance": null,
// "study": null,
// "outsideWorking": null,
// "visaRequest": null,
// "exitPermission": {
// "id": 40,
// "exitDate": "2026-03-29T00:00:00",
// "numberOfHours": 1,
// "permissionTimeValue": "med",
// "permissionType": 2,
// "notes": "tejst",
// "leavesAttachment": null
// }
// },
// "requesterFullName": null,
// "managerFullName": null,
// "request": {
// "id": 43,
// "requestNumber": "EP/2026/00161",
// "requesterId": 2,
// "requestId": 161,
// "serviceId": 5,
// "isGift": null,
// "kafeelId": null,
// "need_emp": false,
// "odooStatus": "new",
// "statusId": 13,
// "createdAt": "2026-03-26T09:00:39.6442287",
// "updatedAt": null,
// "service": {
// "id": 5,
// "code": "1957",
// "nameAr": "طلب إذن خروج",
// "nameEn": "hr.exit.permission",
// "isActive": true,
// "updatedAt": "2025-12-22T17:28:39.4205298",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// "statusHistories": null
// },
// "service": {
// "id": 5,
// "code": "1957",
// "nameAr": "طلب إذن خروج",
// "nameEn": "hr.exit.permission",
// "isActive": true,
// "updatedAt": "2025-12-22T17:28:39.4205298",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// "histories": [
// {
// "id": 100,
// "changedBy": "16",
// "changedAt": "2026-03-26T09:00:39.7104691",
// "comment": null,
// "requestId": 43,
// "request": null,
// "statusId": 13,
// "status": {
// "id": 13,
// "code": "1",
// "nameAr": "جديد",
// "nameEn": "New",
// "techName": "new",
// "isActive": true,
// "updatedAt": "2026-03-18T11:35:38.2681105",
// "isDeleted": false,
// "serviceStatuses": null
// }
// }
// ]
// },
// {
// "odooStageId": 13,
// "extraData": {
// "attendance": null,
// "study": null,
// "outsideWorking": null,
// "visaRequest": null,
// "exitPermission": {
// "id": 39,
// "exitDate": "2026-04-21T00:00:00",
// "numberOfHours": 1,
// "permissionTimeValue": "first",
// "permissionType": 1,
// "notes": "test by amr",
// "leavesAttachment": null
// }
// },
// "requesterFullName": null,
// "managerFullName": null,
// "request": {
// "id": 42,
// "requestNumber": "EP/2026/00157",
// "requesterId": 2,
// "requestId": 157,
// "serviceId": 5,
// "isGift": null,
// "kafeelId": null,
// "need_emp": false,
// "odooStatus": "new",
// "statusId": 13,
// "createdAt": "2026-03-18T09:35:06.3544663",
// "updatedAt": null,
// "service": {
// "id": 5,
// "code": "1957",
// "nameAr": "طلب إذن خروج",
// "nameEn": "hr.exit.permission",
// "isActive": true,
// "updatedAt": "2025-12-22T17:28:39.4205298",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// "statusHistories": null
// },
// "service": {
// "id": 5,
// "code": "1957",
// "nameAr": "طلب إذن خروج",
// "nameEn": "hr.exit.permission",
// "isActive": true,
// "updatedAt": "2025-12-22T17:28:39.4205298",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// "histories": [
// {
// "id": 99,
// "changedBy": "16",
// "changedAt": "2026-03-18T09:35:06.3858385",
// "comment": null,
// "requestId": 42,
// "request": null,
// "statusId": 13,
// "status": {
// "id": 13,
// "code": "1",
// "nameAr": "جديد",
// "nameEn": "New",
// "techName": "new",
// "isActive": true,
// "updatedAt": "2026-03-18T11:35:38.2681105",
// "isDeleted": false,
// "serviceStatuses": null
// }
// }
// ]
// }
// ]
// }
class AllRequestsWithStages extends Equatable {
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final List<RequestWithStage> items;

  const AllRequestsWithStages({
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.items,
  });

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'totalPages': totalPages,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
  /// from Json
  factory AllRequestsWithStages.fromJson(Map<String, dynamic> json) {
    return AllRequestsWithStages(
      pageNumber: json['pageNumber'] as int? ?? 0,
      pageSize: json['pageSize'] as int? ?? 0,
      totalCount: json['totalCount'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      items: _parseItems(json['items'] as List<dynamic>?),
    );
  }

  /// Helper method to parse items list safely
  static List<RequestWithStage> _parseItems(List<dynamic>? itemsList) {
    if (itemsList == null || itemsList.isEmpty) {
      return [];
    }
    return itemsList
        .map((item) => RequestWithStage?.fromJson(item as Map<String, dynamic>))
        .toList();
  }


  @override
  List<Object?> get props => [
    pageNumber,
    pageSize,
    totalCount,
    totalPages,
    items,
  ];
}
