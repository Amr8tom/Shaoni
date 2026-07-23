import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/all_requests_with_stages.dart';

import '../repositories/repository.dart';

/// Paged outside-working requests for the logged-in user's grid.
class GetOutsideWorkingRequestsUseCase
    extends UseCase<AllRequestsWithStages, GetOutsideWorkingRequestsParams> {
  final MyRequestsRepository _repository;

  GetOutsideWorkingRequestsUseCase(this._repository);

  @override
  Future<Either<Failure, AllRequestsWithStages>> call({
    required GetOutsideWorkingRequestsParams params,
  }) async {
    return await _repository.getOutsideWorkingRequests(params: params);
  }
}

class GetOutsideWorkingRequestsParams extends Equatable {
  final int userId;
  final int pageNumber;
  final int pageSize;

  const GetOutsideWorkingRequestsParams({
    required this.userId,
    this.pageNumber = 1,
    this.pageSize = 300,
  });

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      };

  @override
  List<Object?> get props => [userId, pageNumber, pageSize];
}
