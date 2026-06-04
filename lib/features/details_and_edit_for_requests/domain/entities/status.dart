import 'package:equatable/equatable.dart';

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

  @override
  List<Object?> get props =>
      [id, code, nameAr, nameEn, techName, isActive, updatedAt, isDeleted];
}
