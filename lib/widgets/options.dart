import 'package:flutter/material.dart';
import 'package:journal/main.dart';

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      elevation: 1,
      child: ThemeModeSelectWidget()
    );
  }
}

class OptionsOpenWidget extends StatelessWidget {
  const OptionsOpenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Icon(
          Icons.settings,
          color: Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: () => Scaffold.of(context).openEndDrawer(),
    );
  }
}


class ThemeModeSelectWidget extends StatefulWidget {

  const ThemeModeSelectWidget({Key? key}) : super(key: key);

  @override
  _ThemeModeSelectWidgetState createState() => _ThemeModeSelectWidgetState();
}

class _ThemeModeSelectWidgetState extends State<ThemeModeSelectWidget> {
  JournalAppState? appState;

  final List<Widget> _buttons = const [
    Icon(Icons.light_mode),
    Icon(Icons.dark_mode)
  ];
  List<bool> get _isSelected {
    return [
      appState?.themeMode == ThemeMode.light,
      appState?.themeMode == ThemeMode.dark,
    ];
  }

  @override
  Widget build(BuildContext context) {
    appState ??= context.findAncestorStateOfType<JournalAppState>();

    return Drawer(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Text("Theme mode select:", style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 15,),
            ToggleButtons(
              children: _buttons,
              isSelected: _isSelected,
              onPressed: (int index) => _buttonPressed(index)
            ),
          ],
        ),
      ),
    );
  }

  void _buttonPressed(int index) {
    setState(() {
      if(index == 0) {
        _isSelected[0] = true;
        _isSelected[1] = false;
        appState?.themeMode = ThemeMode.light;
      } else {
        _isSelected[0] = false;
        _isSelected[1] = true;
        appState?.themeMode = ThemeMode.dark;
      }
    });
  }
}
