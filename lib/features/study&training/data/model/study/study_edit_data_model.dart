import 'package:shaoni/features/study&training/domain/entities/study/study_edit_data.dart';

class StudyEditDataModel extends StudyEditData {
  const StudyEditDataModel({
    super.requestType = '',
    super.study = '',
    super.studyDestinationId,
    super.studyStartDate = '',
    super.studyEndDate = '',
    super.note = '',
    super.reason = '',
    super.comment = '',
    super.attachmentName = '',
    super.attachmentBase64 = '',
  });

  /// Parses the `extraData.study` object.
  factory StudyEditDataModel.fromJson(Map<String, dynamic> json) {
    final attachment = _firstAttachment(json['attachments']);

    return StudyEditDataModel(
      requestType: json['requestType'] as String? ?? '',
      study: json['study'] as String? ?? '',
      studyDestinationId: json['studyDestinationId'] as int?,
      studyStartDate: _dateOnly(json['studyStartDate'] as String?),
      studyEndDate: _dateOnly(json['studyEndDate'] as String?),
      note: json['note'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
      comment: json['comment'] as String? ?? '',
      attachmentName: attachment?.$1 ?? '',
      attachmentBase64: attachment?.$2 ?? '',
    );
  }

  static String _dateOnly(String? value) {
    if (value == null || value.isEmpty) return '';
    return value.contains('T') ? value.split('T').first : value;
  }

  /// `attachments` ships as `[{ id, name, files: [{ name, attachmentBase64 }] }]`
  /// (legacy: a plain base64 string list). Returns the first (name, base64).
  static (String, String)? _firstAttachment(Object? raw) {
    if (raw is! List) return null;

    for (final item in raw) {
      if (item is String && item.isNotEmpty) return ('', item);
      if (item is! Map) continue;

      final name = item['name'] as String? ?? '';
      final files = item['files'];
      if (files is List) {
        for (final file in files) {
          if (file is! Map) continue;
          final base64 = file['attachmentBase64'] ?? file['attachment'];
          if (base64 is String && base64.isNotEmpty) {
            return (file['name'] as String? ?? name, base64);
          }
        }
      }
      final base64 = item['attachmentBase64'] ?? item['attachment'];
      if (base64 is String && base64.isNotEmpty) return (name, base64);
    }
    return null;
  }
}
