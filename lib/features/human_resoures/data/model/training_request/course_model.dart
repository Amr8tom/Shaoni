import 'package:shaoni/features/human_resoures/domain/entity/training_request/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.name,
    required super.startDate,
    required super.endDate,
    required super.nominationStartDate,
    required super.nominationEndDate,
    required super.coursePeriodMonths,
    required super.nominationPeriodDays,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      nominationStartDate: json['nominationStartDate'] as String? ?? '',
      nominationEndDate: json['nominationEndDate'] as String? ?? '',
      coursePeriodMonths: json['coursePeriodMonths'] as int? ?? 0,
      nominationPeriodDays: json['nominationPeriodDays'] as int? ?? 0,
    );
  }
}
