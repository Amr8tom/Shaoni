import 'package:equatable/equatable.dart';

/// A leave type returned by GET /Lookup/GetEmployeeLeavesTypes/{employeeId},
/// used by the start-work "نوع الإجازة" dropdown (holiday_status_id).
class EmployeeLeaveType extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;

  const EmployeeLeaveType({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn];
}
