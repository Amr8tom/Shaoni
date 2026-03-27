import 'package:dartz/dartz.dart';

import 'package:shaoni/core/error/failure.dart';

import 'package:shaoni/features/my-requests/domain/entities/request_with_stage.dart';

import 'package:shaoni/features/my-requests/domain/use_cases/get_all_user_requests_use_case.dart';

import '../../../domain/repositories/repository.dart';

class MyRequestsRepositoryImp extends MyRequestsRepository{
  @override
  Future<Either<Failure, RequestWithStage>> getAllUserRequests({required GetAllUserRequestsParams params}) {
    // TODO: implement getAllUserRequests
    throw UnimplementedError();
  }
}