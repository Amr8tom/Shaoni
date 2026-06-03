import 'package:equatable/equatable.dart';

class EmployeeRelative extends Equatable {
  final int id;
  final String name;
  final String fullName;
  final String relationAr;
  final String relationEn;

  const EmployeeRelative({
    required this.id,
    required this.name,
    required this.fullName,
    required this.relationAr,
    required this.relationEn,
  });

  @override
  List<Object?> get props => [id, name, fullName, relationAr, relationEn];
}
