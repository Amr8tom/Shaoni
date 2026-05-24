import 'package:shaoni/core/constants/api_constants.dart';
import 'package:shaoni/core/dio/dio_helper.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/all_requests_with_stages.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/request_with_stage.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/approve_request_use_case.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/use_cases/get_all_manager_requests_use_case.dart';
import '../../domain/use_cases/get_all_user_requests_use_case.dart';
import '../../domain/use_cases/get_attendance_edit_use_case.dart';
import '../../domain/use_cases/get_car_permission_edit_use_case.dart';
import '../../domain/use_cases/get_exit_permission_edit_use_case.dart';
import '../../domain/use_cases/get_request_details_use_case.dart';
import '../../domain/use_cases/get_study_edit_use_case.dart';
import '../../domain/use_cases/get_start_work_edit_use_case.dart';
import '../../domain/use_cases/get_experience_certificate_edit_use_case.dart';
import '../../domain/use_cases/get_id_document_edit_use_case.dart';
import '../../domain/use_cases/get_medical_insurance_edit_use_case.dart';
import '../../domain/use_cases/get_training_request_edit_use_case.dart';
import '../models/approve_request_model.dart';
import '../models/edit_response_model.dart';

abstract class MyRequestsRemoteDataSources {
  Future<AllRequestsWithStages> getAllUserRequests({
    required GetAllUserRequestsParams params,
  });

  Future<RequestWithStage> getRequestDetails(
      {required GetRequestDetailsParams params});

  Future<AllRequestsWithStages> getAllManagerRequests({
    required GetAllManagerRequestsParams params,
  });

  Future<ApproveRequestModel> acceptRequest({
    required AcceptRequestParams params,
  });

  /// ============================ edit ============================
  Future<EditResponseModel> getCarPermissionEdit({
    required GetCarPermissionEditParams params,
  });

  Future<EditResponseModel> getExitPermissionEdit({
    required GetExitPermissionEditParams params,
  });

  Future<EditResponseModel> getAttendanceEdit({
    required GetAttendanceEditParams params,
  });

  Future<EditResponseModel> getStudyEdit({
    required GetStudyEditParams params,
  });

  Future<EditResponseModel> getStartWorkEdit({
    required GetStartWorkEditParams params,
  });

  Future<EditResponseModel> getExperienceCertificateEdit({
    required GetExperienceCertificateEditParams params,
  });

  Future<EditResponseModel> getIDDocumentEdit({
    required GetIDDocumentEditParams params,
  });

  Future<EditResponseModel> getMedicalInsuranceEdit({
    required GetMedicalInsuranceEditParams params,
  });

  Future<EditResponseModel> getTrainingRequestEdit({
    required GetTrainingRequestEditParams params,
  });
}

class MyRequestsRemoteDataSourcesImp implements MyRequestsRemoteDataSources {
  final DioHelper _dio;

  const MyRequestsRemoteDataSourcesImp(this._dio);

  @override
  Future<AllRequestsWithStages> getAllUserRequests({
    required GetAllUserRequestsParams params,
  }) async {
    try {
      final response = await _dio.postData(
        URL: URL.getAllRequestsWithStages,
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return AllRequestsWithStages.fromJson(response);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<AllRequestsWithStages> getAllManagerRequests(
      {required GetAllManagerRequestsParams params}) async {
    try {
      final response = await _dio.postData(
        URL: URL.getAllRequestsWithStagesByManager,
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return AllRequestsWithStages.fromJson(response);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<ApproveRequestModel> acceptRequest(
      {required AcceptRequestParams params}) async {
    try {
      final response = await _dio.putData(
          URL: '${URL.approveRequest}${params.id}', body: params.toJson());
      return ApproveRequestModel.fromJson(response.data);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<RequestWithStage> getRequestDetails(
      {required GetRequestDetailsParams params}) async {
    try {
      final response = await _dio.getData(
        URL: URL.getRequestDetailsStages +
            params.requestId.toString() +
            '/with-stages',
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return RequestWithStage.fromJson(response);
    } on ServerFailure {
      rethrow;
    }
  }

  /// ============================ edit ============================

  @override
  Future<EditResponseModel> getCarPermissionEdit({
    required GetCarPermissionEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.getCarPermissionEdit}${params.requestId}',
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getExitPermissionEdit({
    required GetExitPermissionEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.getExitPermissionEdit}${params.requestId}',
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getAttendanceEdit({
    required GetAttendanceEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.getAttendanceEdit}${params.requestId}',
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getStudyEdit({
    required GetStudyEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.getStudyEdit}${params.requestId}',
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getStartWorkEdit({
    required GetStartWorkEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.getStartWorkEdit}${params.requestId}',
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getExperienceCertificateEdit({
    required GetExperienceCertificateEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.getExperienceCertificateEdit}${params.requestId}',
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getIDDocumentEdit({
    required GetIDDocumentEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.getIDDocumentEdit}${params.requestId}',
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getMedicalInsuranceEdit({
    required GetMedicalInsuranceEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.getMedicalInsuranceEdit}${params.requestId}',
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getTrainingRequestEdit({
    required GetTrainingRequestEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        URL: '${URL.getTrainingRequestEdit}${params.requestId}',
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }
}
