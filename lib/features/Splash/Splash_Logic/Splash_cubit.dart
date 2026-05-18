import 'package:course_app/features/Splash/Splash_Data/Splash_models.dart';
import 'package:course_app/features/Splash/Splash_Data/Splash_repos.dart';
import 'package:course_app/features/Splash/Splash_Logic/Splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashRepo _repo;

  SplashCubit(this._repo) : super(SplashInitial());

  Future<void> startSplash() async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 20));

    final destination = await _repo.checkUserStatus();
    switch (destination) {
      case SplashDestination.onBoarding:
        emit(GoToOnBoarding());
      case SplashDestination.login:
        emit(GoToLogin());
      case SplashDestination.home:
        emit(GoToHome());
    }
  }
}
