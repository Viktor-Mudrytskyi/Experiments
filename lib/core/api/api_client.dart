import 'package:dio/dio.dart';
import 'package:experiments/core/api/api.dart';

class ApiClient {
  const ApiClient({required Dio client}) : _client = client;
  final Dio _client;

  Map<String, dynamic> get defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Future<dynamic> request({
    required ApiMethods method,
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
  }) async {
    late final Response<dynamic> response;

    switch (method) {
      case ApiMethods.get:
        response = await _client.get(
          path,
          queryParameters: queryParameters,
          onReceiveProgress: onReceiveProgress,
          data: data,
          options: Options(headers: headers ?? defaultHeaders),
        );
      case ApiMethods.post:
        response = await _client.post(
          path,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          queryParameters: queryParameters,
          options: Options(headers: headers ?? defaultHeaders),
        );
      case ApiMethods.patch:
        response = await _client.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          options: Options(headers: headers ?? defaultHeaders),
        );
      case ApiMethods.delete:
        response = await _client.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers ?? defaultHeaders),
        );
      case ApiMethods.put:
        response = await _client.put(
          path,
          data: data,
          queryParameters: queryParameters,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          options: Options(headers: headers ?? defaultHeaders),
        );
    }
    return response.data;
  }
}
