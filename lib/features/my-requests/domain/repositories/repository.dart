import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/approve_request_model.dart';
import '../entities/all_requests_with_stages.dart';
import '../use_cases/approve_request_use_case.dart';
import '../use_cases/get_all_manager_requests_use_case.dart';
import '../use_cases/get_all_user_requests_use_case.dart';

abstract class MyRequestsRepository{
  /// get
  Future<Either<Failure, AllRequestsWithStages>> getAllUserRequests({required GetAllUserRequestsParams params});
  Future<Either<Failure, AllRequestsWithStages>> getAllManagerRequests({required GetAllManagerRequestsParams params});
  Future<Either<Failure, ApproveRequestModel>> acceptRequest ({required AcceptRequestParams params});
}