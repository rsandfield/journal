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
      headlines: headlines,
      child: JournalEntryDisplay(
        id: args,
        headlines: headlines,
        returnAction: () => Navigator.pop(context),
      ),
    );
  }
}

class JournalEntryDisplay extends StatelessWidget {
  final int id;
  final GlobalKey<HeadlineListState> headlines;
  final Function returnAction;

  const JournalEntryDisplay({
    required this.id,
    required this.headlines,
    required this.returnAction,
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
              return _buildEntry(context, journalEntry);
            } else {
              return _buildFailure(context);
            }
          }
        ),
      );
  }

  Widget _buildEntry(BuildContext context, JournalEntry journalEntry) {
    return ListView(
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
                              name: "Delete " + journalEntry.title,
                              actionText: "delete this journal entry",
                              action: () {
                                Journal().deleteJournalEntry(journalEntry)
                                    .then((_) {
                                      headlines.currentState?.loadJournal();
                                      returnAction();
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

  Widget _buildFailure(BuildContext context) {
    return Column(
      children: [
        Text("Sorry, journal Entry " + id.toString() + " doesn't exist."),
        ElevatedButton(
            onPressed: () {
              headlines.currentState?.loadJournal();
              returnAction();
            },
            child: const Text("Reload journal")),
      ],
    );
    }
}