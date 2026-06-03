import 'package:equatable/equatable.dart';

// [ { "id": 1, "name": "first" }, { "id": 2, "name": "med" }, { "id": 3, "name": "last" } ]

class PermissionTime extends Equatable {
  final int id;
  final String? name;

  const PermissionTime({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
