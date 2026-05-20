class StartWorkModel {
  final int? id;
  final String? startWorkType;
  final String? employeeName;
  final String? startDate;
  final String? note;

  const StartWorkModel({
    this.id,
    this.startWorkType,
    this.employeeName,
    this.startDate,
    this.note,
  });

  factory StartWorkModel.fromJson(Map<String, dynamic> json) {
    return StartWorkModel(
      id: json['id'],
      startWorkType: json['startWorkType'] as String?,
      employeeName: json['employeeName'] as String?,
      startDate: json['startDate'] as String?,
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'startWorkType': startWorkType,
        'employeeName': employeeName,
        'startDate': startDate,
        'note': note,
      };
}
