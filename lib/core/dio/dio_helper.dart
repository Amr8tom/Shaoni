import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shaoni/core/local_storage/local_storage.dart';
import 'package:shaoni/core/local_storage/storage_keys.dart';
import '../error/failure.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  final LocalStorage _storage;
  final Dio dio;

  DioHelper(this._storage) : dio = Dio() {
    /// Adding Pretty Dio Logger for debugging
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ),
    );
  }

  String get _token => _storage.getString(key: StorageKeys.token.name) ?? '';

  String get _language =>
      _storage.getString(key: StorageKeys.lang.name) ?? _storage.cachedLanguage;

  Map<String, dynamic> get _headers => {
        "Authorization": "Bearer $_token",
        "App-Language": _language,
      };

  Future getData({
    required String url,
    bool isHeader = true,
    Map<String, dynamic>? data,
  }) async {
    try {
      Response response = await dio.get(
        url,
        options: isHeader
            ? Options(
                headers: _headers,
              )
            : null,
        data: data,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException {
      throw ServerFailure(
        message: '================== server failure =============',
      );
    }
  }

  Future<Map<String, dynamic>?> postData({
    required String url,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    try {
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: _headers,
        ),
      );
      if (response.statusCode == 204 ||
          response.statusCode == 200 ||
          response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 403 ||
          response.statusCode == 401 ||
          response.statusCode == 400) {
        if (response is String) {
          throw ServerFailure.fromString(response.data);
        } else {
          throw ServerFailure.fromMap(response.data);
        }
      } else if (response.statusCode == 400) {
        throw ServerFailure(message: "server failure");
      }
    } on DioException {
      rethrow;
    }
    return null;
  }

  Future<dynamic> postDataWithStringBody({
    required String url,
    String? body,
    String? token,
  }) async {
    try {
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: _headers,
        ),
      );
      if (response.statusCode == 204 ||
          response.statusCode == 200 ||

          ///401 unauthorized
          response.statusCode == 401 ||
          response.statusCode == 400 ||
          response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 403) {
        throw ServerFailure(
          message: '================== server failure =============',
        );
      }
    } on DioException {
      rethrow;
    }
    return null;
  }

  Future<Map<String, dynamic>?> postFormData({
    bool handleError = true,
    required String url,
    FormData? formData,
    String? token,
  }) async {
    try {
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            // 'Content-Type': 'application/json',
            'Content-Type': 'multipart/form-data',
            ..._headers,
          },
        ),
      );
      if (response.statusCode == 204 ||
          response.statusCode == 200 ||
          response.statusCode == 201) {
      } else if (response.statusCode == 403) {
        throw ServerFailure(
          message: '================== server failure =============',
        );
      }
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> postDataWithoutAuth({
    bool handleError = true,
    required String url,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    try {
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          /// validate status option to prevent dio from throwing error automatically and let me handle it
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 204 ||
          response.statusCode == 200 ||
          response.statusCode == 201) {
      } else if (response.statusCode == 403) {
        throw ServerFailure.fromString(response.data);
      } else if (response.statusCode == 401) {
        throw ServerFailure(message: " unauthorized");
      } else if (response.statusCode == 400) {
        throw ValidationFailure.fromMap(response.data);
      }
      return response;
    } on DioException {
      rethrow;
    }
  }

  Future<Response> putData({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    return await dio.put(
      url,
      data: body,
      options: Options(
        headers: _headers,
      ),
    );
  }

  Future<Response> patchData({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    return await dio.patch(
      url,
      data: body,
      options: Options(
        headers: _headers,
      ),
    );
  }

  Future<Response> deleteFromCart({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    return await dio.put(
      url,
      data: body,
      options: Options(
        headers: _headers,
      ),
    );
  }

  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    return await dio.delete(
      url,
      data: body,
      options: Options(
        headers: _headers,
      ),
    );
  }
}
