import 'package:equatable/equatable.dart';

/// Domain entity for a start-work type returned by
/// GET /Lookup/GetStartWorkingTypes
class StartWorkType extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;

  const StartWorkType({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn];
}
