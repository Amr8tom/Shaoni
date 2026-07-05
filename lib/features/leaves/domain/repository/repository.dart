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
}
