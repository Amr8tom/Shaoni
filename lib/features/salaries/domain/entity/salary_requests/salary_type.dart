import 'package:equatable/equatable.dart';

class SalaryType extends Equatable {
  final int id;
  final String code;
  final String nameAr;
  final String nameEn;

  const SalaryType({
    required this.id,
    required this.code,
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, code, nameAr, nameEn];
}
