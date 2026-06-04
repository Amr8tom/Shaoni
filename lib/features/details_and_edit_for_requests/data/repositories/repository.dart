import 'package:dartz/dartz.dart';
import 'package:shaoni/core/connection/checkNetwork.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/approve_request_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/all_requests_with_stages.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/edit/edit_response.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/request_with_stage.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/approve_request_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_all_manager_requests_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_all_user_requests_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_attendance_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_study_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_start_work_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_experience_certificate_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_id_document_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_medical_insurance_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_training_request_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_product_order_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_outside_working_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_car_permission_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_exit_permission_edit_use_case.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/get_request_details_use_case.dart';
import '../../domain/repositories/repository.dart';
import '../data_sources/local_data_sources.dart';
import '../data_sources/remote_data_sources.dart';

class MyRequestsRepositoryImp extends MyRequestsRepository {
  final MyRequestsRemoteDataSources _remoteDataSources;
  final MyRequestsLocalDataSources _localDataSources;
  final NetworkInfo _networkInfo;

  MyRequestsRepositoryImp(
    this._remoteDataSources,
    this._localDataSources,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, AllRequestsWithStages>> getAllUserRequests({
    required GetAllUserRequestsParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final requests = await _remoteDataSources.getAllUserRequests(
          params: params,
        );
        await _localDataSources.cacheAllMyRequests(requests: requests);
        return Right(requests);
      } on ServerFailure {
        return Left(
          ServerFailure(
            message: ' ===================== Server Failure ===============',
          ),
        );
      }
    } else {
      try {
        final requests = await _localDataSources.getAllMyRequests();
        return Right(requests);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, AllRequestsWithStages>> getAllManagerRequests(
      {required GetAllManagerRequestsParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final requests = await _remoteDataSources.getAllManagerRequests(
          params: params,
        );
        await _localDataSources.cacheAllMyRequestsByManager(requests: requests);
        return Right(requests);
      } on ServerFailure {
        return Left(
          ServerFailure(
            message: ' ===================== Server Failure ===============',
          ),
        );
      }
    } else {
      try {
        final requests = await _localDataSources.getAllMyRequestsByManager();
        return Right(requests);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ApproveRequestModel>> acceptRequest(
      {required AcceptRequestParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSources.acceptRequest(params: params);
        return Right(result);
      } on ServerFailure {
        return Left(ServerFailure(message: "Server Failure"));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, RequestWithStage>> getRequestDetails(
      {required GetRequestDetailsParams params}) async {
    if (await _networkInfo.isConnected) {
      try {
        final requestDetails =
            await _remoteDataSources.getRequestDetails(params: params);
        await _localDataSources.cacheRequestDetails(
            requestDetails: requestDetails);
        return Right(requestDetails);
      } on ServerFailure {
        return Left(
          ServerFailure(
            message: ' ===================== Server Failure ===============',
          ),
        );
      }
    } else {
      return Left(CacheFailure());
    }
  }

  /// ============================ edit ============================

  @override
  Future<Either<Failure, EditResponse>> getCarPermissionEdit({
    required GetCarPermissionEditParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =
            await _remoteDataSources.getCarPermissionEdit(params: params);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, EditResponse>> getExitPermissionEdit({
    required GetExitPermissionEditParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =
            await _remoteDataSources.getExitPermissionEdit(params: params);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, EditResponse>> getAttendanceEdit({
    required GetAttendanceEditParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =
            await _remoteDataSources.getAttendanceEdit(params: params);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, EditResponse>> getStudyEdit({
    required GetStudyEditParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSources.getStudyEdit(params: params);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, EditResponse>> getStartWorkEdit({
    required GetStartWorkEditParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =
            await _remoteDataSources.getStartWorkEdit(params: params);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, EditResponse>> getExperienceCertificateEdit({
    required GetExperienceCertificateEditParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSources.getExperienceCertificateEdit(
            params: params);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, EditResponse>> getIDDocumentEdit({
    required GetIDDocumentEditParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =
            await _remoteDataSources.getIDDocumentEdit(params: params);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, EditResponse>> getMedicalInsuranceEdit({
    required GetMedicalInsuranceEditParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =
            await _remoteDataSources.getMedicalInsuranceEdit(params: params);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, EditResponse>> getTrainingRequestEdit({
    required GetTrainingRequestEditParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =
            await _remoteDataSources.getTrainingRequestEdit(params: params);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, EditResponse>> getProductOrderEdit({
    required GetProductOrderEditParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =
            await _remoteDataSources.getProductOrderEdit(params: params);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, EditResponse>> getOutsideWorkingEdit({
    required GetOutsideWorkingEditParams params,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =
            await _remoteDataSources.getOutsideWorkingEdit(params: params);
        return Right(result);
      } on ServerFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
