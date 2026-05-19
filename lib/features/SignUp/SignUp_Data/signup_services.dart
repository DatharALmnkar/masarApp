import 'package:course_app/core/Apis/dio_Consumer.dart';
import 'package:course_app/core/Apis/end_point.dart';
import 'package:course_app/core/helper_functions/device_helper.dart';
import 'package:course_app/features/SignUp/SignUp_Data/signup_models.dart';
import 'package:dio/dio.dart';

class SignupServices {
  final DioConsumer _dioConsumer;

  SignupServices({DioConsumer? dioConsumer})
      : _dioConsumer = dioConsumer ?? DioConsumer();

  Future<SignupResponse> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final deviceId = await DeviceHelper.getDeviceId();

    final response = await _dioConsumer.post(
      EndPoint.teacherRegister,
      queryParameters: {
        'email': email,
        'password': password,
        'device_id': deviceId,
        'First_name': firstName,
        'Last_name': lastName,
      },
    );

    return SignupResponse.fromJson(response.data as Map<String, dynamic>);
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
