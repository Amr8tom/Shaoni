import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entity/start_work/create_start_work_response.dart';
import '../../repository/repository.dart';

class CreateStartWorkUseCase
    extends UseCase<CreateStartWorkResponse, CreateStartWorkParams> {
  final HRServicesRepository _repository;

  CreateStartWorkUseCase(this._repository);

  @override
  Future<Either<Failure, CreateStartWorkResponse>> call({
    required CreateStartWorkParams params,
  }) async {
    return await _repository.createStartWorkRequest(params: params);
  }
}

class CreateStartWorkParams {
  final String date;
  final int employee;
  final int managerId;
  final int officeId;
  final String startDate;
  final int typeId;
  final String note;
  final String attachment;
  final String attachmentName;
  final int hrContractId;
  final int upgradeOrderId;
  final int taskManagementId;
  final int holidayStatusId;
  final String employeeTransfer;
  final String jobTitleModification;
  final String endLoanPeriod;
  final String extendEmployeeWorkingPeriod;

  const CreateStartWorkParams({
    required this.date,
    required this.employee,
    required this.managerId,
    required this.officeId,
    required this.startDate,
    required this.typeId,
    this.note = '',
    this.attachment = '',
    this.attachmentName = '',
    this.hrContractId = 0,
    this.upgradeOrderId = 0,
    this.taskManagementId = 0,
    this.holidayStatusId = 0,
    this.employeeTransfer = '',
    this.jobTitleModification = '',
    this.endLoanPeriod = '',
    this.extendEmployeeWorkingPeriod = '',
  });

  Map<String, dynamic> toMap() => {
        'date': date,
        'employee': employee,
        'manager_id': managerId,
        'office_id': officeId,
        'start_date': startDate,
        'type_id': typeId,
        'note': note,
        'attachment_ids': attachment.isEmpty
            ? <Map<String, dynamic>>[]
            : [
                {
                  'name': attachmentName,
                  'attachment': attachment,
                }
              ],
        'hr_contract_id': hrContractId,
        'upgrade_order_id': upgradeOrderId,
        'task_management_id': taskManagementId,
        'holiday_status_id': holidayStatusId,
        'employee_transfer': employeeTransfer,
        'job_title_modification': jobTitleModification,
        'end_loan_period': endLoanPeriod,
        'extend_employee_working_period': extendEmployeeWorkingPeriod,
      };
}
