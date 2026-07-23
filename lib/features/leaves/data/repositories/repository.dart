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

  @override
  Future<Either<Failure, CreateLeaveReplaceResponse>> createLeaveReplace({
    required CreateLeaveReplaceParams params,
  }) async {
    try {
      final result =
          await _remoteDataSources.createLeaveReplace(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CreateLeaveReplaceResponse>> updateLeaveReplace({
    required UpdateLeaveReplaceParams params,
  }) async {
    try {
      final result =
          await _remoteDataSources.updateLeaveReplace(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<LeaveAppointment>>> getLeaveAppointments({
    required GetLeaveAppointmentsParams params,
  }) async {
    try {
      final result =
          await _remoteDataSources.getLeaveAppointments(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CreateLeaveRequestResponse>> createLeaveRequest({
    required CreateLeaveRequestParams params,
  }) async {
    try {
      final result =
          await _remoteDataSources.createLeaveRequest(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CreateLeaveRequestResponse>> updateLeaveRequest({
    required UpdateLeaveRequestParams params,
  }) async {
    try {
      final result =
          await _remoteDataSources.updateLeaveRequest(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<LeaveEmployee>>> getLeaveEmployees({
    required NoParams params,
  }) async {
    try {
      final result = await _remoteDataSources.getLeaveEmployees(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, LeaveRequestEditData>> getLeaveRequestForEdit({
    required GetLeaveRequestForEditParams params,
  }) async {
    try {
      final result =
          await _remoteDataSources.getLeaveRequestForEdit(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
