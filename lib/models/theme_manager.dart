import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

// https://pub.dev/packages/theme_mode_handler
class ThemeManager implements IThemeModeManager {

  @override
  Future<String> loadThemeMode() {
    return SharedPreferences.getInstance()
      .then((prefs) =>
        prefs.getString('theme') ?? ThemeMode.system.toString()
      );
  }

  @override
  Future<bool> saveThemeMode(String value) {
    return SharedPreferences.getInstance()
      .then((prefs) =>
          prefs.setString('theme', value)
      );
  }
}