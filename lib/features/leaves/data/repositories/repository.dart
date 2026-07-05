import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/data/data_sources/remote_data_sources.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/create_leave_interruption_response.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/employee_leave.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/interruption_type.dart';
import 'package:shaoni/features/leaves/domain/entity/leave_interruption/leave_type.dart';
import 'package:shaoni/features/leaves/domain/repository/repository.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/create_leave_interruption_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/search_employee_leaves_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/update_leave_interruption_use_case.dart';

class LeavesRepositoryImp implements LeavesRepository {
  final LeavesRemoteDataSources _remoteDataSources;

  const LeavesRepositoryImp(this._remoteDataSources);

  @override
  Future<Either<Failure, List<LeaveType>>> getLeaveTypes({
    required NoParams params,
  }) async {
    try {
      final result = await _remoteDataSources.getLeaveTypes(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<InterruptionType>>> getInterruptionTypes({
    required NoParams params,
  }) async {
    try {
      final result =
          await _remoteDataSources.getInterruptionTypes(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<EmployeeLeave>>> searchEmployeeLeaves({
    required SearchEmployeeLeavesParams params,
  }) async {
    try {
      final result =
          await _remoteDataSources.searchEmployeeLeaves(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CreateLeaveInterruptionResponse>>
      createLeaveInterruption({
    required CreateLeaveInterruptionParams params,
  }) async {
    try {
      final result =
          await _remoteDataSources.createLeaveInterruption(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CreateLeaveInterruptionResponse>>
      updateLeaveInterruption({
    required UpdateLeaveInterruptionParams params,
  }) async {
    try {
      final result =
          await _remoteDataSources.updateLeaveInterruption(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
