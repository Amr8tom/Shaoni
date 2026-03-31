import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/all_requests_with_stages.dart';
import '../entities/request_with_stage.dart';
import '../use_cases/get_all_user_requests_use_case.dart';

abstract class MyRequestsRepository{
  /// get
  Future<Either<Failure, AllRequestsWithStages>> getAllUserRequests({required GetAllUserRequestsParams params});
}