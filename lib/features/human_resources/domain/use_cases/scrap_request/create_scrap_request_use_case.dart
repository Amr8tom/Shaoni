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
  final String productName;
  final String lotName;

  const ScrapLineItemParams({
    required this.productId,
    required this.productQty,
    this.lotId,
    this.reason = '',
    this.productName = '',
    this.lotName = '',
  });

  Map<String, dynamic> toMap() => {
        'product_id': productId,
        'product_qty': productQty,
        if (lotId != null) 'lot_id': lotId,
        'reason': reason,
        'product_name': productName,
        'lot_name': lotName,
      };

  @override
  List<Object?> get props =>
      [productId, productQty, lotId, reason, productName, lotName];
}

class CreateScrapRequestParams extends Equatable {
  final int employeeId;
  final int officeId;
  final int departmentId;
  final String requestDate;
  final String state;
  final List<int> custodyIds;
  final int? stockRequestId;
  final int scrapReasonId;
  final List<ScrapLineItemParams> requestLineIds;

  const CreateScrapRequestParams({
    required this.employeeId,
    required this.officeId,
    required this.departmentId,
    required this.requestDate,
    this.state = 'draft',
    required this.custodyIds,
    this.stockRequestId,
    required this.scrapReasonId,
    required this.requestLineIds,
  });

  Map<String, dynamic> toMap() => {
        'employee_id': employeeId,
        'state': state,
        'office_id': officeId,
        'department_id': departmentId,
        'request_date': requestDate,
        'custody_ids': custodyIds,
        if (stockRequestId != null) 'stock_request_id': stockRequestId,
        'scrap_reason_id': scrapReasonId,
        'request_line_ids': requestLineIds.map((item) => item.toMap()).toList(),
      };

  @override
  List<Object?> get props => [
        employeeId,
        officeId,
        departmentId,
        requestDate,
        state,
        custodyIds,
        stockRequestId,
        scrapReasonId,
        requestLineIds,
      ];
}
