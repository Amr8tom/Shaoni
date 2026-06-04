import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/approve_request.dart';

import '../repositories/repository.dart';

class ApproveRequestUseCase
    extends UseCase<ApproveRequest, AcceptRequestParams> {
  final MyRequestsRepository _repository;

  ApproveRequestUseCase(this._repository);

  @override
  Future<Either<Failure, ApproveRequest>> call(
      {required AcceptRequestParams params}) async {
    return await _repository.acceptRequest(params: params);
  }
}

class AcceptRequestParams extends Equatable {
  final int id;
  final int statusCode;
  final String comment;

  const AcceptRequestParams(
      {required this.id, required this.statusCode, required this.comment});

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'statusCode': statusCode,
      'comment': comment,
    };
  }

  @override
  List<Object?> get props => [id, statusCode, comment];
}
