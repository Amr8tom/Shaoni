class StartWorkModel {
  final String? externalName;
  final String? date;
  final String? startDate;
  final int? typeId;
  final String? typeName;
  final int? employeeId;
  final int? managerId;
  final String? managerName;
  final String? note;
  final String? attachment;
  final String? state;
  final String? editReasons;
  final String? rejectReasons;

  const StartWorkModel({
    this.externalName,
    this.date,
    this.startDate,
    this.typeId,
    this.typeName,
    this.employeeId,
    this.managerId,
    this.managerName,
    this.note,
    this.attachment,
    this.state,
    this.editReasons,
    this.rejectReasons,
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
