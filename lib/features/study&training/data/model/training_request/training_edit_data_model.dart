import 'package:shaoni/features/study&training/domain/entities/training_request/training_edit_data.dart';

class TrainingEditDataModel extends TrainingEditData {
  const TrainingEditDataModel({
    super.courseId,
    super.courseName = '',
    super.date = '',
    super.note = '',
    super.officeId,
    super.attachment = '',
  });

  /// Reads the full `Request/{id}/with-stages` payload: the editable fields
  /// live in `extraData.trainingRequest`, while `officeId` falls back to
  /// `request.officeId` (extraData often returns it as null).
  factory TrainingEditDataModel.fromResponse(Map<String, dynamic> response) {
    final extraData = response['extraData'];
    final training =
        extraData is Map<String, dynamic> ? extraData['trainingRequest'] : null;
    final map = training is Map<String, dynamic> ? training : const {};

    final request = response['request'];
    final requestOfficeId =
        request is Map<String, dynamic> ? request['officeId'] as int? : null;

    return TrainingEditDataModel(
      courseId: map['courseId'] as int?,
      courseName: map['courseName'] as String? ?? '',
      date: _dateOnly(map['date'] as String?),
      note: map['note'] as String? ?? '',
      officeId: (map['officeId'] as int?) ?? requestOfficeId,
      attachment: normalizeAttachment(map['attachment']),
    );
  }

  /// The API sends the literal string `"false"` (and sometimes a bool) when
  /// there is no attachment — never a base64 payload. Sending that back makes
  /// the server fail with "Invalid base64-encoded string", so it is dropped.
  static String normalizeAttachment(Object? raw) {
    if (raw is! String) return '';
    final value = raw.trim();
    if (value.isEmpty ||
        value.toLowerCase() == 'false' ||
        value.toLowerCase() == 'null') {
      return '';
    }
    return value;
  }

  static String _dateOnly(String? value) {
    if (value == null || value.isEmpty) return '';
    return value.contains('T') ? value.split('T').first : value;
  }
}
