import 'package:course_app/core/Widgets/buildLanguageOption.dart';
import 'package:course_app/core/constants/app_assets.dart';
import 'package:course_app/core/constants/app_fonts.dart';
import 'package:course_app/core/constants/colors.dart';
import 'package:course_app/features/auth/Login/Login_ui/login_page.dart';
import 'package:course_app/features/language/logic/language_cubit.dart';
import 'package:course_app/features/language/logic/language_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageCubit, LanguageState>(
      listener: (context, state) {
        if (state is LanguageChanged) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        }
      },
      builder: (context, state) {
        final cubit = LanguageCubit.get(context);

        return Scaffold(
          backgroundColor: const Color(0xFFFBF5F3),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            AppAssets.appLogo,
                            width: 230,
                            height: 230,
                            fit: BoxFit.contain,
                          ),

                          Positioned(
                            bottom: 10,
                            child: Column(
                              children: [
                                Text(
                                  'MASAR',
                                  style: AppFonts.style(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                    color: kMainColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 38),

                      Text(
                       'choose_language'.tr(),
                        style: AppFonts.style(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: const Color(0xFFEF4444),
                        ),
                      ),

                      const SizedBox(height: 46),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildLanguageOption(
                            flagAsset: 'assets/images/uk_flag.png',
                            languageName: 'english'.tr(),
                            onTap: () {
                              cubit.changeLanguage(context, 'en');
                            },
                          ),

                          buildLanguageOption(
                            flagAsset: 'assets/images/syria_flag.png',
                           languageName: 'arabic'.tr(),
                            onTap: () {
                              cubit.changeLanguage(context, 'ar');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
