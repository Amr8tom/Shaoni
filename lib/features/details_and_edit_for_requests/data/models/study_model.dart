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
      attachments: _parseAttachments(json['attachments']),
    );
  }

  /// `attachments` has shipped in two shapes:
  ///   - legacy: a plain list of base64 strings
  ///   - current: `[{ id, name, files: [{ id, name, attachmentBase64 }] }]`
  /// Both are flattened to the base64 strings the attachment widget expects.
  static List<String>? _parseAttachments(Object? raw) {
    if (raw is! List) return null;

    final result = <String>[];
    for (final item in raw) {
      if (item is String) {
        if (item.isNotEmpty) result.add(item);
        continue;
      }
      if (item is! Map) continue;

      var addedFromFiles = false;
      final files = item['files'];
      if (files is List) {
        for (final file in files) {
          if (file is! Map) continue;
          final base64 = file['attachmentBase64'] ?? file['attachment'];
          if (base64 is String && base64.isNotEmpty) {
            result.add(base64);
            addedFromFiles = true;
          }
        }
      }
      if (addedFromFiles) continue;

      final base64 = item['attachmentBase64'] ?? item['attachment'];
      if (base64 is String && base64.isNotEmpty) result.add(base64);
    }

    return result.isEmpty ? null : result;
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
