import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final int? id;
  final String? code;
  final String? nameAr;
  final String? nameEn;
  final bool? isActive;
  final String? updatedAt;
  final bool? isDeleted;

  const Service({
    this.id,
    this.code,
    this.nameAr,
    this.nameEn,
    this.isActive,
    this.updatedAt,
    this.isDeleted,
  });

  @override
  List<Object?> get props => [
        id,
        code,
        nameAr,
        nameEn,
        isActive,
        updatedAt,
        isDeleted,
      ];
}
