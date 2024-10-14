import 'package:dio/dio.dart';
import 'package:experiments/core/service/logger.dart';

class DioLogger extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger.logError('${err.requestOptions.method} ${err.response?.statusCode} ${err.requestOptions.uri}\n$err');
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.logInfo('${options.method} ${options.uri}\n${options.headers}\n${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    Logger.logSuccess(
      '${response.requestOptions.method} ${response.statusCode} ${response.requestOptions.uri}\n$response',
    );
    super.onResponse(response, handler);
  }
}
