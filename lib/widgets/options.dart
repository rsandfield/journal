import 'package:flutter/material.dart';
import 'package:journal/db/journal.dart';
import 'package:journal/main.dart';
import 'package:journal/widgets/confirm_action.dart';
import 'package:journal/widgets/journal_headlines.dart';

class OptionsWidget extends StatelessWidget {
  final GlobalKey<HeadlineListState> headlines;

  const OptionsWidget({required this.headlines, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1,
      child: ThemeModeSelectWidget(headlines: headlines,)
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
  final GlobalKey<HeadlineListState> headlines;

  const ThemeModeSelectWidget({required this.headlines, Key? key}) :
        super(key: key);

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
            DrawerHeader(
                child: Text(
                  "Settings",
                  style: Theme.of(context).textTheme.headline5,),
            ),
            Text(
              "Theme mode select:",
              style: Theme.of(context).textTheme.headline6,
            ),
            ToggleButtons(
              children: _buttons,
              isSelected: _isSelected,
              onPressed: (int index) => _buttonPressed(index)
            ),
            const SizedBox(height: 30,),
            DropTable(headlines: widget.headlines),
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

class DropTable extends StatelessWidget {
  final GlobalKey<HeadlineListState> headlines;

  const DropTable({required this.headlines, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            "Drop table:",
            style: Theme.of(context).textTheme.headline6
        ),
        IconButton(
            onPressed: () => dropTable(context),
            icon: const Icon(Icons.delete),
        )
      ],
    );
  }

  void dropTable(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
          ConfirmAction(
              name: "Drop Table",
              actionText: "drop the entire table",
              action: () => Journal().dropTable()
                    .then((_) => headlines.currentState?.loadJournal()),
          )
    );
  }
}
