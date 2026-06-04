import 'package:equatable/equatable.dart';

class CarPermission extends Equatable {
  final String? externalName;
  final String? carType;
  final String? carColor;
  final String? carNumber;
  final String? note;
  final String? state;
  final List<String>? attachments;

  const CarPermission({
    this.externalName,
    this.carType,
    this.carColor,
    this.carNumber,
    this.note,
    this.state,
    this.attachments,
  });

  /// fromJson
  factory CarPermission.fromJson(Map<String, dynamic> json) {
    return CarPermission(
      externalName: json['externalName']?.toString(),
      carType: json['carType']?.toString(),
      carColor: json['carColor']?.toString(),
      carNumber: json['carNumber']?.toString(),
      note: json['note']?.toString(),
      state: json['state']?.toString(),
      attachments: _attachmentsFromJson(json['attachments']),
    );
  }

  static List<String>? _attachmentsFromJson(Object? value) {
    if (value == null) return null;
    if (value is String) return value.isEmpty ? null : [value];
    if (value is List) {
      final attachments = value
          .where((item) => item != null)
          .map((item) => item.toString())
          .where((item) => item.isNotEmpty)
          .toList();
      return attachments.isEmpty ? null : attachments;
    }
    return null;
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'externalName': externalName,
      'carType': carType,
      'carColor': carColor,
      'carNumber': carNumber,
      'note': note,
      'state': state,
      'attachments': attachments,
    };
  }

  @override
  List<Object?> get props => [
        externalName,
        carType,
        carColor,
        carNumber,
        note,
        state,
        attachments,
      ];
}
