import 'package:course_app/Cash/cash_Helper.dart';
import 'package:course_app/core/constants/app_fonts.dart';
import 'package:course_app/core/constants/colors.dart';
import 'package:course_app/features/Splash/Splash_ui/Splash_screens.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  runApp(const MasarApp());
}

class MasarApp extends StatelessWidget {
  const MasarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Masar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kMainColor),
        useMaterial3: true,
        fontFamily: AppFonts.kantumruyPro,
        textTheme: AppFonts.textTheme(),
      ),
      home: const SplashPage(),
    );
  }
}
