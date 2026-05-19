import 'package:course_app/features/Splash/Splash_Logic/Splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> startSplash() async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 10));

    emit(GoToOnBoarding());
  }
}
