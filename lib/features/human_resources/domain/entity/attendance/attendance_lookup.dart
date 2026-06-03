import 'package:equatable/equatable.dart';

class AttendanceLookup extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;


  const AttendanceLookup({
    required this.id,
    required this.nameAr,
    required this.nameEn,

  });

  @override
  List<Object?> get props => [id, nameAr, nameEn, ];
}
