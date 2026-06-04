import 'package:shaoni/features/auth/domain/entities/office.dart';

class OfficeModel extends OfficeEntity {
  OfficeModel({required super.id, required super.name});

  /// fromJson
  factory OfficeModel.fromJson(Map<String, dynamic>? json) {
    return OfficeModel(
      id: json?['id'] ?? 0,
      name: json?['name'] ?? '',
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
