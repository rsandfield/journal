import 'package:flutter/material.dart';
import 'package:journal/db/journal.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/screens/journal.dart';
import 'package:journal/widgets/date_text.dart';
import 'package:journal/widgets/welcome.dart';

class HeadlineList extends StatefulWidget {
  final GlobalKey<JournalEntryDisplayDualState>? displayKey;
  final Function(int) onTap;

  const HeadlineList({this.displayKey, required this.onTap, Key? key})
      : super(key: key);

  @override
  State<HeadlineList> createState() => HeadlineListState();
}

class HeadlineListState extends State<HeadlineList> {
  late Future<List<JournalEntry>> _journalEntries = Journal().journalEntries();

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  @override
  Widget build(BuildContext context) {
    // https://www.greycastle.se/reloading-future-with-flutter-futurebuilder/
    return FutureBuilder<List<JournalEntry>>(
      future: _journalEntries,
      builder: (context, AsyncSnapshot<List<JournalEntry>> entries) {
        if (entries.connectionState != ConnectionState.done) {
          return const WelcomeWidget();
        }
        if (entries.hasError) {
          return const WelcomeWidget();
        }
        if (entries.hasData) {
          List<JournalEntry> data = entries.data!;
          return ListView(
            children: data
                .map<JournalHeadline>((journalEntry) => JournalHeadline(
                      journalEntry: journalEntry,
                      onTap: () => widget.onTap(journalEntry.id!),
                    ))
                .toList(),
          );
        }
        return const WelcomeWidget();
      },
    );
  }

  void loadJournal() async {
    setState(() {
      _journalEntries = Journal().journalEntries();
    });
  }
}

class JournalHeadline extends StatelessWidget {
  final JournalEntry journalEntry;
  final Function() onTap;

  const JournalHeadline(
      {required this.journalEntry, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              journalEntry.title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            DateText(journalEntry.date),
          ]),
        ),
      ),
    );
  }
}
