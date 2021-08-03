import 'package:flutter/material.dart';
import 'package:journal/screens/entry_display.dart';
import 'package:journal/themes.dart';
import 'package:journal/screens/journal.dart';
import 'package:journal/widgets/journal_headlines.dart';
import 'package:journal/screens/new_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<HeadlineListState> _headlines = GlobalKey<HeadlineListState>();

class JournalApp extends StatefulWidget {

  final Map<String, Widget Function(BuildContext)> routes = {
    '/':  (context) => JournalScreen(headlines: _headlines),
    '/create': (context) => JournalEntryAddScreen(headlines: _headlines),
    '/view': (context) => JournalEntryDisplayScreen(headlines: _headlines),
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
      initialRoute: '/',
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