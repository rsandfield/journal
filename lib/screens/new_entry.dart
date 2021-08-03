import 'package:flutter/material.dart';
import 'package:journal/db/journal.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/widgets/journal_headlines.dart';
import 'package:journal/widgets/journal_scaffold.dart';
import 'package:journal/widgets/rating_form_field.dart';

final _formKey = GlobalKey<FormState>();

class JournalEntryAddScreen extends StatelessWidget {
  final GlobalKey<HeadlineListState> headlines;

  const JournalEntryAddScreen({required this.headlines, Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return JournalScaffold(
      back: true,
      title: const Text("New Journal Entry"),
      headlines: headlines,
      child: JournalForm(headlines: headlines),
    );
  }
}

class JournalForm extends StatefulWidget {
  final GlobalKey<HeadlineListState> headlines;

  const JournalForm({required this.headlines, Key? key}) : super(key: key);

  @override
  _JournalFormState createState() => _JournalFormState();
}

class _JournalFormState extends State<JournalForm> {
  final Map<String, dynamic> journalEntry = {};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: "Title"),
            onSaved: (value) {journalEntry['title'] = value ?? "";},
            validator: (value) {
              if(value == null || value.isEmpty) {
                return "Title cannot be blank";
              }
              return null;
            },
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: InputDatePickerFormField(
                  firstDate: DateTime.utc(10, 4, 20),
                  lastDate: DateTime.utc(3000, 9, 13),
                  initialDate: DateTime.now(),
                  onDateSaved: (value) {journalEntry['date'] = value;},
                ),
              ),
              SizedBox(
                width: 300,
                child: Center(
                  child: RatingFormField(
                    onSaved: (value) {journalEntry['rating'] = value ?? 0;},
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 5,
            decoration: const InputDecoration(labelText: "Text"),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return "Body cannot be blank";
              }
              if(value.length > 1470) {
                return "Body too long";
              }
              return null;
            },
            onSaved: (value) {journalEntry['body'] = value ?? "";},
          ),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () {
              if(_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                print(journalEntry['body'].length);
                Journal().insertJournalEntry(JournalEntry.fromMap(journalEntry));
                widget.headlines.currentState?.loadJournal();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
