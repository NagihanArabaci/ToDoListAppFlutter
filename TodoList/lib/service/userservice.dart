import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolistapp/service/user.dart';

class Service {
  static Future<User?> getUser() async {
    User? user = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = (prefs.getString('User') ?? "");
    if (userJson != "") {
      user = User.fromJson(jsonDecode(userJson));
    }
    return user;
  }

  static Future<void> saveUser(User? user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = jsonEncode(user);
    prefs.setString('User', userString);
  }
}
