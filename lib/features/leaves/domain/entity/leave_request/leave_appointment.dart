import 'package:equatable/equatable.dart';

/// A previously-booked leave shown read-only under
/// "الإجازات المحجوزة مسبقًا (للعرض فقط)".
/// Source: GET /hr_leave/appointments/{employeeId}
class LeaveAppointment extends Equatable {
  final int? id;
  final String name;
  final String requestDateFrom;
  final String requestDateTo;
  final String holidayStatusName;
  final String stageName;

  const LeaveAppointment({
    this.id,
    this.name = '',
    this.requestDateFrom = '',
    this.requestDateTo = '',
    this.holidayStatusName = '',
    this.stageName = '',
  });

  @override
  List<Object?> get props => [
        id,
        name,
        requestDateFrom,
        requestDateTo,
        holidayStatusName,
        stageName,
      ];
}
