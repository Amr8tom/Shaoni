import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final int id;
  final String nameEn;
  final String nameAr;

  const Country({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  @override
  List<Object?> get props => [id, nameEn, nameAr];
}
