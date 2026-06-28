import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/scrap_request/create_scrap_request_response.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

class CreateScrapRequestUseCase
    extends UseCase<CreateScrapRequestResponse, CreateScrapRequestParams> {
  final HRServicesRepository _repository;

  CreateScrapRequestUseCase(this._repository);

  @override
  Future<Either<Failure, CreateScrapRequestResponse>> call({
    required CreateScrapRequestParams params,
  }) async {
    return await _repository.createScrapRequest(params: params);
  }
}

class ScrapLineItemParams extends Equatable {
  final int productId;
  final int productQty;
  final int? lotId;
  final String reason;

  const ScrapLineItemParams({
    required this.productId,
    required this.productQty,
    this.lotId,
    this.reason = '',
  });

  Map<String, dynamic> toMap() => {
        'product_id': productId,
        'product_qty': productQty,
        if (lotId != null) 'lot_id': lotId,
        'reason': reason,
      };

  @override
  List<Object?> get props => [productId, productQty, lotId, reason];
}

class CreateScrapRequestParams extends Equatable {
  final int employeeId;
  final int officeId;
  final int custodyId;
  final int? stockRequestId;
  final int reasonId;
  final List<ScrapLineItemParams> requestLineIds;

  const CreateScrapRequestParams({
    required this.employeeId,
    required this.officeId,
    required this.custodyId,
    this.stockRequestId,
    required this.reasonId,
    required this.requestLineIds,
  });

  Map<String, dynamic> toMap() => {
        'employee_id': employeeId,
        'office_id': officeId,
        'custody_id': custodyId,
        if (stockRequestId != null) 'stock_request_id': stockRequestId,
        'reason_id': reasonId,
        'request_line_ids':
            requestLineIds.map((item) => item.toMap()).toList(),
      };

  @override
  List<Object?> get props => [
        employeeId,
        officeId,
        custodyId,
        stockRequestId,
        reasonId,
        requestLineIds,
      ];
}
