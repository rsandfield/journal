import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
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
  final Journal journal = Journal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Journal"),
        actions: const [OptionsOpenWidget()],
      ),
      body: buildEntries(),
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

  Widget buildEntries() {
    return FutureBuilder <List <JournalEntry>>(
      future: journal.journalEntries(),
      builder: (context, AsyncSnapshot<List<JournalEntry>> entries) {
        if (entries.data != null) {
          List<JournalEntry> data = entries.data ?? [];
          return ListView(
            children: data.isNotEmpty ? data.map((journalEntry) =>
                JournalEntryWidget(journalEntry: journalEntry)).toList()
                : [const WelcomeWidget()],
          );
        } else {
          return const WelcomeWidget();
        }
      },
    );
  }
}

class JournalEntryWidget extends StatelessWidget {
  final JournalEntry journalEntry;

  const JournalEntryWidget({required this.journalEntry, Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(journalEntry.title),
          Row(
              children: [
                Text(journalEntry.date.toString()),
                RatingWidget(journalEntry.rating),
              ]
          ),
          Text(journalEntry.body),
        ],
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  final int rating;

  const RatingWidget(this.rating, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Icon>.generate(5, (i) {
        if (i < rating) {
          return const Icon(Icons.star);
        } else {
          return const Icon(Icons.star_outline);
        }
      }),
    );
  }
}

