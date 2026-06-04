import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/start_work.dart';

class StartWorkModel extends StartWork {
  const StartWorkModel({
    super.externalName,
    super.date,
    super.startDate,
    super.typeId,
    super.typeName,
    super.employeeId,
    super.managerId,
    super.managerName,
    super.note,
    super.attachment,
    super.state,
    super.editReasons,
    super.rejectReasons,
  });

  factory StartWorkModel.fromJson(Map<String, dynamic> json) {
    return StartWorkModel(
      externalName: json['externalName']?.toString(),
      date: json['date']?.toString(),
      startDate: json['startDate']?.toString(),
      typeId: (json['typeId'] as num?)?.toInt(),
      typeName: json['typeName']?.toString(),
      employeeId: (json['employeeId'] as num?)?.toInt(),
      managerId: (json['managerId'] as num?)?.toInt(),
      managerName: json['managerName']?.toString(),
      note: json['note']?.toString(),
      attachment: json['attachment']?.toString(),
      state: json['state']?.toString(),
      editReasons: json['editReasons']?.toString(),
      rejectReasons: json['rejectReasons']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'externalName': externalName,
        'date': date,
        'startDate': startDate,
        'typeId': typeId,
        'typeName': typeName,
        'employeeId': employeeId,
        'managerId': managerId,
        'managerName': managerName,
        'note': note,
        'attachment': attachment,
        'state': state,
        'editReasons': editReasons,
        'rejectReasons': rejectReasons,
      };
}
