import 'package:course_app/Cash/cash_Helper.dart';
import 'package:course_app/features/Login/login_page.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OnBoarding')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await CashHelper.saveData(key: 'onboarding_done', value: true);
            if (!context.mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          },
          child: const Text('Get Started'),
        ),
      ),
    );
  }
}
