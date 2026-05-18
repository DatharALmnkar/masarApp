import 'package:course_app/Cash/cash_Helper.dart';
import 'package:course_app/features/Home/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await CashHelper.saveData(key: 'token', value: 'demo_token');
            if (!context.mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
