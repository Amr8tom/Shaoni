import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../repository/repository.dart';

class DeleteAccountUseCase extends UseCase<dynamic, NoParams> {
  final DeleteAccountRepository _repository;

   DeleteAccountUseCase(this._repository);

  @override
  Future<Either<Failure, dynamic>> call({required NoParams params}) async{
   return await _repository.deleteAccount(params: params);
  }


}

