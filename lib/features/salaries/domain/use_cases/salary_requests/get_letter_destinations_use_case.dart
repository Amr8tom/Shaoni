import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entity/salary_requests/letter_destination.dart';
import '../../repository/salaries_repository.dart';

class GetLetterDestinationsUseCase {
  final SalariesRepository repository;

  GetLetterDestinationsUseCase(this.repository);

  Future<Either<Failure, List<LetterDestination>>> call() async {
    return await repository.getLetterDestinations();
  }
}
