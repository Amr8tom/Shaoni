
import 'package:shaoni/features/services/data/model/service_model.dart';
import '../../domain/entity/all_services.dart';

class AllServicesModel extends AllServices {
  const AllServicesModel({required super.services});

  /// fromJson
  factory AllServicesModel.fromJson(List<dynamic> json) {
    final services = json.map((e) => ServiceModel.fromJson(e)).toList();
    return AllServicesModel(services: services);
  }

  /// toJson
  List<Map<String, dynamic>> toJson() {
    return services.map((e) => e.toJson()).toList();
}}

// [
// {
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
// {
// "id": 6,
// "code": "1938",
// "nameAr": "hr.loan",
// "nameEn": "hr.loan",
// "isActive": true,
// "updatedAt": "2026-03-17T13:56:23.0915855",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// {
// "id": 7,
// "code": "1912",
// "nameAr": "outside.working",
// "nameEn": "outside.working",
// "isActive": true,
// "updatedAt": "2026-03-17T14:29:22.5863997",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// {
// "id": 8,
// "code": "1921",
// "nameAr": "attendance.update",
// "nameEn": "attendance.update",
// "isActive": true,
// "updatedAt": "2026-03-17T14:29:22.6393381",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// {
// "id": 9,
// "code": "1896",
// "nameAr": "visa.request",
// "nameEn": "visa.request",
// "isActive": true,
// "updatedAt": "2026-03-17T14:29:22.6679415",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// {
// "id": 10,
// "code": "1366",
// "nameAr": "product.request",
// "nameEn": "product.request",
// "isActive": true,
// "updatedAt": "2026-03-17T14:29:22.6966465",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// {
// "id": 11,
// "code": "1910",
// "nameAr": "car.permission",
// "nameEn": "car.permission",
// "isActive": true,
// "updatedAt": "2026-03-17T14:29:22.7217848",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// {
// "id": 12,
// "code": "1908",
// "nameAr": "study.request",
// "nameEn": "study.request",
// "isActive": true,
// "updatedAt": "2026-03-17T14:29:22.7514317",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// {
// "id": 13,
// "code": "1388",
// "nameAr": "scrap.request",
// "nameEn": "scrap.request",
// "isActive": true,
// "updatedAt": "2026-03-17T14:29:22.7883474",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// },
// {
// "id": 14,
// "code": "1914",
// "nameAr": "start.work",
// "nameEn": "start.work",
// "isActive": true,
// "updatedAt": "2026-03-17T14:29:22.8281074",
// "isDeleted": false,
// "serviceStatuses": null,
// "roleServices": null,
// "userServices": null
// }
// ]
