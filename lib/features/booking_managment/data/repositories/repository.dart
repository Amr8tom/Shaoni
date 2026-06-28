import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/data/data_sources/remote_data_sources.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/create_visa_response.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_employee.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_language.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_type.dart';
import 'package:shaoni/features/booking_managment/domain/repository/repository.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/get_visa_employees_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/create_visa_request_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/update_visa_request_use_case.dart';

class BookingManagementRepositoryImp implements BookingManagementRepository {
  final BookingManagementRemoteDataSources _remoteDataSources;

  const BookingManagementRepositoryImp(this._remoteDataSources);

  @override
  Future<Either<Failure, List<VisaType>>> getVisaTypes({
    required NoParams params,
  }) async {
    try {
      final result = await _remoteDataSources.getVisaTypes(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<VisaLanguage>>> getActiveLanguages({
    required NoParams params,
  }) async {
    try {
      final result =
          await _remoteDataSources.getActiveLanguages(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<VisaEmployee>>> getVisaEmployees({
    required GetVisaEmployeesParams params,
  }) async {
    try {
      final result = await _remoteDataSources.getVisaEmployees(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CreateVisaResponse>> createVisaRequest({
    required CreateVisaRequestParams params,
  }) async {
    try {
      final result = await _remoteDataSources.createVisaRequest(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CreateVisaResponse>> updateVisaRequest({
    required UpdateVisaRequestParams params,
  }) async {
    try {
      final result = await _remoteDataSources.updateVisaRequest(params: params);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
