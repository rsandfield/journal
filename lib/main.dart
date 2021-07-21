import 'package:flutter/material.dart';
import 'package:journal/models/theme_manager.dart';
import 'package:journal/themes.dart';
import 'package:journal/widgets/journal.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeModeHandler(
      manager: ThemeManager(),
      builder: (ThemeMode themeMode) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: Themes.lightMode,
          darkTheme: Themes.darkMode,
          themeMode: themeMode,
          home: const JournalWidget(),
        );
      },
    );
  }
}