import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

 
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await _prefs.setString(key, value);
    if (value is int) return await _prefs.setInt(key, value);
    if (value is bool) return await _prefs.setBool(key, value);
    if (value is double) return await _prefs.setDouble(key, value);
    if (value is List<String>) return await _prefs.setStringList(key, value);

  
    throw ArgumentError('Type ${value.runtimeType} is not supported in SharedPreferences');
  }

  static dynamic getData(String key) => _prefs.get(key);

  static String? getString(String key) => _prefs.getString(key);

  static bool? getBool(String key) => _prefs.getBool(key);


  

  static Future<bool> removeData({required String key}) async {
    return await _prefs.remove(key);
  }

  static Future<bool> clearAllData() async {
    return await _prefs.clear();
  }
}