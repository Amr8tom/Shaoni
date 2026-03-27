import 'package:shaoni/features/my-services/domain/entity/permission_time.dart';

class PermissionTimeModel extends PermissionTime {
  PermissionTimeModel({required super.id, required super.name});

  /// from json
  factory PermissionTimeModel.fromJson(Map<String, dynamic> json) {
    return PermissionTimeModel(id: json['id'], name: json['name']);
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
