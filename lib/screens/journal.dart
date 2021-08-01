import 'package:flutter/material.dart';
import 'package:journal/widgets/journal_headlines.dart';
import 'package:journal/widgets/options.dart';

class JournalScreen extends StatefulWidget {
  final GlobalKey<HeadlineListState>? headlines;
  const JournalScreen({this.headlines, Key? key}) : super(key: key);

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  // https://stackoverflow.com/questions/47435231/open-drawer-on-clicking-appbar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Journal"),
        actions: const [OptionsOpenWidget()],
      ),
      body: HeadlineList(key: widget.headlines),
      endDrawer: const OptionsWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        tooltip: "Add journal entry",
        child: const Icon(Icons.add),
      ),
    );
  }
}




