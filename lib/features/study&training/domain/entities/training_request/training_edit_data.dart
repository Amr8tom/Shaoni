import 'package:equatable/equatable.dart';

/// Editable snapshot of an existing training request, used to prefill the form
/// in edit mode. Source: GET /Request/{id}/with-stages → extraData.trainingRequest
class TrainingEditData extends Equatable {
  final int? courseId;
  final String courseName;
  final String date;
  final String note;
  final int? officeId;

  /// Base64 payload of the stored attachment. The API uses the literal string
  /// `"false"` to mean "no attachment", which is normalised to '' here.
  final String attachment;

  const TrainingEditData({
    this.courseId,
    this.courseName = '',
    this.date = '',
    this.note = '',
    this.officeId,
    this.attachment = '',
  });

  bool get hasAttachment => attachment.isNotEmpty;

  @override
  List<Object?> get props => [
        courseId,
        courseName,
        date,
        note,
        officeId,
        attachment,
      ];
}
