// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:bitbust/src/core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiClient {
  // GET method
  Future<dynamic> get(String url, {Map<String, dynamic>? queries, Map<String, dynamic>? headers}) async {
    var responseJson;
    try {
      final response = await _getDio().get(
        url,
        queryParameters: queries,
      );
      responseJson = _returnResponse(response);
    } on DioException catch (e) {
      await _errorParsing(e);
    }
    return responseJson;
  }

  Future<void> _errorParsing(DioException e) async {
    final msg = DataException.fromDioError(e);
    if (e.response == null || e.response!.data == null) {
      throw Exception(msg.message);
    } else {
      throw await processError(e.response!);
    }
  }

  // POST method
  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    var responseJson;

    try {
      final response = await _getDio().post(
        url,
        data: data,
        queryParameters: query,
        options: options,
      );

      responseJson = _returnResponse(response);
    } on DioException catch (e) {
      await _errorParsing(e);
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) async {
    try {
      if (!isResponseOk(response.statusCode!)) {
        throw processError(response);
      }
      if (response.data != null && response.data['data'] != null) {
        return response.data ?? true;
      } else {
        throw processError(response);
      }
    } on DioException catch (e) {
      await _errorParsing(e);
    }
  }

  bool isResponseOk(int statusCode) {
    return statusCode >= 200 && statusCode <= 299;
  }

  dynamic processError(Response response) {
    if (response.data.runtimeType == String) {
      return "Cannot process your request. Try again";
    }
    if (response.data["errors"].runtimeType == List && (response.data["errors"] as List).isNotEmpty) {
      return response.data["errors"];
    }
    try {
      if ((response.data["errors"] as Map).isNotEmpty) {
        return response.data["errors"];
      }
    } catch (e) {
      return response.data["message"] ??
          response.data["error_description"] ??
          response.data["error"] ??
          response.data["status"] ??
          "Server error. Please contact support";
    }
  }

//dammy@gmail.com 44907
  Dio _getDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL'] ?? "",
        connectTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
      ),
    );
    if (kDebugMode) {
      dio.interceptors.addAll([
        AuthInterceptor(),
        LogInterceptor(requestBody: true, responseBody: true),
      ]);
    } else {
      dio.interceptors.addAll([
        AuthInterceptor(),
      ]);
    }
    return dio;
  }
}
