import 'package:flutter/material.dart';
import 'package:journal/db/journal.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/widgets/date_text.dart';
import 'package:journal/widgets/journal_headlines.dart';
import 'package:journal/widgets/journal_scaffold.dart';
import 'package:journal/widgets/rating_display.dart';

class JournalEntryDisplayScreen extends StatelessWidget {
  final GlobalKey<HeadlineListState> headlines;

  const JournalEntryDisplayScreen({required this.headlines, Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;

    return JournalScaffold(
      back: true,
      title: const Text("View Journal Entry"),
      child: JournalEntryDisplay(
        id: args,
        headlines: headlines,
      ),
    );
  }
}

class JournalEntryDisplay extends StatelessWidget {
  final int id;
  final GlobalKey<HeadlineListState> headlines;

  const JournalEntryDisplay({
    required this.id,
    required this.headlines,
    Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<JournalEntry>(
          future: Journal().getJournalEntry(id),
          builder: (context, AsyncSnapshot<JournalEntry> journalEntryFuture) {
            if (journalEntryFuture.hasData) {
              JournalEntry journalEntry = journalEntryFuture.data!;
              return _build(context, journalEntry);
            } else {
              return Text(
                  "Sorry, journal Entry " + id.toString() + " doesn't exist.");
            }
          }),
    );
  }

  Widget _build(BuildContext context, JournalEntry journalEntry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              journalEntry.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          ConfirmAction(
                              name: "Delete",
                              entry: journalEntry,
                              action: () {
                                Journal().deleteJournalEntry(journalEntry)
                                    .then((_) {
                                      headlines.currentState?.loadJournal();
                                      Navigator.pop(context);
                                    });
                              }
                          )
                  );
                }, icon: const Icon(Icons.delete)),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DateText(journalEntry.date),
            RatingWidget(journalEntry.rating),
          ],
        ),
        const Divider(),
        Text(journalEntry.body)
      ],
    );
  }
}

class ConfirmAction extends StatelessWidget {
  final String name;
  final JournalEntry entry;
  final Function() action;

  const ConfirmAction({
    required this.name,
    required this.entry,
    required this.action,
    Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(name + " " + entry.title),
      content: Text("Are you sure you want to " + name.toLowerCase() +
        " this journal entry?"),
      actions: [
        ElevatedButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text("Confirm"),
          onPressed: () {
            Navigator.pop(context);
            action();
          },
        ),
      ],
    );
  }
}
