import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

import 'package:shaoni/features/human_resources/domain/entity/car_permission/create_car_permission.dart';

class CreateCarPermissionUseCase
    extends UseCase<CreateCarPermission, CreateCarPermissionParams> {
  HRServicesRepository repository;

  CreateCarPermissionUseCase(this.repository);

  @override
  Future<Either<Failure, CreateCarPermission>> call(
      {required CreateCarPermissionParams params}) async {
    return await repository.createCarPermission(params: params);
  }
}

class CreateCarPermissionParams {
  final int employeeId;
  final int? carBrandId;
  final int? carColorId;
  final int? officeId;
  final String? carNumber;
  final String? date;
  final String? note;
  final String? attachments;
  final String? attachmentsName;

  CreateCarPermissionParams({
    required this.employeeId,
    required this.officeId,
    required this.carBrandId,
    required this.carColorId,
    required this.carNumber,
    required this.date,
    required this.note,
    required this.attachments,
    required this.attachmentsName,
  });

  /// to Map
  Map<String, dynamic> toMap() {
    return {
      'employee_id': employeeId,
      'car_brand_id': carBrandId,
      'car_color_id': carColorId,
      'car_number': carNumber,
      'date': date,
      'note': note,
      'office_id': officeId,
      'attachment_ids': [
        {
          'name': attachmentsName,
          'attachment': attachments,
        }
      ],
    };
  }
}
