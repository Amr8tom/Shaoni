import 'package:equatable/equatable.dart';

class MedicalInsuranceClass extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;
  final double value;

  const MedicalInsuranceClass({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.value,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn, value];
}
