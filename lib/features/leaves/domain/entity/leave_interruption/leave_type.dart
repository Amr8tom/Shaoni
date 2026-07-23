import 'package:equatable/equatable.dart';

/// Domain entity for a leave type returned by
/// GET /Lookup/GetLeaveTypes
class LeaveType extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;

  /// e.g. "third" / "manager" / "both" — used as `validation_type` when
  /// creating an hr.leave request.
  final String leaveValidationType;

  const LeaveType({
    required this.id,
    this.nameAr = '',
    this.nameEn = '',
    this.leaveValidationType = '',
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn, leaveValidationType];
}
