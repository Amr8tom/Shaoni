import 'package:equatable/equatable.dart';

class DepartmentEntity extends Equatable {
  final int id;
  final String nameEn;
  final String nameAr;
  final String parent_department_id;
  final String parent_department_name;
  final bool isActive;
  final String updatedAt;
  final bool isDeleted;

  const DepartmentEntity(
      {required this.id,
      required this.nameEn,
      required this.nameAr,
      required this.parent_department_id,
      required this.parent_department_name,
      required this.isActive,
      required this.updatedAt,
      required this.isDeleted});

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        parent_department_id,
        parent_department_name,
        isActive,
        isDeleted,
        updatedAt,
      ];
}
