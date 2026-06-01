import 'package:equatable/equatable.dart';

/// Domain entity for a study type returned by
/// GET /Lookup/GetStudyTypes
class StudyType extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;
  final String code;

  const StudyType({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.code,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn, code];
}
