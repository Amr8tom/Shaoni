import 'package:equatable/equatable.dart';

class AttendanceLookup extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;
  final int odooId;
  final String code;

  const AttendanceLookup({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.odooId,
    required this.code,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn, odooId, code];
}
