import 'package:dartz/dartz.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/create_visa_response.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_employee.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_language.dart';
import 'package:shaoni/features/booking_managment/domain/entity/visa_request/visa_type.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/get_visa_employees_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/create_visa_request_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/update_visa_request_use_case.dart';

abstract class BookingManagementRepository {
  /// ============================ visa request ============================
  Future<Either<Failure, List<VisaType>>> getVisaTypes({
    required NoParams params,
  });

  Future<Either<Failure, List<VisaLanguage>>> getActiveLanguages({
    required NoParams params,
  });

  Future<Either<Failure, List<VisaEmployee>>> getVisaEmployees({
    required GetVisaEmployeesParams params,
  });

  Future<Either<Failure, CreateVisaResponse>> createVisaRequest({
    required CreateVisaRequestParams params,
  });

  Future<Either<Failure, CreateVisaResponse>> updateVisaRequest({
    required UpdateVisaRequestParams params,
  });
}
