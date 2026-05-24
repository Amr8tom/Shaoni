import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final int id;
  final String name;
  final String startDate;
  final String endDate;
  final String nominationStartDate;
  final String nominationEndDate;
  final int coursePeriodMonths;
  final int nominationPeriodDays;

  const Course({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.nominationStartDate,
    required this.nominationEndDate,
    required this.coursePeriodMonths,
    required this.nominationPeriodDays,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        startDate,
        endDate,
        nominationStartDate,
        nominationEndDate,
        coursePeriodMonths,
        nominationPeriodDays,
      ];
}
