import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return _prefs!.setString(key, value);
    if (value is int) return _prefs!.setInt(key, value);
    if (value is bool) return _prefs!.setBool(key, value);
    return false;
  }

  static dynamic getData(String key) => _prefs?.get(key);

  static String? getString(String key) => _prefs?.getString(key);

  static bool? getBool(String key) => _prefs?.getBool(key);

  static Future<bool> removeData(String key) async =>
      _prefs?.remove(key) ?? false;
}
