import 'package:equatable/equatable.dart';

class CarPermission extends Equatable {
  final String? externalName;
  final String? carType;
  final String? carColor;
  final String? carNumber;
  final String? note;
  final String? state;
  final String? attachments;

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
      externalName: json['externalName'],
      carType: json['carType'],
      carColor: json['carColor'],
      carNumber: json['carNumber'],
      note: json['note'],
      state: json['state'],
      attachments: json['attachments'] != null
          ? json['attachments']
          : null,
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
