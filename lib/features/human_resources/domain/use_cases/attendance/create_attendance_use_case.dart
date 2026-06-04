import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entity/attendance/attendance.dart';
import '../../repository/repository.dart';

class CreateAttendanceUseCase
    extends UseCase<Attendance, CreateAttendanceParams> {
  final HRServicesRepository _repository;
  CreateAttendanceUseCase(this._repository);

  @override
  Future<Either<Failure, Attendance>> call(
      {required CreateAttendanceParams params}) async {
    return await _repository.createAttendance(params: params);
  }
}

class CreateAttendanceParams {
  final int employee;
  final int officeId;
  final String attendanceType;
  final String updateDate;
  final String date;
  final int attendanceId;
  final String orderReason;
  final int forgetReasonsIds;

  CreateAttendanceParams({
    required this.employee,
    required this.officeId,
    required this.attendanceType,
    required this.updateDate,
    required this.date,
    required this.attendanceId,
    required this.orderReason,
    required this.forgetReasonsIds,
  });

  /// toMap
  Map<String, dynamic> toMap() {
    return {
      "employee": employee,
      "attendance_type": attendanceType,
      "update_Date": updateDate,
      "date": date,
      "attendance_id": attendanceId,
      "order_reason": orderReason,
      "forget_reasons_ids": forgetReasonsIds,
      "office_id": officeId,
      // "request_attachment_ids": this.requestAttachmentIds.map((e) => e.toMap()).toList(),
      "fields": [
        "id",
        "name",
        "order_date",
        "registration_number",
        "attendance_type",
        "update_date",
        "order_reason",
        "stage_id",
        "employee",
        "department_id",
        "resource_calendar_id",
        "forget_reasons_ids",
        "attendance_id",
        "request_attachment_ids"
      ]
    };
  }
}
