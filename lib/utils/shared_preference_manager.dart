import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static String userId = "";
  static Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  /// Function to store user data in SharedPreferences
  static Future<void> saveUserDataInSharedPreferences(
      String token, String userId) async {
    final sp = await _getInstance();
    await Future.wait([
      sp.setString("token", token),
      // sp.setBool('isLogin', true),
      sp.setString('userId', userId),
    ]);
  }

  /// Function to get user details from SharedPreferences
  static Future<Map<String, dynamic>>
      getUserDetailsFromSharedPreferences() async {
    final sp = await _getInstance();
    return {
      "token": sp.getString('token'),
      //"isLogin": sp.getBool('isLogin'),
      "userId": sp.getString('id'),
    };
  }

  /// Function to get remove all the data from shared prefrences
  static Future<void> removeUserDetailsFromSharedPreferences() async {
    final sp = await _getInstance();
    sp.remove("token");
    sp.remove("userId");
    sp.remove("isLogin");
  }

  /// Function to get the token from SharedPreferences
  static Future<String?> getUserTokenFromSharedPreferences() async {
    final sp = await _getInstance();
    return sp.getString('token');
  }

  /// Function to get the userId from SharedPreferences
  static Future<String?> getUserIdFromSharedPreferences() async {
    final sp = await _getInstance();
    return sp.getString('userId');
  }

  /// Function to get the isUserLogin from SharedPreferences
  static Future<bool?> getUserStatusFromSharedPreferences() async {
    final sp = await _getInstance();
    return sp.getBool('isLogin');
  }
}
