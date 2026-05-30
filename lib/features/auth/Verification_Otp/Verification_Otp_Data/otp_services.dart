import 'package:course_app/core/Apis/dio_consumer.dart';
import 'package:course_app/core/Apis/end_point.dart';

class OtpServices {
  final DioConsumer _dioConsumer;

  OtpServices({
    DioConsumer? dioConsumer,
  }) : _dioConsumer = dioConsumer ?? DioConsumer();

  Future<String> verifyOtp({
    required String token,
    required String otpCode,
  }) async {
    final response = await _dioConsumer.post(
      EndPoint.verifyOtp,
      queryParameters: {
        'token': token,
        'otp': otpCode,
      },
    );


    return response['message'] ?? 'verified_success';
  }
}