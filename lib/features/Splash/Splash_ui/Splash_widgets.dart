import 'package:course_app/core/constants/app_assets.dart';
import 'package:course_app/core/constants/app_fonts.dart';
import 'package:course_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppAssets.appLogo,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: kMainColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.school_rounded,
              size: 52,
              color: kMainColor,
            ),
          ),
        ),

        Text(
          'Masar',
          style: AppFonts.style(
            fontWeight: FontWeight.w700,
            fontSize: 48,
            color: Colors.white,
            letterSpacing: 0.002,
          ),
        ),
      ],
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
