import 'package:course_app/Cash/cache_helper.dart';
import 'package:course_app/core/constants/app_fonts.dart';
import 'package:course_app/core/constants/colors.dart';
import 'package:course_app/features/Splash/Splash_ui/Splash_screen.dart';
import 'package:course_app/features/language/logic/language_cubit.dart';
import 'package:course_app/features/language/ui/language_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await CacheHelper.init();

  final savedLanguage = CacheHelper.getString("language");
  Locale startLocale;
  if (savedLanguage != null) {
    startLocale = Locale(savedLanguage);
  } else {
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;

    if (deviceLocale.languageCode == "ar") {
      startLocale = const Locale("ar");
    } else {
      startLocale = const Locale("en");
    }
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: startLocale,
      child: const MasarApp(),
    ),
  );
}

class MasarApp extends StatelessWidget {
  const MasarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Masar',
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: kMainColor),
          useMaterial3: true,
          fontFamily: AppFonts.kantumruyPro,
          textTheme: AppFonts.textTheme(),
        ),
        home: const LanguageSelectionScreen(),
      ),
    );
  }
}
