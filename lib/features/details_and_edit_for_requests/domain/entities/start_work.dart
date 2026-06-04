import 'package:equatable/equatable.dart';

class StartWork extends Equatable {
  final String? externalName;
  final String? date;
  final String? startDate;
  final int? typeId;
  final String? typeName;
  final int? employeeId;
  final int? managerId;
  final String? managerName;
  final String? note;
  final String? attachment;
  final String? state;
  final String? editReasons;
  final String? rejectReasons;

  const StartWork({
    this.externalName,
    this.date,
    this.startDate,
    this.typeId,
    this.typeName,
    this.employeeId,
    this.managerId,
    this.managerName,
    this.note,
    this.attachment,
    this.state,
    this.editReasons,
    this.rejectReasons,
  });

  @override
  List<Object?> get props => [
        externalName,
        date,
        startDate,
        typeId,
        typeName,
        employeeId,
        managerId,
        managerName,
        note,
        attachment,
        state,
        editReasons,
        rejectReasons,
      ];
}
