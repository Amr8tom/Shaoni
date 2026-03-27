import 'package:equatable/equatable.dart';

class PermissionType extends Equatable {
  final int id;
  final String? name;
  final int? maxHours;
  final int? maxLimit;

  const PermissionType({
    required this.id,
    required this.name,
    required this.maxHours,
    required this.maxLimit,
  });

  @override
  List<Object?> get props => [id, name, maxHours, maxLimit];
}
