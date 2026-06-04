import 'package:equatable/equatable.dart';

class TrainingRequest extends Equatable {
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

  const TrainingRequest({
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
