
import 'package:course_app/Cash/cache_helper.dart';
import 'package:course_app/features/Splash/Splash_Data/Splash_models.dart';

class SplashServices {
  static const String _onBoardingKey = 'onboarding_done';
  static const String _tokenKey = 'token';

  Future<SplashDestination> getDestination() async {
    final onBoardingDone = CacheHelper.getBool(_onBoardingKey) ?? false;
    if (!onBoardingDone) {
      return SplashDestination.onBoarding;
    }

    final token = CacheHelper.getString(_tokenKey);
    if (token == null || token.isEmpty) {
      return SplashDestination.login;
    }

    return SplashDestination.home;
  }
}
