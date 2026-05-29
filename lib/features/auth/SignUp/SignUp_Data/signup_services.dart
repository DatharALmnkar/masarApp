import 'package:course_app/core/Apis/dio_consumer.dart';
import 'package:course_app/core/Apis/end_point.dart';
import 'package:course_app/core/helper_functions/device_helper.dart';
import 'package:course_app/features/auth/SignUp/SignUp_Data/signup_models.dart';


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








  Future<String> verifyOtp({
    required String token,
    required String otpCode,
  }) async {
    final response = await _dioConsumer.post(
      EndPoint.verifyOtp,
      queryParameters: {'token': token, 'otp': otpCode},
    );

    return response.data['message'] ?? 'Verified successfully';
  }
}
