import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/product_order/create_product_order_response.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';

class CreateProductOrderUseCase
    extends UseCase<CreateProductOrderResponse, CreateProductOrderParams> {
  final HRServicesRepository _repository;

  CreateProductOrderUseCase(this._repository);

  @override
  Future<Either<Failure, CreateProductOrderResponse>> call({
    required CreateProductOrderParams params,
  }) async {
    return await _repository.createProductOrder(params: params);
  }
}

class RequestLineItemParams extends Equatable {
  final int productId;
  final int productQty;
  final String notes;

  const RequestLineItemParams({
    required this.productId,
    required this.productQty,
    this.notes = '',
  });

  Map<String, dynamic> toMap() => {
        'product_id': productId,
        'product_qty': productQty,
        'notes': notes,
      };

  @override
  List<Object?> get props => [productId, productQty, notes];
}

class CreateProductOrderParams extends Equatable {
  final int employeeId;
  final int officeId;
  final String requestDate;
  final bool isGift;
  final String reason;
  final String note;
  final String type;
  final List<RequestLineItemParams> requestLineIds;

  const CreateProductOrderParams({
    required this.employeeId,
    required this.officeId,
    required this.requestDate,
    this.isGift = false,
    required this.reason,
    this.note = '',
    this.type = 'general',
    required this.requestLineIds,
  });

  Map<String, dynamic> toMap() => {
        'employee_id': employeeId,
        'office_id': officeId,
        'request_date': requestDate,
        'is_gift': isGift,
        'reason': reason,
        'note': note,
        'type': type,
        'request_line_ids':
            requestLineIds.map((item) => item.toMap()).toList(),
      };

  @override
  List<Object?> get props => [
        employeeId,
        officeId,
        requestDate,
        isGift,
        reason,
        note,
        type,
        requestLineIds,
      ];
}
