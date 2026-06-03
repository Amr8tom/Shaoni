import 'package:equatable/equatable.dart';

/// Domain entity representing a car color option returned by
/// `GET $baseUrl/Lookup/GetCarColors`.
///
/// Mirrors the shape of `AttendanceLookup` so the dropdown bindings in
/// the Car Permission cubit work the same way.
class CarColor extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;

  const CarColor({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn];
}
