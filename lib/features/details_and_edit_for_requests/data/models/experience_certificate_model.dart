class ExperienceCertificateModel {
  final int? id;
  final String? certificateReason;
  final String? reason;
  final String? note;
  final String? date;

  const ExperienceCertificateModel({
    this.id,
    this.certificateReason,
    this.reason,
    this.note,
    this.date,
  });

  factory ExperienceCertificateModel.fromJson(Map<String, dynamic> json) {
    return ExperienceCertificateModel(
      id: json['id'] as int?,
      certificateReason: json['certificateReason']?.toString() ??
          json['certificate_reason']?.toString(),
      reason: json['reason']?.toString(),
      note: json['note']?.toString(),
      date: json['date']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'certificateReason': certificateReason,
        'reason': reason,
        'note': note,
        'date': date,
      };
}
