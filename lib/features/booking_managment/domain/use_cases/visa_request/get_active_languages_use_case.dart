import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_language.dart';
import 'package:shaoni/features/booking_managment/domain/repository/repository.dart';

class GetActiveLanguagesUseCase extends UseCase<List<VisaLanguage>, NoParams> {
  final BookingManagementRepository _repository;

  GetActiveLanguagesUseCase(this._repository);

  @override
  Future<Either<Failure, List<VisaLanguage>>> call({
    required NoParams params,
  }) async {
    return await _repository.getActiveLanguages(params: params);
  }
}
