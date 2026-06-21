import 'package:dartz/dartz.dart';
import '../../../../core/connection/check_network.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/loan/create_loan_response.dart';
import '../../domain/entity/loan/kafeel_employee.dart';
import '../../domain/entity/loan/loan_type.dart';
import '../../domain/entity/salary_requests/bank.dart';
import '../../domain/entity/salary_requests/country.dart';
import '../../domain/entity/salary_requests/create_salary_response.dart';
import '../../domain/entity/salary_requests/letter_destination.dart';
import '../../domain/entity/salary_requests/salary_document_type.dart';
import '../../domain/entity/salary_requests/salary_sub_type.dart';
import '../../domain/entity/salary_requests/salary_type.dart';
import '../../domain/repository/salaries_repository.dart';
import '../../domain/use_cases/loan/create_loan_use_case.dart';
import '../../domain/use_cases/loan/edit_loan_use_case.dart';
import '../../domain/use_cases/loan/update_loan_use_case.dart';
import '../../domain/use_cases/salary_requests/create_salary_use_case.dart';
import '../../domain/use_cases/salary_requests/edit_salary_use_case.dart';
import '../../domain/use_cases/salary_requests/get_banks_use_case.dart';
import '../../domain/use_cases/salary_requests/update_salary_use_case.dart';
import '../data_sources/salaries_local_data_source.dart';
import '../data_sources/salaries_remote_data_source.dart';

class SalariesRepositoryImpl implements SalariesRepository {
  final SalariesRemoteDataSource remoteDataSource;
  final SalariesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SalariesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CreateSalaryResponse>> createSalaryRequest({
    required CreateSalaryParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.createSalaryRequest(params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(e);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, CreateSalaryResponse>> updateSalaryRequest({
    required UpdateSalaryParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.updateSalaryRequest(params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(e);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, CreateSalaryResponse>> editSalaryRequest({
    required EditSalaryParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.editSalaryRequest(params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(e);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<SalarySubType>>> getSalarySubTypes() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getSalarySubTypes();
        await localDataSource.cacheSalarySubTypes(remoteData);
        return Right(remoteData);
      } on ServerFailure catch (e) {
        try {
          final localData = await localDataSource.getCachedSalarySubTypes();
          return Right(localData);
        } catch (_) {
          return Left(e);
        }
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localData = await localDataSource.getCachedSalarySubTypes();
        return Right(localData);
      } catch (_) {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<SalaryType>>> getSalaryTypes() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getSalaryTypes();
        await localDataSource.cacheSalaryTypes(remoteData);
        return Right(remoteData);
      } on ServerFailure catch (e) {
        try {
          final localData = await localDataSource.getCachedSalaryTypes();
          return Right(localData);
        } catch (_) {
          return Left(e);
        }
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localData = await localDataSource.getCachedSalaryTypes();
        return Right(localData);
      } catch (_) {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<SalaryDocumentType>>>
      getSalaryDocumentTypes() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getSalaryDocumentTypes();
        await localDataSource.cacheSalaryDocumentTypes(remoteData);
        return Right(remoteData);
      } on ServerFailure catch (e) {
        try {
          final localData =
              await localDataSource.getCachedSalaryDocumentTypes();
          return Right(localData);
        } catch (_) {
          return Left(e);
        }
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localData = await localDataSource.getCachedSalaryDocumentTypes();
        return Right(localData);
      } catch (_) {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Country>>> getCountries() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getCountries();
        await localDataSource.cacheCountries(remoteData);
        return Right(remoteData);
      } on ServerFailure catch (e) {
        try {
          final localData = await localDataSource.getCachedCountries();
          return Right(localData);
        } catch (_) {
          return Left(e);
        }
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localData = await localDataSource.getCachedCountries();
        return Right(localData);
      } catch (_) {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Bank>>> getBanks({
    required GetBanksParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getBanks(params);
        await localDataSource.cacheBanks(remoteData, params.countryId);
        return Right(remoteData);
      } on ServerFailure catch (e) {
        try {
          final localData =
              await localDataSource.getCachedBanks(params.countryId);
          return Right(localData);
        } catch (_) {
          return Left(e);
        }
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localData =
            await localDataSource.getCachedBanks(params.countryId);
        return Right(localData);
      } catch (_) {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<LetterDestination>>>
      getLetterDestinations() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getLetterDestinations();
        await localDataSource.cacheLetterDestinations(remoteData);
        return Right(remoteData);
      } on ServerFailure catch (e) {
        try {
          final localData = await localDataSource.getCachedLetterDestinations();
          return Right(localData);
        } catch (_) {
          return Left(e);
        }
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localData = await localDataSource.getCachedLetterDestinations();
        return Right(localData);
      } catch (_) {
        return const Left(CacheFailure());
      }
    }
  }

  // ── Loan ──
  @override
  Future<Either<Failure, List<KafeelEmployee>>> getKafeelEmployees() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getKafeelEmployees();
        return Right(remoteData);
      } on ServerFailure catch (e) {
        return Left(e);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<LoanType>>> getLoanTypes() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getLoanTypes();
        await localDataSource.cacheLoanTypes(remoteData);
        return Right(remoteData);
      } on ServerFailure catch (e) {
        try {
          final localData = await localDataSource.getCachedLoanTypes();
          return Right(localData);
        } catch (_) {
          return Left(e);
        }
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localData = await localDataSource.getCachedLoanTypes();
        return Right(localData);
      } catch (_) {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, CreateLoanResponse>> createLoanRequest({
    required CreateLoanParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.createLoanRequest(params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(e);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, CreateLoanResponse>> editLoanRequest({
    required EditLoanParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.editLoanRequest(params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(e);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, CreateLoanResponse>> updateLoanRequest({
    required UpdateLoanParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.updateLoanRequest(params);
        return Right(response);
      } on ServerFailure catch (e) {
        return Left(e);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(UnknownFailure());
    }
  }
}
