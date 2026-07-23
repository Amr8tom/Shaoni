import 'package:equatable/equatable.dart';

/// Editable snapshot of an existing study request, used to prefill the form in
/// edit mode. Source: GET /Request/{id}/with-stages → extraData.study
class StudyEditData extends Equatable {
  final String requestType;
  final String study;
  final int? studyDestinationId;
  final String studyStartDate;
  final String studyEndDate;
  final String note;
  final String reason;
  final String comment;

  /// First existing attachment, so it can be re-sent and not wiped on update.
  final String attachmentName;
  final String attachmentBase64;

  const StudyEditData({
    this.requestType = '',
    this.study = '',
    this.studyDestinationId,
    this.studyStartDate = '',
    this.studyEndDate = '',
    this.note = '',
    this.reason = '',
    this.comment = '',
    this.attachmentName = '',
    this.attachmentBase64 = '',
  });

  @override
  List<Object?> get props => [
        requestType,
        study,
        studyDestinationId,
        studyStartDate,
        studyEndDate,
        note,
        reason,
        comment,
        attachmentName,
        attachmentBase64,
      ];
}
