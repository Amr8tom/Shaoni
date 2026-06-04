// "experienceCertificate": { "externalName": "TR000045", "date": "2026-05-20", "certificateReasonId": 2, "certificateReasonName": "Reason 02", "reason": "add", "note": "", "state": "اعتماد الموارد البشرية", "editReasons": null, "rejectReasons": nu
// ll, "certificateUrl": null }

import '../../domain/entities/certification/experience_certificate.dart';

class ExperienceCertificateModel extends ExperienceCertificate {
  const ExperienceCertificateModel(
      {required super.externalName,
      required super.date,
      required super.certificateReasonId,
      required super.certificateReasonName,
      required super.reason,
      required super.note,
      required super.state,
      required super.certificateUrl,
      required super.editReasons,
      required super.rejectReasons});

  /// from Json
  factory ExperienceCertificateModel.fromJson(Map<String, dynamic> json) {
    return ExperienceCertificateModel(
      externalName: json['externalName'] ?? '',
      date: json['date'] ?? '',
      certificateReasonId: json['certificateReasonId']?.toString() ?? '',
      certificateReasonName: json['certificateReasonName'] ?? '',
      reason: json['reason'] ?? '',
      note: json['note'] ?? '',
      state: json['state'] ?? '',
      certificateUrl: json['certificateUrl'],
      editReasons: json['editReasons'],
      rejectReasons: json['rejectReasons'],
    );
  }

  /// to Json
  Map<String, dynamic> toJson() {
    return {
      'externalName': externalName,
      'date': date,
      'certificateReasonId': certificateReasonId,
      'certificateReasonName': certificateReasonName,
      'reason': reason,
      'note': note,
      'state': state,
      'certificateUrl': certificateUrl,
      'editReasons': editReasons,
      'rejectReasons': rejectReasons,
    };
  }
}
