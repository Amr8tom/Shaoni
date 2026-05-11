import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../../data/model/attendance/attendance_model.dart';
import '../../repository/repository.dart';

class CreateAttendanceUseCase extends UseCase<AttendanceModel,CreateAttendanceParams>{
  final HRServicesRepository _repository;
   CreateAttendanceUseCase(this._repository);

  @override
  Future<Either<Failure, AttendanceModel>> call({required CreateAttendanceParams params}) async{
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
      "employee": this.employee,
      "attendance_type": this.attendanceType,
      "update_Date": this.updateDate,
      "date": this.date,
      "attendance_id": this.attendanceId,
      "order_reason": this.orderReason,
      "forget_reasons_ids": this.forgetReasonsIds,
      "office_id":this.officeId,
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
