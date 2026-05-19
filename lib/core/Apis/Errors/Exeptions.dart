  import 'package:dio/dio.dart';

String parseError(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      if (data['message'] != null) {
        final msg = data['message'];

        if (msg.toString().isNotEmpty) {
          return msg.toString();
        }
      }

      if (data['errors'] != null && data['errors'] is Map<String, dynamic>) {
        final errors = data['errors'] as Map<String, dynamic>;

        for (final value in errors.values) {
          if (value is List && value.isNotEmpty) {
            return value.first.toString();
          }
        }
      }

      if (data['error'] != null) {
        return data['error'].toString();
      }
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
          
      return 'Connection timeout. Please try again.';
    }

    if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection. Check your network.';
    }

    return 'Something went wrong. Please try again.';
  }