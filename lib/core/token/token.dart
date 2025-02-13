import 'package:hive_flutter/adapters.dart';

class AuthHelper {
  static String? getToken() {
    return Hive.box("setting").get("token");
  }

  static void saveToken(String token) {
    Hive.box("setting").put("token", token);
  }

  static void removeToken() {
    Hive.box("setting").delete("token");
  }
}
