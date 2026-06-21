import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/details_and_edit_for_requests/domain/entities/all_requests_with_stages.dart';

import '../repositories/repository.dart';

class GetAllKafeelRequestsUseCase
    extends UseCase<AllRequestsWithStages, GetAllKafeelRequestsParams> {
  final MyRequestsRepository _repository;

  GetAllKafeelRequestsUseCase(this._repository);

  @override
  Future<Either<Failure, AllRequestsWithStages>> call(
      {required GetAllKafeelRequestsParams params}) async {
    return await _repository.getAllKafeelRequests(params: params);
  }
}

class GetAllKafeelRequestsParams extends Equatable {
  final int userId;
  final int pageNumber;
  final int pageSize;

  const GetAllKafeelRequestsParams({
    required this.userId,
    required this.pageNumber,
    required this.pageSize,
  });

  /// toMap
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };
  }

  @override
  List<Object?> get props => [userId, pageNumber, pageSize];
}
