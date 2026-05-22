import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/human_resoures/domain/entity/medical_insurance/employee_relative.dart';
import 'package:shaoni/features/human_resoures/domain/repository/repository.dart';

class GetEmployeeRelativesUseCase
    extends UseCase<List<EmployeeRelative>, GetEmployeeRelativesParams> {
  final HRServicesRepository _repository;

  GetEmployeeRelativesUseCase(this._repository);

  @override
  Future<Either<Failure, List<EmployeeRelative>>> call({
    required GetEmployeeRelativesParams params,
  }) async {
    return await _repository.getEmployeeRelatives(params: params);
  }
}

class GetEmployeeRelativesParams extends Equatable {
  final int employeeId;

  const GetEmployeeRelativesParams({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}
