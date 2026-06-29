import 'package:shaoni/core/constants/api_constants.dart';
import 'package:shaoni/core/dio/dio_helper.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/booking_managment/data/model/ticket_booking/create_ticket_booking_response_model.dart';
import 'package:shaoni/features/booking_managment/data/model/ticket_booking/ticket_class_model.dart';
import 'package:shaoni/features/booking_managment/data/model/visa_request/create_visa_response_model.dart';
import 'package:shaoni/features/booking_managment/data/model/visa_request/visa_employee_model.dart';
import 'package:shaoni/features/booking_managment/data/model/visa_request/visa_language_model.dart';
import 'package:shaoni/features/booking_managment/data/model/visa_request/visa_type_model.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/ticket_booking/create_ticket_booking_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/ticket_booking/update_ticket_booking_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/get_visa_employees_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/create_visa_request_use_case.dart';
import 'package:shaoni/features/booking_managment/domain/use_cases/visa_request/update_visa_request_use_case.dart';

abstract class BookingManagementRemoteDataSources {
  /// ============================= visa request =============================
  Future<List<VisaTypeModel>> getVisaTypes({required NoParams params});

  Future<List<VisaLanguageModel>> getActiveLanguages(
      {required NoParams params});

  Future<List<VisaEmployeeModel>> getVisaEmployees({
    required GetVisaEmployeesParams params,
  });

  Future<CreateVisaResponseModel> createVisaRequest({
    required CreateVisaRequestParams params,
  });

  Future<CreateVisaResponseModel> updateVisaRequest({
    required UpdateVisaRequestParams params,
  });

  /// ============================= ticket booking =============================
  Future<List<TicketClassModel>> getTicketTypes({required NoParams params});

  Future<List<VisaEmployeeModel>> getTicketEmployees(
      {required NoParams params});

  Future<CreateTicketBookingResponseModel> createTicketBooking({
    required CreateTicketBookingParams params,
  });

  Future<CreateTicketBookingResponseModel> updateTicketBooking({
    required UpdateTicketBookingParams params,
  });
}

class BookingManagementRemoteDataSourcesImp
    implements BookingManagementRemoteDataSources {
  final DioHelper _dio;

  const BookingManagementRemoteDataSourcesImp(this._dio);

  @override
  Future<List<VisaTypeModel>> getVisaTypes({required NoParams params}) async {
    try {
      final response = await _dio.getData(url: URL.getVisaTypes);
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw = response is List
          ? response
          : (response as Map<String, dynamic>)['data'] as List;
      return raw
          .map((e) => VisaTypeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<VisaLanguageModel>> getActiveLanguages({
    required NoParams params,
  }) async {
    try {
      final response = await _dio.getData(url: URL.getActiveLanguages);
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw = response is List
          ? response
          : (response as Map<String, dynamic>)['data'] as List;
      return raw
          .map((e) => VisaLanguageModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<VisaEmployeeModel>> getVisaEmployees({
    required GetVisaEmployeesParams params,
  }) async {
    try {
      final response = await _dio.getData(
        url: '${URL.syncEmployees}?isSaudi=${params.isSaudi}',
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw = response is List
          ? response
          : (response as Map<String, dynamic>)['data'] as List;
      return raw
          .map((e) => VisaEmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateVisaResponseModel> createVisaRequest({
    required CreateVisaRequestParams params,
  }) async {
    try {
      final response = await _dio.postData(
        url: URL.createVisaRequest,
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateVisaResponseModel.fromJson(response);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateVisaResponseModel> updateVisaRequest({
    required UpdateVisaRequestParams params,
  }) async {
    try {
      final response = await _dio.putData(
        url: '${URL.updateVisaRequest}${params.requestId}',
        body: params.data.toMap(),
      );
      return CreateVisaResponseModel.fromJson(
          response.data as Map<String, dynamic>);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  // ── Ticket booking ─────────────────────────────────────────────────────────

  @override
  Future<List<TicketClassModel>> getTicketTypes({
    required NoParams params,
  }) async {
    try {
      final response = await _dio.getData(url: URL.getTravelTicketTypes);
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw = response is List
          ? response
          : (response as Map<String, dynamic>)['data'] as List;
      return raw
          .map((e) => TicketClassModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<VisaEmployeeModel>> getTicketEmployees({
    required NoParams params,
  }) async {
    try {
      final response = await _dio.getData(url: URL.syncEmployees);
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw = response is List
          ? response
          : (response as Map<String, dynamic>)['data'] as List;
      return raw
          .map((e) => VisaEmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateTicketBookingResponseModel> createTicketBooking({
    required CreateTicketBookingParams params,
  }) async {
    try {
      final response = await _dio.postData(
        url: URL.createTicketBooking,
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateTicketBookingResponseModel.fromJson(response);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateTicketBookingResponseModel> updateTicketBooking({
    required UpdateTicketBookingParams params,
  }) async {
    try {
      final response = await _dio.putData(
        url: '${URL.updateTicketBooking}${params.requestId}',
        body: params.data.toMap(),
      );
      return CreateTicketBookingResponseModel.fromJson(
          response.data as Map<String, dynamic>);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}
