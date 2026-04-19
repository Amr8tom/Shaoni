import 'package:dartz/dartz.dart';
import '../../../../core/connection/checkNetwork.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecases/base_usecase.dart';
import '../../domain/repository/repository.dart';
import '../data_sources/loca_data_sources.dart';
import '../data_sources/remote_data_sources.dart';

class DeleteAccountRepositoryImp implements DeleteAccountRepository {
  final NetworkInfo _networkInfo;
  final DeleteRemoteDataSources _remote;
  final DeleteAccountLocalDataSources _local;

  DeleteAccountRepositoryImp(this._networkInfo, this._remote, this._local);

  @override
  Future<Either<Failure, dynamic>> deleteAccount({required NoParams params}) async {
    if (await _networkInfo.isConnected) {
      final deleteReponse = await _remote.deleteAccount(params: params);
      return right(deleteReponse);
    } else {
      return left(CacheFailure());
    }
  }
}
