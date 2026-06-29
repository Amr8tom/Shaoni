import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../entities/edit/edit_response.dart';
import '../repositories/repository.dart';

class GetTicketBookingEditUseCase
    extends UseCase<EditResponse, GetTicketBookingEditParams> {
  final MyRequestsRepository _repository;

  GetTicketBookingEditUseCase(this._repository);

  @override
  Future<Either<Failure, EditResponse>> call({
    required GetTicketBookingEditParams params,
  }) async {
    return await _repository.getTicketBookingEdit(params: params);
  }
}

class GetTicketBookingEditParams extends Equatable {
  final int requestId;
  final String editReasons;

  const GetTicketBookingEditParams({
    required this.requestId,
    this.editReasons = '',
  });

  Map<String, dynamic> toMap() => {
        'edit_reasons': editReasons,
      };

  @override
  List<Object?> get props => [requestId, editReasons];
}
