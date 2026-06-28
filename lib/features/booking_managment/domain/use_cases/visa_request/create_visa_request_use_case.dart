import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/create_visa_response.dart';
import 'package:shaoni/features/booking_managment/domain/repository/repository.dart';

class CreateVisaRequestUseCase
    extends UseCase<CreateVisaResponse, CreateVisaRequestParams> {
  final BookingManagementRepository _repository;

  CreateVisaRequestUseCase(this._repository);

  @override
  Future<Either<Failure, CreateVisaResponse>> call({
    required CreateVisaRequestParams params,
  }) async {
    return await _repository.createVisaRequest(params: params);
  }
}

class VisaRequestLineParams extends Equatable {
  final int employeeId;
  final String dateFrom;
  final String dateTo;

  const VisaRequestLineParams({
    required this.employeeId,
    required this.dateFrom,
    required this.dateTo,
  });

  Map<String, dynamic> toMap() => {
        'employee_id': employeeId,
        'date_from': dateFrom,
        'date_to': dateTo,
      };

  @override
  List<Object?> get props => [employeeId, dateFrom, dateTo];
}

class CreateVisaRequestParams extends Equatable {
  final int responsibleEmployee;
  final int officeId;
  final int langId;
  final String date;
  final String dateFrom;
  final String dateTo;
  final String direction;
  final String reason;
  final String note;
  final String visaType;
  final String attachment;
  final List<VisaRequestLineParams> visaRequestLineIds;

  const CreateVisaRequestParams({
    required this.responsibleEmployee,
    required this.officeId,
    required this.langId,
    required this.date,
    required this.dateFrom,
    required this.dateTo,
    required this.direction,
    required this.reason,
    this.note = '',
    required this.visaType,
    this.attachment = '',
    required this.visaRequestLineIds,
  });

  Map<String, dynamic> toMap() => {
        'responsible_employee': responsibleEmployee,
        'office_id': officeId,
        'lang_id': langId,
        'date': date,
        'date_from': dateFrom,
        'date_to': dateTo,
        'direction': direction,
        'reason': reason,
        'note': note,
        'visa_type': visaType,
        'attachment': attachment,
        'visa_request_line_ids':
            visaRequestLineIds.map((line) => line.toMap()).toList(),
      };

  @override
  List<Object?> get props => [
        responsibleEmployee,
        officeId,
        langId,
        date,
        dateFrom,
        dateTo,
        direction,
        reason,
        note,
        visaType,
        attachment,
        visaRequestLineIds,
      ];
}
