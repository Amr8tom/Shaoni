import 'package:equatable/equatable.dart';
import 'package:shaoni/core/models/request_attachment.dart';

class ExitPermission extends Equatable {
  final int? id;
  final String? exitDate;
  final int? numberOfHours;
  final String? permissionTimeValue;
  final int? permissionType;
  final String? notes;
  final String? leavesAttachment;
  final List<RequestAttachment> attachments;

  const ExitPermission({
    this.id,
    this.exitDate,
    this.numberOfHours,
    this.permissionTimeValue,
    this.permissionType,
    this.notes,
    this.leavesAttachment,
    this.attachments = const [],
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
      attachments: RequestAttachment.fromServiceMap(json),
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
      'leaves_attachment_ids': attachments.map((e) => e.toJson()).toList(),
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
        attachments,
      ];
}
