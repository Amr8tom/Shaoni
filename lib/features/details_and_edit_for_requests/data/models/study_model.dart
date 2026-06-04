import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/study/study.dart';

class StudyModel extends Study {
  const StudyModel({
    super.requestType,
    super.requestTypeLabel,
    super.study,
    super.studyDestinationsText,
    super.studyDestinationId,
    super.studyStartDate,
    super.studyEndDate,
    super.note,
    super.reason,
    super.comment,
    super.editReasons,
    super.rejectReasons,
    super.attachments,
  });

  /// fromJson
  factory StudyModel.fromJson(Map<String, dynamic> json) {
    return StudyModel(
      requestType: json['requestType'] as String?,
      requestTypeLabel: json['requestTypeLabel'] as String?,
      study: json['study'] as String?,
      studyDestinationsText: json['studyDestinationsText'] as String?,
      studyDestinationId: json['studyDestinationId'] as int?,
      studyStartDate: json['studyStartDate'] as String?,
      studyEndDate: json['studyEndDate'] as String?,
      note: json['note'] as String?,
      reason: json['reason'] as String?,
      comment: json['comment'] as String?,
      editReasons: json['editReasons'] as String?,
      rejectReasons: json['rejectReasons'] as String?,
      attachments: json['attachments'] != null
          ? List<String>.from(json['attachments'] as List)
          : null,
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'requestType': requestType,
      'requestTypeLabel': requestTypeLabel,
      'study': study,
      'studyDestinationsText': studyDestinationsText,
      'studyDestinationId': studyDestinationId,
      'studyStartDate': studyStartDate,
      'studyEndDate': studyEndDate,
      'note': note,
      'reason': reason,
      'comment': comment,
      'editReasons': editReasons,
      'rejectReasons': rejectReasons,
      'attachments': attachments,
    };
  }
}
