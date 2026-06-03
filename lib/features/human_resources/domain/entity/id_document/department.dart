import 'package:equatable/equatable.dart';

class Department extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;

  const Department({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn];
}
