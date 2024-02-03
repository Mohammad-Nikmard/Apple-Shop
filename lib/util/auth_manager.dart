import 'package:apple_shop/DI/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final SharedPreferences _preferences = locator.get();
  static final ValueNotifier _notifier = ValueNotifier(null);

  static void saveToken(String token) {
    _preferences.setString('access_token', token);
    _notifier.value = token;
  }

  static String readToken() {
    return _preferences.getString('access_token') ?? "";
  }

  static bool isTokenSaved() {
    var token = readToken();
    return token.isNotEmpty;
  }

  static void logout() {
    _preferences.clear();
    _notifier.value = null;
  }

  static void saveId(String id) {
    _preferences.setString('id', id);
  }

  static String readId() {
    return _preferences.getString('id') ?? "";
  }
}
