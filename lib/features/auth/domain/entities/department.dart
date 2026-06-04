import 'package:equatable/equatable.dart';

class DepartmentEntity extends Equatable {
  final int id;
  final String nameEn;
  final String nameAr;
  final String parentDepartmentId;
  final String parentDepartmentName;
  final bool isActive;
  final String updatedAt;
  final bool isDeleted;

  const DepartmentEntity(
      {required this.id,
      required this.nameEn,
      required this.nameAr,
      required this.parentDepartmentId,
      required this.parentDepartmentName,
      required this.isActive,
      required this.updatedAt,
      required this.isDeleted});

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        parentDepartmentId,
        parentDepartmentName,
        isActive,
        isDeleted,
        updatedAt,
      ];
}
