import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/training_request.dart';

class TrainingRequestModel extends TrainingRequest {
  const TrainingRequestModel({
    super.courseId,
    super.courseName,
    super.startDate,
    super.endDate,
    super.nominationStartDate,
    super.nominationEndDate,
    super.coursePeriodMonths,
    super.nominationPeriodDays,
    super.note,
    super.attachment,
    super.editReasons,
    super.rejectReasons,
    super.stageName,
  });

  factory TrainingRequestModel.fromJson(Map<String, dynamic> json) {
    return TrainingRequestModel(
      courseId: json['courseId'] as int?,
      courseName: json['courseName']?.toString(),
      startDate: json['startDate']?.toString(),
      endDate: json['endDate']?.toString(),
      nominationStartDate: json['nominationStartDate']?.toString(),
      nominationEndDate: json['nominationEndDate']?.toString(),
      coursePeriodMonths: json['coursePeriodMonths'] as int?,
      nominationPeriodDays: json['nominationPeriodDays'] as int?,
      note: json['note']?.toString(),
      attachment: json['attachment']?.toString(),
      editReasons: json['editReasons']?.toString(),
      rejectReasons: json['rejectReasons']?.toString(),
      stageName: json['stageName']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'courseId': courseId,
        'courseName': courseName,
        'startDate': startDate,
        'endDate': endDate,
        'nominationStartDate': nominationStartDate,
        'nominationEndDate': nominationEndDate,
        'coursePeriodMonths': coursePeriodMonths,
        'nominationPeriodDays': nominationPeriodDays,
        'note': note,
        'attachment': attachment,
        'editReasons': editReasons,
        'rejectReasons': rejectReasons,
        'stageName': stageName,
      };
}
