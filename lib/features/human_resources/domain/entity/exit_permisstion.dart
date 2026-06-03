import 'package:equatable/equatable.dart';

class ExitPermission extends Equatable {
  final int? id;
  final String? exitDate;
  final int? numberOfHours;
  final String? permissionTimeValue;
  final int? permissionType;
  final String? notes;
  final String? leavesAttachment;


  const ExitPermission({
    this.id,
    this.exitDate,
    this.numberOfHours,
    this.permissionTimeValue,
    this.permissionType,
    this.notes,
    this.leavesAttachment,

  });

  /// from Json
  factory ExitPermission.fromJson(Map<String, dynamic> json) {
    return ExitPermission(
      id: json['id'],
      exitDate: json['exitDate'],
      numberOfHours: json['numberOfHours'],
      permissionTimeValue: json['permissionTimeValue'],
      permissionType: json['permissionType'],
      notes: json['notes'],
      leavesAttachment: json['leavesAttachment'],

    );
  }
  /// to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exitDate': exitDate,
      'numberOfHours': numberOfHours,
      'permissionTimeValue': permissionTimeValue,
      'permissionType': permissionType,
      'notes': notes,
      'leavesAttachment': leavesAttachment,

    };
  }

  @override
  List<Object?> get props => [
    id,
    exitDate,
    numberOfHours,
    permissionTimeValue,
    permissionType,
    notes,
    leavesAttachment,

  ];
}
