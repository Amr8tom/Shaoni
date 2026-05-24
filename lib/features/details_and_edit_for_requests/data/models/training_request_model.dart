import 'package:equatable/equatable.dart';

class TrainingRequestModel extends Equatable {
  final int? courseId;
  final String? courseName;
  final String? startDate;
  final String? endDate;
  final String? nominationStartDate;
  final String? nominationEndDate;
  final int? coursePeriodMonths;
  final int? nominationPeriodDays;
  final String? note;
  final String? attachment;
  final String? editReasons;
  final String? rejectReasons;
  final String? stageName;

  const TrainingRequestModel({
    this.courseId,
    this.courseName,
    this.startDate,
    this.endDate,
    this.nominationStartDate,
    this.nominationEndDate,
    this.coursePeriodMonths,
    this.nominationPeriodDays,
    this.note,
    this.attachment,
    this.editReasons,
    this.rejectReasons,
    this.stageName,
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

  @override
  List<Object?> get props => [
        courseId,
        courseName,
        startDate,
        endDate,
        nominationStartDate,
        nominationEndDate,
        coursePeriodMonths,
        nominationPeriodDays,
        note,
        attachment,
        editReasons,
        rejectReasons,
        stageName,
      ];
}
