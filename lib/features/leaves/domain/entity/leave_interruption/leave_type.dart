import 'package:equatable/equatable.dart';

/// Domain entity for a leave type returned by
/// GET /Lookup/GetLeaveTypes
class LeaveType extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;

  const LeaveType({
    required this.id,
    this.nameAr = '',
    this.nameEn = '',
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn];
}
