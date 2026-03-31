import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/my-requests/domain/entities/all_requests_with_stages.dart';

import '../repositories/repository.dart';

class GetAllUserRequestsUseCase extends UseCase<AllRequestsWithStages,GetAllUserRequestsParams>{
  final MyRequestsRepository _repository;

  GetAllUserRequestsUseCase(this._repository);

  @override
  Future<Either<Failure, AllRequestsWithStages>> call({required GetAllUserRequestsParams params}) async
  {
    return await _repository.getAllUserRequests(params: params);
  }
}




class GetAllUserRequestsParams extends Equatable {
  final int userId;
  final List<int> requestIds;
  final int pageNumber;
  final int pageSize;

  const GetAllUserRequestsParams({
    required this.userId,
    required this.requestIds,
    required this.pageNumber,
    required this.pageSize,
  });
  /// toMap
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'requestIds': requestIds,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };
  }

  @override
  List<Object?> get props => [userId, requestIds, pageNumber, pageSize];

}