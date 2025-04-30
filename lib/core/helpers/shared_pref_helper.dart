import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  static Future<void> removeData(String key) async {
    debugPrint('SharedPrefHelper: data with key: $key has been removed');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> clearAllData() async {
    debugPrint('SharedPrefHelper: all data has been cleared');
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> setData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint('SharedPrefHelper: setData with key: $key and value: $value');
    switch (value.runtimeType) {
      case String:
        await prefs.setString(key, value);
        break;
      case int:
        await prefs.setInt(key, value);
        break;
      case bool:
        await prefs.setBool(key, value);
        break;
      case double:
        await prefs.setDouble(key, value);
        break;
    }
  }

  static Future<String> getString(String key) async {
    debugPrint('SharedPrefHelper: getString with key: $key');
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  static Future<bool> getBool(String key) async {
    debugPrint('SharedPrefHelper: getBool with key: $key');
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<int> getInt(String key) async {
    debugPrint('SharedPrefHelper: getInt with key: $key');
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static Future<double> getDouble(String key) async {
    debugPrint('SharedPrefHelper: getDouble with key: $key');
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? 0.0;
  }

  static Future<void> setSecuredString(String key, String value) async {
    const storage = FlutterSecureStorage();
    debugPrint(
        'FlutterSecureStorage: setSecuredString with key: $key and value: $value');
    await storage.write(key: key, value: value);
  }

  static Future<String> getSecuredString(String key) async {
    const storage = FlutterSecureStorage();
    debugPrint('FlutterSecureStorage: getSecuredString with key: $key');
    return await storage.read(key: key) ?? '';
  }

  static Future<void> clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage: all data has been cleared');
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstLaunch') ?? true;
  }

  static Future<void> setFirstLaunch(bool value) async {
    await setData('isFirstLaunch', value);
  }

  static Future<void> saveUserToken(String token) async {
    debugPrint('SharedPrefHelper: Saving user token: $token');
    await setSecuredString('userToken', token);
  }

  static Future<String> getUserToken() async {
    debugPrint('SharedPrefHelper: Retrieving user token');
    return await getSecuredString('userToken');
  }

  static Future<void> removeUserToken() async {
    debugPrint('SharedPrefHelper: Removing user token');
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'userToken');
  }
}
