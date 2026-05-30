import 'package:course_app/Cash/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {

  LanguageCubit() : super(LanguageInitial());

  static LanguageCubit get(BuildContext context) =>
      BlocProvider.of(context);

  static const String languageKey = "language";

Future<void> changeLanguage(
  BuildContext context,
  String langCode,
) async {

  await CacheHelper.saveData(
    key: languageKey,
    value: langCode,
  );

  await context.setLocale(
    Locale(langCode),
  );

  if (!isClosed) {
    emit(LanguageChanged(langCode));
  }
}

  bool hasSavedLanguage() {

    return CacheHelper.getString(languageKey) != null;
  }

  String? getSavedLanguage() {

    return CacheHelper.getString(languageKey);
  }
}