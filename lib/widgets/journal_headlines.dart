import 'package:flutter/material.dart';
import 'package:journal/db/journal.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/widgets/welcome.dart';

class HeadlineList extends StatefulWidget {
  late final Future<List<JournalEntry>> _journalEntries;

  HeadlineList({Key? key}) :
        _journalEntries = Journal().journalEntries(),
        super(key: key);

  @override
  State<HeadlineList> createState() => HeadlineListState();
}

class HeadlineListState extends State<HeadlineList> {
  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  @override
  Widget build(BuildContext context) {
    // https://www.greycastle.se/reloading-future-with-flutter-futurebuilder/
    return FutureBuilder <List <JournalEntry>>(
      future: widget._journalEntries,
      builder: (context, AsyncSnapshot<List<JournalEntry>> entries) {
        if (entries.connectionState != ConnectionState.done) {
          return const WelcomeWidget();}
        if (entries.hasError) {
          return const WelcomeWidget();
        }
        if (entries.hasData) {
          List<JournalEntry> data = entries.data!;
          return ListView(
            children: data.map<Widget>((journalEntry) =>
                JournalHeadline(journalEntry: journalEntry)).toList(),
          );
        }
        return const WelcomeWidget();
      },
    );
  }

  void loadJournal() async {
    setState(() {});
  }
}

class JournalHeadline extends StatelessWidget {
  final JournalEntry journalEntry;

  const JournalHeadline({required this.journalEntry, Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                journalEntry.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(journalEntry.date.toString().substring(0, 10)),
            ]
        ),
      ),
    );
  }
}