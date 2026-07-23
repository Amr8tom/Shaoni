import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/create_leave_interruption_response.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/employee_leave.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/interruption_type.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/leave_type.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/create_leave_interruption_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/search_employee_leaves_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/update_leave_interruption_use_case.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_replace/create_leave_replace_response.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_replace/create_leave_replace_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_replace/update_leave_replace_use_case.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_request/leave_appointment.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/get_leave_appointments_use_case.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_request/create_leave_request_response.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/create_leave_request_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/update_leave_request_use_case.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_request/leave_employee.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_request/leave_request_edit_data.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_request/get_leave_request_for_edit_use_case.dart';

abstract class LeavesRepository {
  /// ============================ leave interruption ============================
  Future<Either<Failure, List<LeaveType>>> getLeaveTypes({
    required NoParams params,
  });

  Future<Either<Failure, List<InterruptionType>>> getInterruptionTypes({
    required NoParams params,
  });

  Future<Either<Failure, List<EmployeeLeave>>> searchEmployeeLeaves({
    required SearchEmployeeLeavesParams params,
  });

  Future<Either<Failure, CreateLeaveInterruptionResponse>>
      createLeaveInterruption({
    required CreateLeaveInterruptionParams params,
  });

  Future<Either<Failure, CreateLeaveInterruptionResponse>>
      updateLeaveInterruption({
    required UpdateLeaveInterruptionParams params,
  });

  /// ============================ leave replace ============================
  Future<Either<Failure, CreateLeaveReplaceResponse>> createLeaveReplace({
    required CreateLeaveReplaceParams params,
  });

  Future<Either<Failure, CreateLeaveReplaceResponse>> updateLeaveReplace({
    required UpdateLeaveReplaceParams params,
  });

  /// ============================ leave request ============================
  Future<Either<Failure, List<LeaveAppointment>>> getLeaveAppointments({
    required GetLeaveAppointmentsParams params,
  });

  Future<Either<Failure, CreateLeaveRequestResponse>> createLeaveRequest({
    required CreateLeaveRequestParams params,
  });

  Future<Either<Failure, CreateLeaveRequestResponse>> updateLeaveRequest({
    required UpdateLeaveRequestParams params,
  });

  Future<Either<Failure, List<LeaveEmployee>>> getLeaveEmployees({
    required NoParams params,
  });

  Future<Either<Failure, LeaveRequestEditData>> getLeaveRequestForEdit({
    required GetLeaveRequestForEditParams params,
  });
}
