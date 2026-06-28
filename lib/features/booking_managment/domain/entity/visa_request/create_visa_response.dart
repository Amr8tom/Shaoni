import 'package:equatable/equatable.dart';

/// Domain entity for the response of
/// POST /VisaRequest/create
class CreateVisaResponse extends Equatable {
  final String code;
  final String status;
  final String message;
  final int? visaRequestLocalId;
  final int? visaRequestId;
  final String visaRequestName;

  const CreateVisaResponse({
    this.code = '',
    this.status = '',
    this.message = '',
    this.visaRequestLocalId,
    this.visaRequestId,
    this.visaRequestName = '',
  });

  @override
  List<Object?> get props => [
        code,
        status,
        message,
        visaRequestLocalId,
        visaRequestId,
        visaRequestName,
      ];
}
