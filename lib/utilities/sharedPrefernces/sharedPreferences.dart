import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print('Token stored in shared preferences: $token');
  }

  static Future<void> storeRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
    print('Role stored in shared preferences: $role');
  }

// Retrieving the token value from shared preferences
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('Token retrieved from shared preferences: $token');
    return token;
  }

  static Future<void> deleteUser(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('User Deleted Successfully: $token');
  }
}
