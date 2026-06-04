import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/all_requests_with_stages.dart';

import '../repositories/repository.dart';

class GetAllManagerRequestsUseCase
    extends UseCase<AllRequestsWithStages, GetAllManagerRequestsParams> {
  final MyRequestsRepository _repository;

  GetAllManagerRequestsUseCase(this._repository);

  @override
  Future<Either<Failure, AllRequestsWithStages>> call(
      {required GetAllManagerRequestsParams params}) async {
    return await _repository.getAllManagerRequests(params: params);
  }
}

class GetAllManagerRequestsParams extends Equatable {
  final int userId;
  final List<int> requestIds;
  final int pageNumber;
  final int pageSize;

  const GetAllManagerRequestsParams({
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
