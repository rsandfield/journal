import 'package:flutter/material.dart';
import 'package:journal/db/journal.dart';
import 'package:journal/widgets/journal_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Journal().initializeDatabase();
  SharedPreferences.getInstance().then((prefs) => runApp(JournalApp(prefs)));
}



