import 'package:course_app/core/Apis/dio_Consumer.dart';
import 'package:course_app/core/Apis/end_point.dart';
import 'package:course_app/core/helper_functions/device_helper.dart';
import 'package:course_app/features/auth/Login/Login_Data/Login_Model.dart';
import 'package:dio/dio.dart';

class LoginServices {
  final DioConsumer _dioConsumer;

  LoginServices({DioConsumer? dioConsumer})
    : _dioConsumer = dioConsumer ?? DioConsumer();

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final deviceId = await DeviceHelper.getDeviceId();

    final response = await _dioConsumer.post(
      EndPoint.teacherLogin,
      queryParameters: {
        'email': email,
        'password': password,
        'device_id': deviceId,
      },
    );

    return LoginResponse.fromJson(response.data as Map<String, dynamic>);
  }

  String parseError(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    if (data is Map && data['error'] != null) {
      return data['error'].toString();
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
}
