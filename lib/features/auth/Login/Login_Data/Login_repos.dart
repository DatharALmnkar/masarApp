import 'package:course_app/Cash/cache_helper.dart';
import 'package:course_app/features/auth/Login/Login_Data/Login_Model.dart';
import 'package:course_app/features/auth/Login/Login_Data/Login_services.dart';
import 'package:dio/dio.dart';

class LoginRepo {
  final LoginServices _services;

  LoginRepo({LoginServices? services})
    : _services = services ?? LoginServices();

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _services.login(
        email: email.trim(),
        password: password,
      );

      if (response.token.isNotEmpty) {
        await CacheHelper.saveData(key: 'token', value: response.token);
      }

      return response;
    } on DioException catch (e) {
      throw _services.parseError(e);
    }
  }
}
