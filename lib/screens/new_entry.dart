import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/widgets/options.dart';
import 'package:journal/widgets/rating_form_field.dart';

final _formKey = GlobalKey<FormState>();

class JournalEntryCreationScreen extends StatelessWidget {
  final journalEntry = JournalEntry.empty();

  JournalEntryCreationScreen({Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text("New Journal Entry"),
          actions: const [OptionsOpenWidget()],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Title"),
                  onSaved: (value) {journalEntry.title = value ?? "";},
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Title";
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
                        onDateSaved: (value) {journalEntry.date = value;},
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Center(
                          child: RatingFormField(
                            onSaved: (value) {journalEntry.rating = value ?? 0;},
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
                      return "Text";
                    }
                    return null;
                  },
                  onSaved: (value) {journalEntry.body = value ?? "";},
                ),
                ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    if(_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      Journal().insertJournalEntry(journalEntry);
                      Navigator.of(context).pop();
                    }
                },
                ),
              ],
            ),
          ),
        ),
        endDrawer: const OptionsWidget(),
    );
  }
}