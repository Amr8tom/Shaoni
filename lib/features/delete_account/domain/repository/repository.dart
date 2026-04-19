import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecases/base_usecase.dart';

abstract class DeleteAccountRepository {
  Future<Either<Failure, dynamic>> deleteAccount({required NoParams params});
}
