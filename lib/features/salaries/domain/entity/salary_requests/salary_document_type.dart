import 'package:equatable/equatable.dart';

class SalaryDocumentType extends Equatable {
  final int id;
  final String code;
  final String nameAr;
  final String nameEn;

  const SalaryDocumentType({
    required this.id,
    required this.code,
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, code, nameAr, nameEn];
}
