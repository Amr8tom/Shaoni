import 'package:equatable/equatable.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

// class GetUserRequestsUseCase extends UseCase<> {}


class GetUserRequestParams extends Equatable {
  final int? employeeId;
  final int? permissionType;
  final String? type;
  final String? exitDate;
  final int? numberOfHours;
  final String? notes;
  final int? stageId;
  final String? leavesAttachment;
  final String? leavesAttachmentName;

  const GetUserRequestParams(
      {required this.employeeId,
      required this.permissionType,
      required this.type,
      required this.exitDate,
      required this.numberOfHours,
      required this.notes,
      required this.stageId,
      required this.leavesAttachment,
      required this.leavesAttachmentName});

  @override
  List<Object?> get props =>
       [
        employeeId,
        permissionType,
        type,
        exitDate,
        numberOfHours,
        notes,
        stageId,
        leavesAttachment,
        leavesAttachmentName
      ];

}