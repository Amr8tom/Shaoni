import 'package:equatable/equatable.dart';

// [ { "id": 1, "value": "first", "nameAr": "بداية الدوام", "nameEn": "Beginning of work day" }, ... ]

class PermissionTime extends Equatable {
  final int id;

  /// Backend key sent as the request `type` (e.g. "first" / "med" / "last").
  final String? value;
  final String? nameAr;
  final String? nameEn;

  const PermissionTime({
    required this.id,
    this.value,
    this.nameAr,
    this.nameEn,
  });

  @override
  List<Object?> get props => [id, value, nameAr, nameEn];
}
