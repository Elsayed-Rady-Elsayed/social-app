import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;

  static InitialStat() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> SaveData({
    required String key,
    dynamic value,
  }) {
    if (value is bool) return sharedPreferences.setBool(key, value);
    if (value is String) return sharedPreferences.setString(key, value);
    if (value is int)
      return sharedPreferences.setInt(key, value);
    else
      return sharedPreferences.setDouble(key, value);
  }

 static dynamic GetData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }
}
