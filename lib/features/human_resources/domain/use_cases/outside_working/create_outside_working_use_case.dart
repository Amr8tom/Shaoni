import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resources/domain/entity/outside_working/create_outside_working_response.dart';
import 'package:shaoni/features/human_resources/domain/repository/repository.dart';

class CreateOutsideWorkingUseCase
    extends UseCase<CreateOutsideWorkingResponse, CreateOutsideWorkingParams> {
  final HRServicesRepository _repository;

  CreateOutsideWorkingUseCase(this._repository);

  @override
  Future<Either<Failure, CreateOutsideWorkingResponse>> call(
      {required CreateOutsideWorkingParams params}) async {
    return await _repository.createOutsideWorking(params: params);
  }
}

class OutWorkingLine extends Equatable {
  final int employee;
  final bool includeWeekend;
  final bool exceptionRequest;
  final String tasks;
  final String privateTasks;

  const OutWorkingLine({
    required this.employee,
    required this.includeWeekend,
    required this.exceptionRequest,
    required this.tasks,
    required this.privateTasks,
  });

  Map<String, dynamic> toMap() => {
        'employee': employee,
        'include_weekend': includeWeekend,
        'Exception_request': exceptionRequest,
        'tasks': tasks,
        'private_tasks': privateTasks,
      };

  @override
  List<Object?> get props =>
      [employee, includeWeekend, exceptionRequest, tasks, privateTasks];
}

class CreateOutsideWorkingParams extends Equatable {
  final int employeeId;
  final int officeId;
  final String date;
  final String orderReason;
  final String departmentType;
  final String projectType;
  final List<int> projectName;
  final List<int> employeeIds;
  final String startDate;
  final String endDate;
  final bool includeWeekend;
  final String attendanceWay;
  final List<OutWorkingLine> outWorkingLines;

  const CreateOutsideWorkingParams({
    required this.employeeId,
    required this.officeId,
    required this.date,
    required this.orderReason,
    required this.departmentType,
    required this.projectType,
    required this.projectName,
    required this.employeeIds,
    required this.startDate,
    required this.endDate,
    required this.includeWeekend,
    required this.attendanceWay,
    required this.outWorkingLines,
  });

  Map<String, dynamic> toMap() => {
        'date': date,
        'applicant_for_assignment_id': employeeId,
        'office_id': officeId,
        'order_reason': orderReason,
        'department_type': departmentType,
        'project_type': projectType,
        'project_name': projectName,
        'employee_ids': employeeIds,
        'start_date': startDate,
        'end_date': endDate,
        'include_weekend': includeWeekend,
        'attendance_way': attendanceWay,
        'out_working_lines': outWorkingLines.map((l) => l.toMap()).toList(),
      };

  @override
  List<Object?> get props => [
        employeeId,
        officeId,
        date,
        orderReason,
        departmentType,
        projectType,
        projectName,
        employeeIds,
        startDate,
        endDate,
        includeWeekend,
        attendanceWay,
        outWorkingLines,
      ];
}
