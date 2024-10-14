import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:experiments/core/service/logger.dart';
import 'package:flutter/foundation.dart';

class DioLogger extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!kDebugMode) {
      return;
    }
    Logger.logError('${err.requestOptions.method} ${err.response?.statusCode} ${err.requestOptions.uri}\n$err');
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kDebugMode) {
      return;
    }
    Logger.logInfo(
      '${options.method} ${options.uri}\n${_formatIfJson(options.headers)}\n${_formatIfJson(options.data)}',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (!kDebugMode) {
      return;
    }
    Logger.logSuccess(
      '${response.requestOptions.method} ${response.statusCode} ${response.requestOptions.uri}\n${_formatIfJson(response)}',
    );
    super.onResponse(response, handler);
  }

  String _formatIfJson(Object? data) {
    try {
      final map = jsonDecode(data.toString());
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(map);
    } catch (e) {
      return data.toString();
    }
  }
}
