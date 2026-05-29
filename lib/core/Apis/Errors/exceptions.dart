import 'package:dio/dio.dart';
import 'error_model.dart';


class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}

Never handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      throw ServerException(
        errorModel: ErrorModel(
          message: 'Connection timeout. Please try again.',
        ),
      );

    case DioExceptionType.connectionError:
      throw ServerException(
        errorModel: ErrorModel(
          message: 'No internet connection. Check your network.',
        ),
      );

    case DioExceptionType.badResponse:
      if (e.response?.data != null &&
          e.response?.data is Map<String, dynamic>) {
        throw ServerException(
          errorModel: ErrorModel.fromJson(e.response!.data),
        );
      }

      throw ServerException(
        errorModel: ErrorModel(
          message:
              'Bad response from server. Status code: ${e.response?.statusCode}',
        ),
      );

    default:
      throw ServerException(
        errorModel: ErrorModel(
          message: 'Something went wrong. Please try again.',
        ),
      );
  }
}