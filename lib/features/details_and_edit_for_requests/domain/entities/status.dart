import 'package:equatable/equatable.dart';

// "status": {
// "id": 13,
// "code": "1",
// "nameAr": "جديد",
// "nameEn": "New",
// "techName": "new",
// "isActive": true,
// "updatedAt": "2026-03-18T11:35:38.2681105",
// "isDeleted": false,
// "serviceStatuses": null
// }

class Status extends Equatable {
  final int id;
  final String? code;
  final String? nameAr;
  final String? nameEn;
  final String? techName;
  final bool isActive;
  final String? updatedAt;
  final bool isDeleted;

  const Status({
    required this.id,
    this.code,
    this.nameAr,
    this.nameEn,
    this.techName,
    required this.isActive,
    this.updatedAt,
    required this.isDeleted,
  });

  /// Empty status constructor for default/null cases
  factory Status.empty() {
    return const Status(
      id: 0,
      code: '',
      nameAr: 'Unknown',
      nameEn: 'Unknown',
      techName: 'unknown',
      isActive: false,
      updatedAt: null,
      isDeleted: false,
    );
  }

  /// from Json
  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      code: json['code'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      techName: json['techName'],
      isActive: json['isActive'] ?? false,
      updatedAt: json['updatedAt'],
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'techName': techName,
      'isActive': isActive,
      'updatedAt': updatedAt,
      'isDeleted': isDeleted,
    };
  }

  @override
  List<Object?> get props =>
      [id, code, nameAr, nameEn, techName, isActive, updatedAt, isDeleted];
}
