import 'package:course_app/Cash/cash_Helper.dart';
import 'package:course_app/core/Widgets/custom_general_elevated_button.dart';
import 'package:course_app/core/constants/app_fonts.dart';
import 'package:course_app/core/constants/colors.dart';
import 'package:course_app/features/auth/Login/Login_ui/login_page.dart';
import 'package:course_app/features/auth/SignUp/SignUp_ui/signup_page.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  Future<void> _completeOnBoarding(BuildContext context) async {
    await CashHelper.saveData(key: 'onboarding_done', value: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              'Masar',
              style: AppFonts.style(
                fontWeight: FontWeight.w700,
                fontSize: 48,
                color: kMainColor,
                letterSpacing: 0.002,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Your platform to manage courses and stay connected with your students.',
              style: AppFonts.style(
                fontWeight: FontWeight.w500,
                fontSize: 26,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            CustomGeneralElevatedButton(
              onPressed: () async {
                await _completeOnBoarding(context);
                if (!context.mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignupPage()),
                );
              },
              text: 'Sign Up',
              textButtonColor: Colors.white,
              buttonColor: kMainColor,
            ),
            const SizedBox(height: 18),
            CustomGeneralElevatedButton(
              onPressed: () async {
                await _completeOnBoarding(context);
                if (!context.mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              text: 'Login',
              textButtonColor: kMainColor,
              buttonColor: Colors.white,
              borderSide: const BorderSide(color: kMainColor, width: 2),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
