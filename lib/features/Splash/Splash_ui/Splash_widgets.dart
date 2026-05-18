import 'package:course_app/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Masar',
      style: AppFonts.style(
        fontWeight: FontWeight.w700,
        fontSize: 48,
        color: Colors.white,
        letterSpacing: 0.002,
      ),
    );
  }
}

class SplashLoadingIndicator extends StatelessWidget {
  const SplashLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 32),
      child: CircularProgressIndicator(color: Colors.white),
    );
  }
}
