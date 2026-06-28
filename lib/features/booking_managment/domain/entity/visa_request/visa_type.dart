import 'package:equatable/equatable.dart';

/// Domain entity for a visa type returned by
/// GET /Lookup/GetVisaTypes
class VisaType extends Equatable {
  final int id;
  final String code;
  final String nameAr;
  final String nameEn;

  const VisaType({
    required this.id,
    required this.code,
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, code, nameAr, nameEn];
}
