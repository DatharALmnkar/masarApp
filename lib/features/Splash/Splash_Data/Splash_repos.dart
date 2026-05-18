import 'package:course_app/features/Splash/Splash_Data/Splash_models.dart';
import 'package:course_app/features/Splash/Splash_Data/Splash_services.dart';

class SplashRepo {
  final SplashServices _services;

  SplashRepo({SplashServices? services})
      : _services = services ?? SplashServices();

  Future<SplashDestination> checkUserStatus() => _services.getDestination();
}
