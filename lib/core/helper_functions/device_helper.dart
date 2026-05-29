import 'dart:io';
import 'package:course_app/Cash/cache_helper.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceHelper {
  static const String _deviceIdKey = 'device_id';

  static Future<String> getDeviceId() async {
    final cached = CacheHelper.getString(_deviceIdKey);
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    final deviceInfo = DeviceInfoPlugin();
    String deviceId;

    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      deviceId = android.id;
    } else if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      deviceId = ios.identifierForVendor ?? 'unknown_ios_device';
    } else {
      deviceId = 'unknown_device';
    }

    await CacheHelper.saveData(key: _deviceIdKey, value: deviceId);
    return deviceId;
  }
}
