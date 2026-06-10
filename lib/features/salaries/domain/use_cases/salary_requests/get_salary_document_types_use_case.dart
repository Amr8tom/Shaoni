import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/salary_requests/salary_document_type.dart';
import '../../repository/salaries_repository.dart';

class GetSalaryDocumentTypesUseCase {
  final SalariesRepository repository;

  GetSalaryDocumentTypesUseCase(this.repository);

  Future<Either<Failure, List<SalaryDocumentType>>> call() async {
    return await repository.getSalaryDocumentTypes();
  }
}
