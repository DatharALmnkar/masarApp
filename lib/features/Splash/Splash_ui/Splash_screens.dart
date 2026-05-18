import 'package:course_app/core/constants/colors.dart';
import 'package:course_app/features/Home/home_page.dart';
import 'package:course_app/features/Login/login_page.dart';
import 'package:course_app/features/OnBoarding/onboarding_page.dart';
import 'package:course_app/features/Splash/Splash_Data/Splash_repos.dart';
import 'package:course_app/features/Splash/Splash_Logic/Splash_cubit.dart';
import 'package:course_app/features/Splash/Splash_Logic/Splash_state.dart';
import 'package:course_app/features/Splash/Splash_ui/Splash_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(SplashRepo())..startSplash(),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is GoToOnBoarding) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const OnboardingPage()),
          );
        } else if (state is GoToLogin) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        } else if (state is GoToHome) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Center(
          child: BlocBuilder<SplashCubit, SplashState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SplashLogo(),
                  if (state is SplashLoading) const SplashLoadingIndicator(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
