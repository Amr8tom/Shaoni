import 'package:equatable/equatable.dart';

class AnnualLeaveBalance extends Equatable {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final String? leaveValidationType;
  final String? leaveValidationTypeNameEn;
  final String? leaveValidationTypeNameAr;
  final String? requestUnit;
  final String? requestUnitNameEn;
  final String? requestUnitNameAr;
  final String? timeType;
  final String? timeTypeNameEn;
  final String? timeTypeNameAr;
  final int? remainingDays;
  final int? totalDays;
  final int? usedDays;
  final String? updatedAt;

  const AnnualLeaveBalance({
    this.id,
    this.nameEn,
    this.nameAr,
    this.leaveValidationType,
    this.leaveValidationTypeNameEn,
    this.leaveValidationTypeNameAr,
    this.requestUnit,
    this.requestUnitNameEn,
    this.requestUnitNameAr,
    this.timeType,
    this.timeTypeNameEn,
    this.timeTypeNameAr,
    this.remainingDays,
    this.totalDays,
    this.usedDays,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        leaveValidationType,
        leaveValidationTypeNameEn,
        leaveValidationTypeNameAr,
        requestUnit,
        requestUnitNameEn,
        requestUnitNameAr,
        timeType,
        timeTypeNameEn,
        timeTypeNameAr,
        remainingDays,
        totalDays,
        usedDays,
        updatedAt,
      ];
}
