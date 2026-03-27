// "exitPermission": {
// "id": 40,
// "exitDate": "2026-03-29T00:00:00",
// "numberOfHours": 1,
// "permissionTimeValue": "med",
// "permissionType": 2,
// "notes": "tejst",
// "leavesAttachment": null
// }


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

  @override
  List<Object?> get props =>
      [
        id,
        exitDate,
        numberOfHours,
        permissionTimeValue,
        permissionType,
        notes,
        leavesAttachment
      ];
}


