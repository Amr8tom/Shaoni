import 'package:equatable/equatable.dart';

class PermissionType extends Equatable {
  final int id;
  final String? name;
  final String? nameAr;
  final String? nameEn;
  final int? maxHours;
  final int? maxLimit;

  const PermissionType({
    required this.id,
    required this.name,
    this.nameAr,
    this.nameEn,
    required this.maxHours,
    required this.maxLimit,
  });

  @override
  List<Object?> get props => [id, name, nameAr, nameEn, maxHours, maxLimit];
}
