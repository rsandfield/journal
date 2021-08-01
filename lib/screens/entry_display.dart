import 'package:flutter/material.dart';
import 'package:journal/db/journal.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/widgets/confirm_action.dart';
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
                icon: const Icon(Icons.delete),
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
                }
            ),
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