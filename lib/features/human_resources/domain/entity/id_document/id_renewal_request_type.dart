import 'package:equatable/equatable.dart';

class IDRenewalRequestType extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;
  final String? code;

  const IDRenewalRequestType({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.code,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn, code];
}
