import 'dart:developer';

import 'package:bitbust/src/core/core.dart';
import 'package:bitbust/src/core/data_storage.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Interceptor to send Bearer access token
class AuthInterceptor extends QueuedInterceptor {
  final _dataStorage = DataStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // unsecure endpoints
    final unsecurePaths = [
      Endpoints.register,
      Endpoints.login,
    ];

    // Update RegExp to match the start of the path
    final unsecurePathsRegex = RegExp('^(${unsecurePaths.map((path) => RegExp.escape(path)).join('|')})');

    // Check if required endpoint match
    if (unsecurePathsRegex.hasMatch(options.path.toString())) {
      // If endpoint matches, skip adding token
      return handler.next(options);
    }

    // Load token and pass to header
    var token = '';

    debugPrint("READ - reading token from cache");
    token = await _dataStorage.read(Constants.token) ?? "";
    options.headers.addAll({
      'Content-type': 'application/json',
      "Accept": "application/json",
      'Authorization': "Bearer $token",
    });

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final dio = Dio();
    if (err.response != null) {
      // logger.severe('${err.response?.data}');
      log(err.response!.statusCode.toString());
      if (err.response?.statusCode == 401) {
        // catch the 401 here
        RequestOptions requestOptions = err.requestOptions;

        //    await refreshToken();
        var accessToken = await _dataStorage.read(Constants.token) ?? "";
        final opts = Options(method: requestOptions.method);
        dio.options.headers["Authorization"] = "Bearer $accessToken";
        dio.options.headers["Accept"] = "*/*";
        final response = await dio.request(
          requestOptions.path,
          options: opts,
          cancelToken: requestOptions.cancelToken,
          onReceiveProgress: requestOptions.onReceiveProgress,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
        );
        handler.resolve(response);
      } else {
        handler.next(err);
      }
    }
    handler.next(err);
  }
}
