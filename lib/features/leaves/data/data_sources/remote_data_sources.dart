import 'dart:convert';

import 'package:shaoni/core/constants/api_constants.dart';
import 'package:shaoni/core/dio/dio_helper.dart';
import 'package:shaoni/core/error/failure.dart';
import 'package:shaoni/core/utils/usecases/base_usecase.dart';
import 'package:shaoni/features/leaves/data/model/leave_interruption/create_leave_interruption_response_model.dart';
import 'package:shaoni/features/leaves/data/model/leave_interruption/employee_leave_model.dart';
import 'package:shaoni/features/leaves/data/model/leave_interruption/interruption_type_model.dart';
import 'package:shaoni/features/leaves/data/model/leave_interruption/leave_type_model.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/create_leave_interruption_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/search_employee_leaves_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_interruption/update_leave_interruption_use_case.dart';
import 'package:shaoni/features/leaves/data/model/leave_replace/create_leave_replace_response_model.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_replace/create_leave_replace_use_case.dart';
import 'package:shaoni/features/leaves/domain/use_cases/leave_replace/update_leave_replace_use_case.dart';

abstract class LeavesRemoteDataSources {
  /// ============================= leave interruption =============================
  Future<List<LeaveTypeModel>> getLeaveTypes({required NoParams params});

  Future<List<InterruptionTypeModel>> getInterruptionTypes(
      {required NoParams params});

  Future<List<EmployeeLeaveModel>> searchEmployeeLeaves({
    required SearchEmployeeLeavesParams params,
  });

  Future<CreateLeaveInterruptionResponseModel> createLeaveInterruption({
    required CreateLeaveInterruptionParams params,
  });

  Future<CreateLeaveInterruptionResponseModel> updateLeaveInterruption({
    required UpdateLeaveInterruptionParams params,
  });

  /// ============================= leave replace =============================
  Future<CreateLeaveReplaceResponseModel> createLeaveReplace({
    required CreateLeaveReplaceParams params,
  });

  Future<CreateLeaveReplaceResponseModel> updateLeaveReplace({
    required UpdateLeaveReplaceParams params,
  });
}

class LeavesRemoteDataSourcesImp implements LeavesRemoteDataSources {
  final DioHelper _dio;

  const LeavesRemoteDataSourcesImp(this._dio);

  /// Dio only auto-decodes JSON when the server sends a JSON content-type.
  /// Some endpoints return the body as a raw string, so decode it here.
  dynamic _decode(dynamic response) => response is String && response.isNotEmpty
      ? jsonDecode(response)
      : response;

  @override
  Future<List<LeaveTypeModel>> getLeaveTypes({required NoParams params}) async {
    try {
      final response = _decode(await _dio.getData(url: URL.getLeaveTypes));
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw = response is List
          ? response
          : (response as Map<String, dynamic>)['data'] as List;
      return raw
          .map((e) => LeaveTypeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<InterruptionTypeModel>> getInterruptionTypes({
    required NoParams params,
  }) async {
    try {
      final response =
          _decode(await _dio.getData(url: URL.getInterruptionLeaveTypes));
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw = response is List
          ? response
          : (response as Map<String, dynamic>)['data'] as List;
      return raw
          .map((e) => InterruptionTypeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<EmployeeLeaveModel>> searchEmployeeLeaves({
    required SearchEmployeeLeavesParams params,
  }) async {
    try {
      final response = _decode(await _dio.getData(
        url: '${URL.searchEmployeeLeaves}?leaveTypeId=${params.leaveTypeId}',
      ));
      if (response == null) throw ServerFailure(message: 'server failure');
      final List raw = response is List
          ? response
          : ((response as Map<String, dynamic>)['body'] ?? response['data'])
              as List;
      return raw
          .map((e) => EmployeeLeaveModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateLeaveInterruptionResponseModel> createLeaveInterruption({
    required CreateLeaveInterruptionParams params,
  }) async {
    try {
      final response = await _dio.postData(
        url: URL.createLeaveInterruption,
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateLeaveInterruptionResponseModel.fromJson(
          _decode(response) as Map<String, dynamic>);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateLeaveInterruptionResponseModel> updateLeaveInterruption({
    required UpdateLeaveInterruptionParams params,
  }) async {
    try {
      final response = await _dio.putData(
        url: '${URL.updateLeaveInterruption}${params.requestId}',
        body: params.data.toMap(),
      );
      return CreateLeaveInterruptionResponseModel.fromJson(
          _decode(response.data) as Map<String, dynamic>);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateLeaveReplaceResponseModel> createLeaveReplace({
    required CreateLeaveReplaceParams params,
  }) async {
    try {
      final response = await _dio.postData(
        url: URL.createLeaveReplace,
        body: params.toMap(),
      );
      if (response == null) throw ServerFailure(message: 'server failure');
      return CreateLeaveReplaceResponseModel.fromJson(
          _decode(response) as Map<String, dynamic>);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<CreateLeaveReplaceResponseModel> updateLeaveReplace({
    required UpdateLeaveReplaceParams params,
  }) async {
    try {
      final response = await _dio.putData(
        url: '${URL.updateLeaveReplace}${params.requestId}',
        body: params.toMap(),
      );
      return CreateLeaveReplaceResponseModel.fromJson(
          _decode(response.data) as Map<String, dynamic>);
    } on ServerFailure catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}
