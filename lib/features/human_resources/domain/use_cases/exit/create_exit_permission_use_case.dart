import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/exit_permisstion.dart';

import '../../repository/repository.dart';

class CreateExitPermissionUseCase
    extends UseCase<ExitPermission, CreateExitPermissionParams> {
  final HRServicesRepository _repository;

  CreateExitPermissionUseCase(this._repository);

  @override
  Future<Either<Failure, ExitPermission>> call({
    required CreateExitPermissionParams params,
  }) async {
    return await _repository.createExitPermission(params: params);
  }
}

class CreateExitPermissionParams extends Equatable {
  final int employeeId;
  final int permissionType;
  final int officeID;
  final String type;
  final String exitDate;
  final int numberOfHours;
  final String? notes;
  final int stageId;
  final String? leavesAttachment;
  final String? leavesAttachmentName;

  const CreateExitPermissionParams({
    required this.employeeId,
    required this.officeID,
    required this.permissionType,
    required this.type,
    required this.exitDate,
    required this.numberOfHours,
    this.notes,
    required this.stageId,
    this.leavesAttachment,
    this.leavesAttachmentName,
  });

  ///  to map
  Map<String, dynamic> toMap() {
    return {
      "employee_id": employeeId,
      "permission_type": permissionType,
      "office_id": officeID,
      "type": type,
      "exit_date": exitDate,
      "number_of_hours": numberOfHours,
      "notes": notes,
      "stage_id": 0,
      "leaves_attachment": leavesAttachment,
      "leaves_attachment_name": leavesAttachmentName
    };
  }

  @override
  List<Object?> get props => [
        employeeId,
        permissionType,
        type,
        exitDate,
        numberOfHours,
        notes,
        stageId,
        leavesAttachment,
        leavesAttachmentName,
      ];
}
