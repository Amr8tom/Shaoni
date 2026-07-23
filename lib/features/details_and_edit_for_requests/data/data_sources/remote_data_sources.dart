import 'package:shaoni/core/constants/api_constants.dart';
import 'package:shaoni/core/dio/dio_helper.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/all_requests_with_stages_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/data/models/request_with_stage_model.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/use_cases/approve_request_use_case.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/use_cases/get_all_kafeel_requests_use_case.dart';
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
import '../../domain/use_cases/get_product_order_edit_use_case.dart';
import '../../domain/use_cases/get_outside_working_edit_use_case.dart';
import '../../domain/use_cases/get_salary_transfer_edit_use_case.dart';
import '../../domain/use_cases/get_loan_edit_use_case.dart';
import '../../domain/use_cases/get_scrap_request_edit_use_case.dart';
import '../../domain/use_cases/get_visa_request_edit_use_case.dart';
import '../../domain/use_cases/get_ticket_booking_edit_use_case.dart';
import '../../domain/use_cases/get_leave_interruption_edit_use_case.dart';
import '../../domain/use_cases/outside_working_line_action_use_case.dart';
import '../models/outside_working_line_action_response_model.dart';
import '../../domain/use_cases/get_outside_working_requests_use_case.dart';
import '../../domain/use_cases/get_leave_replace_edit_use_case.dart';
import '../models/approve_request_model.dart';
import '../models/edit_response_model.dart';

abstract class MyRequestsRemoteDataSources {
  Future<AllRequestsWithStagesModel> getAllUserRequests({
    required GetAllUserRequestsParams params,
  });

  Future<RequestWithStageModel> getRequestDetails(
      {required GetRequestDetailsParams params});

  Future<AllRequestsWithStagesModel> getAllManagerRequests({
    required GetAllManagerRequestsParams params,
  });

  Future<AllRequestsWithStagesModel> getAllKafeelRequests({
    required GetAllKafeelRequestsParams params,
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

  Future<EditResponseModel> getProductOrderEdit({
    required GetProductOrderEditParams params,
  });

  Future<EditResponseModel> getOutsideWorkingEdit({
    required GetOutsideWorkingEditParams params,
  });

  Future<EditResponseModel> getSalaryTransferEdit({
    required GetSalaryTransferEditParams params,
  });

  Future<EditResponseModel> getLoanEdit({
    required GetLoanEditParams params,
  });

  Future<EditResponseModel> getScrapRequestEdit({
    required GetScrapRequestEditParams params,
  });

  Future<EditResponseModel> getVisaRequestEdit({
    required GetVisaRequestEditParams params,
  });

  Future<EditResponseModel> getTicketBookingEdit({
    required GetTicketBookingEditParams params,
  });

  Future<EditResponseModel> getLeaveInterruptionEdit({
    required GetLeaveInterruptionEditParams params,
  });

  Future<EditResponseModel> getLeaveReplaceEdit({
    required GetLeaveReplaceEditParams params,
  });

  Future<OutsideWorkingLineActionResponseModel> outsideWorkingLineAction({
    required OutsideWorkingLineActionParams params,
  });

  Future<AllRequestsWithStagesModel> getOutsideWorkingRequests({
    required GetOutsideWorkingRequestsParams params,
  });
}

class MyRequestsRemoteDataSourcesImp implements MyRequestsRemoteDataSources {
  final DioHelper _dio;

  const MyRequestsRemoteDataSourcesImp(this._dio);

  @override
  Future<AllRequestsWithStagesModel> getAllUserRequests({
    required GetAllUserRequestsParams params,
  }) async {
    try {
      final response = await _dio.postData(
        url: URL.getAllRequestsWithStages,
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return AllRequestsWithStagesModel.fromJson(response);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<AllRequestsWithStagesModel> getAllManagerRequests(
      {required GetAllManagerRequestsParams params}) async {
    try {
      final response = await _dio.postData(
        url: URL.getAllRequestsWithStagesByManager,
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return AllRequestsWithStagesModel.fromJson(response);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<AllRequestsWithStagesModel> getAllKafeelRequests({
    required GetAllKafeelRequestsParams params,
  }) async {
    try {
      final response = await _dio.postData(
        url: URL.getAllRequestsWithStagesByKafeel,
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return AllRequestsWithStagesModel.fromJson(response);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<ApproveRequestModel> acceptRequest(
      {required AcceptRequestParams params}) async {
    try {
      final response = await _dio.putData(
          url: '${URL.approveRequest}${params.id}', body: params.toJson());
      return ApproveRequestModel.fromJson(response.data);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<RequestWithStageModel> getRequestDetails(
      {required GetRequestDetailsParams params}) async {
    try {
      final response = await _dio.getData(
        url: '${URL.getRequestDetailsStages}${params.requestId}/with-stages',
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return RequestWithStageModel.fromJson(response);
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
        url: '${URL.getCarPermissionEdit}${params.requestId}',
        body: params.toMap(),
      );
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
        url: '${URL.getExitPermissionEdit}${params.requestId}',
        body: params.toMap(),
      );
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
        url: '${URL.getAttendanceEdit}${params.requestId}',
        body: params.toMap(),
      );
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
        url: '${URL.getStudyEdit}${params.requestId}',
        body: params.toMap(),
      );
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
        url: '${URL.getStartWorkEdit}${params.requestId}',
        body: params.toMap(),
      );
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
        url: '${URL.getExperienceCertificateEdit}${params.requestId}',
        body: params.toMap(),
      );
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
        url: '${URL.getIDDocumentEdit}${params.requestId}',
        body: params.toMap(),
      );
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
        url: '${URL.getMedicalInsuranceEdit}${params.requestId}',
        body: params.toMap(),
      );
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
        url: '${URL.getTrainingRequestEdit}${params.requestId}',
        body: params.toMap(),
      );
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getProductOrderEdit({
    required GetProductOrderEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        url: '${URL.getProductOrderEdit}${params.requestId}',
        body: params.toMap(),
      );
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getOutsideWorkingEdit({
    required GetOutsideWorkingEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        url: '${URL.updateOutsideWorking}${params.requestId}',
        body: params.toMap(),
      );
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getSalaryTransferEdit({
    required GetSalaryTransferEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        url: '${URL.getSalaryRequestEdit}${params.requestId}',
        body: params.toMap(),
      );
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getLoanEdit({
    required GetLoanEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        url: '${URL.editLoanRequest}${params.requestId}',
        body: params.toMap(),
      );
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getScrapRequestEdit({
    required GetScrapRequestEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        url: '${URL.getScrapRequestEdit}${params.requestId}',
        body: params.toMap(),
      );
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getVisaRequestEdit({
    required GetVisaRequestEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        url: '${URL.getVisaRequestEdit}${params.requestId}',
        body: params.toMap(),
      );
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getTicketBookingEdit({
    required GetTicketBookingEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        url: '${URL.getTicketBookingEdit}${params.requestId}',
        body: params.toMap(),
      );
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getLeaveInterruptionEdit({
    required GetLeaveInterruptionEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        url: '${URL.getLeaveInterruptionEdit}${params.requestId}',
        body: params.toMap(),
      );
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<EditResponseModel> getLeaveReplaceEdit({
    required GetLeaveReplaceEditParams params,
  }) async {
    try {
      final response = await _dio.putData(
        url: '${URL.getLeaveReplaceEdit}${params.requestId}',
        body: params.toMap(),
      );
      return EditResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<OutsideWorkingLineActionResponseModel> outsideWorkingLineAction({
    required OutsideWorkingLineActionParams params,
  }) async {
    try {
      final response = await _dio.postData(
        url: '${URL.outsideWorkingLineAction}${params.lineId}',
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return OutsideWorkingLineActionResponseModel.fromJson(response);
    } on ServerFailure {
      rethrow;
    }
  }

  @override
  Future<AllRequestsWithStagesModel> getOutsideWorkingRequests({
    required GetOutsideWorkingRequestsParams params,
  }) async {
    try {
      final response = await _dio.postData(
        url: URL.getOutsideWorkingRequests,
        body: params.toMap(),
      );
      if (response == null) {
        throw ServerFailure(message: 'Null response from server');
      }
      return AllRequestsWithStagesModel.fromJson(response);
    } on ServerFailure {
      rethrow;
    }
  }
}
