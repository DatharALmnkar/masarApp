import 'package:dio/dio.dart';

class DioConsumer {
  final Dio _dio;

  DioConsumer({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..sendTimeout = const Duration(seconds: 30);
  }

  Future<Response> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    return _dio.post(url, queryParameters: queryParameters, data: data);
  }
}
