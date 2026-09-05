import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';

import '../../entity/start_work/start_work_option.dart';
import '../../repository/repository.dart';

class GetEmployeeContractsUseCase
    extends UseCase<List<StartWorkOption>, GetEmployeeContractsParams> {
  final HRServicesRepository _repository;

  GetEmployeeContractsUseCase(this._repository);

  @override
  Future<Either<Failure, List<StartWorkOption>>> call({
    required GetEmployeeContractsParams params,
  }) async {
    return await _repository.getEmployeeContracts(params: params);
  }
}

class GetEmployeeContractsParams extends Equatable {
  final int employeeId;

  const GetEmployeeContractsParams({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}
