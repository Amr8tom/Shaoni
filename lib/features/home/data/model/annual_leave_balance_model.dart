import '../../domain/entities/annual_leave_balance.dart';

class AnnualLeaveBalanceModel extends AnnualLeaveBalance {
  const AnnualLeaveBalanceModel({
    super.id,
    super.nameEn,
    super.nameAr,
    super.leaveValidationType,
    super.leaveValidationTypeNameEn,
    super.leaveValidationTypeNameAr,
    super.requestUnit,
    super.requestUnitNameEn,
    super.requestUnitNameAr,
    super.timeType,
    super.timeTypeNameEn,
    super.timeTypeNameAr,
    super.remainingDays,
    super.totalDays,
    super.usedDays,
    super.updatedAt,
  });

  factory AnnualLeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    return AnnualLeaveBalanceModel(
      id: json['id'] as int?,
      nameEn: json['nameEn'] as String?,
      nameAr: json['nameAr'] as String?,
      leaveValidationType: json['leaveValidationType'] as String?,
      leaveValidationTypeNameEn: json['leaveValidationTypeNameEn'] as String?,
      leaveValidationTypeNameAr: json['leaveValidationTypeNameAr'] as String?,
      requestUnit: json['requestUnit'] as String?,
      requestUnitNameEn: json['requestUnitNameEn'] as String?,
      requestUnitNameAr: json['requestUnitNameAr'] as String?,
      timeType: json['timeType'] as String?,
      timeTypeNameEn: json['timeTypeNameEn'] as String?,
      timeTypeNameAr: json['timeTypeNameAr'] as String?,
      remainingDays: json['remainingDays'] as int?,
      totalDays: json['totalDays'] as int?,
      usedDays: json['usedDays'] as int?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(AnnualLeaveBalance entity) {
    return {
      'id': entity.id,
      'nameEn': entity.nameEn,
      'nameAr': entity.nameAr,
      'leaveValidationType': entity.leaveValidationType,
      'leaveValidationTypeNameEn': entity.leaveValidationTypeNameEn,
      'leaveValidationTypeNameAr': entity.leaveValidationTypeNameAr,
      'requestUnit': entity.requestUnit,
      'requestUnitNameEn': entity.requestUnitNameEn,
      'requestUnitNameAr': entity.requestUnitNameAr,
      'timeType': entity.timeType,
      'timeTypeNameEn': entity.timeTypeNameEn,
      'timeTypeNameAr': entity.timeTypeNameAr,
      'remainingDays': entity.remainingDays,
      'totalDays': entity.totalDays,
      'usedDays': entity.usedDays,
      'updatedAt': entity.updatedAt,
    };
  }
}
