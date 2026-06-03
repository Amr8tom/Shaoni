import 'package:equatable/equatable.dart';

class DepartmentTypeLookup extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;

  const DepartmentTypeLookup({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn];
}
