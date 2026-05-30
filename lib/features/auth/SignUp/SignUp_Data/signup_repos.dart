import 'package:course_app/Cash/cache_helper.dart';
import 'package:course_app/core/Apis/Errors/exceptions.dart';
import 'package:course_app/features/auth/SignUp/SignUp_Data/signup_models.dart';
import 'package:course_app/features/auth/SignUp/SignUp_Data/signup_services.dart';
import 'package:dio/dio.dart';

class SignupRepo {
  final SignupServices _services;

  SignupRepo({SignupServices? services})
      : _services = services ?? SignupServices();

  Future<SignupResponse> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await _services.register(
        email: email.trim(),
        password: password,
        firstName: firstName.trim(),
        lastName: lastName.trim(),
      );

      if (response.token.isNotEmpty) {
        await CacheHelper.saveData(key: 'token', value: response.token);
      }

      return response;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }




 
}
