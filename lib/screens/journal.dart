import 'package:flutter/material.dart';
import 'package:journal/screens/entry_display.dart';
import 'package:journal/widgets/journal_headlines.dart';
import 'package:journal/widgets/options.dart';

class JournalScreen extends StatefulWidget {
  final GlobalKey<HeadlineListState> headlines;
  const JournalScreen({required this.headlines, Key? key}) : super(key: key);

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
      body: _buildLayout(context),
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

  Widget _buildLayout(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if(constraints.maxWidth > 700) {
            return JournalEntryDisplayDual(
              headlines: widget.headlines,
              constraints: constraints,
            );
          } else {
            return HeadlineList(
                key: widget.headlines,
              onTap: (int id) => Navigator.pushNamed(context, '/view',
                  arguments: id),
            );
          }
        }
    );
  }
}

class JournalEntryDisplayDual extends StatefulWidget {
  final BoxConstraints constraints;
  final GlobalKey<HeadlineListState> headlines;

  const JournalEntryDisplayDual({
    required this.headlines,
    required this.constraints,
    Key? key
  }) :
        super(key: key);

  @override
  JournalEntryDisplayDualState createState() => JournalEntryDisplayDualState();
}

class JournalEntryDisplayDualState extends State<JournalEntryDisplayDual> {
  late JournalEntryDisplay _display;

  @override
  initState() {
    super.initState();
    _display = JournalEntryDisplay(
      headlines: widget.headlines,
      returnAction: () => changeDisplay(-1),
      id: -1,
    );
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = 350;
    return Row(
      children: [
        SizedBox(
            width: widget.constraints.maxWidth - displayWidth,
            child: HeadlineList(
              key: widget.headlines,
              onTap: changeDisplay,
            )
        ),
        SizedBox(
            width: displayWidth,
            child: _display.id < 0 ? const NullEntry() : _display,
        ),
      ],
    );
  }

  void changeDisplay(int id) {
    setState(() {
      _display = JournalEntryDisplay(
        headlines: widget.headlines,
        returnAction: () => changeDisplay(-1),
        id: id,
      );
    });
  }
}

class NullEntry extends StatelessWidget {
  const NullEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome!",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 10,),
          Text(
            "You haven't selected a journal entry to display yet.",
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10,),
          Text(
            "Tap a headline to display its contents here.",
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


