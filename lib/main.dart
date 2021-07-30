import 'package:flutter/material.dart';
import 'package:journal/themes.dart';
import 'package:journal/widgets/journal.dart';
import 'package:journal/widgets/journal_entry_create.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  runApp(JournalApp(await SharedPreferences.getInstance()));
}

class JournalApp extends StatefulWidget {
  final Map<String, Widget Function(BuildContext)> routes = {
    '/':  (context) => const JournalWidget(),
    '/create': (context) => JournalEntryCreationScreen()
  };

  final SharedPreferences preferences;

  JournalApp(this.preferences, {Key? key}) : super(key: key);

  @override
  State<JournalApp> createState() => JournalAppState();
}

class JournalAppState extends State<JournalApp> {

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      title: 'Journal',
      theme: Themes.lightMode,
      darkTheme: Themes.darkMode,
      themeMode: themeMode,
      initialRoute: '/create',
      routes: widget.routes,
    );
  }

  ThemeMode get themeMode {
    String text = widget.preferences.getString('theme') ?? ThemeMode.system.toString();
    switch (text) {
      case "ThemeMode.dark": {
        return ThemeMode.dark;
      }
      case "ThemeMode.light": {
        return ThemeMode.light;
      }
      default: {
        return ThemeMode.system;
      }
    }
  }

  set themeMode(ThemeMode mode) {
    setState(() {
      widget.preferences.setString('theme', mode.toString());
    });
  }
}