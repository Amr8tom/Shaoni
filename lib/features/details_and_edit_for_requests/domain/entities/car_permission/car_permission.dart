import 'package:equatable/equatable.dart';
import 'package:shaoni/core/models/request_attachment.dart';

class CarPermission extends Equatable {
  final String? externalName;
  final String? carType;
  final String? carColor;
  final String? carNumber;
  final String? note;
  final String? state;
  final List<RequestAttachment> attachments;

  const CarPermission({
    this.externalName,
    this.carType,
    this.carColor,
    this.carNumber,
    this.note,
    this.state,
    this.attachments = const [],
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
      attachments: RequestAttachment.fromServiceMap(json),
    );
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
      'attachments': attachments.map((e) => e.toJson()).toList(),
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
