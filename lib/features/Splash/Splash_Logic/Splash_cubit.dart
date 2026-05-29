import 'package:course_app/Cash/cache_helper.dart'; 
import 'package:course_app/features/Splash/Splash_Logic/Splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  static const String languageKey = "language";

  Future<void> startSplash() async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 8));

    
    final String? savedLang = CacheHelper.getString(languageKey);

    if (savedLang != null) {
      emit(GoToLogin());
    } else {
      emit(GoToLanguageSelection()); 
    }
  }
}
