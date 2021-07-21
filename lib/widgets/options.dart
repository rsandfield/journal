import 'package:flutter/material.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

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

class ThemeModeSelectWidget extends StatefulWidget {
  const ThemeModeSelectWidget({Key? key}) : super(key: key);

  @override
  _ThemeModeSelectWidgetState createState() => _ThemeModeSelectWidgetState();
}

class _ThemeModeSelectWidgetState extends State<ThemeModeSelectWidget> {
  final List<Widget> _buttons = const [
    Icon(Icons.light_mode),
    Icon(Icons.dark_mode)
  ];
  final List<bool> _isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ToggleButtons(
          children: _buttons,
          isSelected: _isSelected,
          onPressed: (int index) => _buttonPressed(index)
        ),
      ],
    );
  }

  void _buttonPressed(int index) {
    setState(() {
      if(index == 0) {
        _isSelected[0] = true;
        _isSelected[1] = false;
        ThemeModeHandler.of(context)?.saveThemeMode(ThemeMode.light);
      } else {
        _isSelected[0] = false;
        _isSelected[1] = true;
        ThemeModeHandler.of(context)?.saveThemeMode(ThemeMode.dark);
      }
    });
  }
}
