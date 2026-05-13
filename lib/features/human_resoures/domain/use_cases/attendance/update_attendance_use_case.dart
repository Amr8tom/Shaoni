import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/attendance/update_attendance.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';

class UpdateAttendanceUseCase
    extends UseCase<UpdateAttendance, UpdateAttendanceParams> {
  final HRServicesRepository repository;

  UpdateAttendanceUseCase(this.repository);

  @override
  Future<Either<Failure, UpdateAttendance>> call({
    required UpdateAttendanceParams params,
  }) async {
    return await repository.updateAttendance(params: params);
  }
}

class UpdateAttendanceParams {
  final int requestId;
  final int employee;
  final int officeId;
  final String attendanceType;
  final String updateDate;
  final String date;
  final int attendanceId;
  final String orderReason;
  final int forgetReasonsIds;
  final String? note;
  final String? editReasons;
  final String? rejectReasons;
  final int stageId;
  final String? orderDate;
  final String? attachmentName;
  final String? attachment;

  UpdateAttendanceParams({
    required this.requestId,
    required this.employee,
    required this.officeId,
    required this.attendanceType,
    required this.updateDate,
    required this.date,
    required this.attendanceId,
    required this.orderReason,
    required this.forgetReasonsIds,
    this.note,
    this.editReasons,
    this.rejectReasons,
    this.stageId = 0,
    this.orderDate,
    this.attachmentName,
    this.attachment,
  });

  Map<String, dynamic> toMap() {
    return {
      'employee': employee,
      'office_id': officeId,
      'attendance_type': attendanceType,
      'update_Date': updateDate,
      'date': date,
      'attendance_id': attendanceId,
      'order_reason': orderReason,
      'forget_reasons_ids': forgetReasonsIds,
      'request_attachment_ids': [
        {
          'name': attachmentName ?? '',
          'attachment_ids': [
            {
              'name': attachmentName ?? '',
              'attachment': attachment ?? '',
            }
          ],
        }
      ],
      'fields': [
        'id',
        'name',
        'order_date',
        'registration_number',
        'attendance_type',
        'update_date',
        'order_reason',
        'stage_id',
        'employee',
        'department_id',
        'resource_calendar_id',
        'forget_reasons_ids',
        'attendance_id',
        'request_attachment_ids',
      ],
      'stage_id': stageId,
      'order_date': orderDate ?? '',
      'note': note ?? '',
      'edit_reasons': editReasons ?? '',
      'reject_reasons': rejectReasons ?? '',
    };
  }
}
