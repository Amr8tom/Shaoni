import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/exit_permission/update_exit_permission.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';

class UpdateExitPermissionUseCase
    extends UseCase<UpdateExitPermission, UpdateExitPermissionParams> {
  final HRServicesRepository repository;

  UpdateExitPermissionUseCase(this.repository);

  @override
  Future<Either<Failure, UpdateExitPermission>> call({
    required UpdateExitPermissionParams params,
  }) async {
    return await repository.updateExitPermission(params: params);
  }
}

class UpdateExitPermissionParams {
  final int requestId;
  final int employeeId;
  final int officeId;
  final int permissionType;
  final String type;
  final String exitDate;
  final int numberOfHours;
  final String? notes;
  final int stageId;
  final String? leavesAttachment;
  final String? leavesAttachmentName;

  UpdateExitPermissionParams({
    required this.requestId,
    required this.employeeId,
    required this.officeId,
    required this.permissionType,
    required this.type,
    required this.exitDate,
    required this.numberOfHours,
    this.notes,
    required this.stageId,
    this.leavesAttachment,
    this.leavesAttachmentName,
  });

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employeeId,
      'office_id': officeId,
      'permission_type': permissionType,
      'type': type,
      'exit_date': exitDate,
      'number_of_hours': numberOfHours,
      'notes': notes,
      'stage_id': stageId,
      'leaves_attachment': leavesAttachment,
      'leaves_attachment_name': leavesAttachmentName,
    };
  }
}
