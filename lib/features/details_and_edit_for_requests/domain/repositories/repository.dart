import 'package:dartz/dartz.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/request_with_stage.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/approve_request_model.dart';
import '../entities/all_requests_with_stages.dart';
import '../entities/edit/edit_response.dart';
import '../use_cases/approve_request_use_case.dart';
import '../use_cases/get_all_manager_requests_use_case.dart';
import '../use_cases/get_all_user_requests_use_case.dart';
import '../use_cases/get_attendance_edit_use_case.dart';
import '../use_cases/get_car_permission_edit_use_case.dart';
import '../use_cases/get_exit_permission_edit_use_case.dart';
import '../use_cases/get_request_details_use_case.dart';
import '../use_cases/get_study_edit_use_case.dart';
import '../use_cases/get_start_work_edit_use_case.dart';
import '../use_cases/get_experience_certificate_edit_use_case.dart';
import '../use_cases/get_id_document_edit_use_case.dart';
import '../use_cases/get_medical_insurance_edit_use_case.dart';

abstract class MyRequestsRepository {
  /// get
  Future<Either<Failure, AllRequestsWithStages>> getAllUserRequests(
      {required GetAllUserRequestsParams params});
  Future<Either<Failure, AllRequestsWithStages>> getAllManagerRequests(
      {required GetAllManagerRequestsParams params});
  Future<Either<Failure, RequestWithStage>> getRequestDetails(
      {required GetRequestDetailsParams params});
  Future<Either<Failure, ApproveRequestModel>> acceptRequest(
      {required AcceptRequestParams params});

  /// ============================ edit ============================
  Future<Either<Failure, EditResponse>> getCarPermissionEdit({
    required GetCarPermissionEditParams params,
  });

  Future<Either<Failure, EditResponse>> getExitPermissionEdit({
    required GetExitPermissionEditParams params,
  });

  Future<Either<Failure, EditResponse>> getAttendanceEdit({
    required GetAttendanceEditParams params,
  });

  Future<Either<Failure, EditResponse>> getStudyEdit({
    required GetStudyEditParams params,
  });

  Future<Either<Failure, EditResponse>> getStartWorkEdit({
    required GetStartWorkEditParams params,
  });

  Future<Either<Failure, EditResponse>> getExperienceCertificateEdit({
    required GetExperienceCertificateEditParams params,
  });

  Future<Either<Failure, EditResponse>> getIDDocumentEdit({
    required GetIDDocumentEditParams params,
  });

  Future<Either<Failure, EditResponse>> getMedicalInsuranceEdit({
    required GetMedicalInsuranceEditParams params,
  });
}
