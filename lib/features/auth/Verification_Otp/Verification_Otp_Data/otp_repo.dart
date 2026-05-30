import 'package:course_app/core/Apis/Errors/exceptions.dart';
import 'package:course_app/features/auth/Verification_Otp/Verification_Otp_Data/otp_services.dart';

import 'package:dio/dio.dart';

class OtpRepo {

  final OtpServices _services;

  OtpRepo({
    OtpServices? services,
  }) : _services =
          services ?? OtpServices();

  Future<String> verifyOtp({
    required String token,
    required String otpCode,
  }) async {

    try {

      final message =
          await _services.verifyOtp(
        token: token,
        otpCode: otpCode,
      );

      return message;

    } on DioException catch (e) {

      handleDioException(e);

    }
  }
}