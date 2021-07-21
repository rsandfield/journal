import 'package:flutter/material.dart';
import 'package:journal/widgets/options.dart';
import 'package:journal/widgets/welcome.dart';

class JournalWidget extends StatefulWidget {
  const JournalWidget({Key? key}) : super(key: key);

  @override
  State<JournalWidget> createState() => _JournalWidgetState();
}

class _JournalWidgetState extends State<JournalWidget> {
  // https://stackoverflow.com/questions/47435231/open-drawer-on-clicking-appbar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journal"),
        actions: [
          MaterialButton(
            child: const Icon(Icons.settings),
              onPressed: _toggleEndDrawer,
          )
        ],
      ),
      body: buildEmpty(),
      endDrawer: const OptionsWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        tooltip: "Add journal entry",
        child: const Icon(Icons.add),
      ),
    );

  }
  void _toggleEndDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Widget buildEmpty() {
    return const WelcomeWidget();
  }
}

class JournalEntryWidget extends StatelessWidget {
  const JournalEntryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
