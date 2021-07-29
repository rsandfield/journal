import 'package:flutter/material.dart';
import 'package:journal/widgets/options.dart';
import 'package:journal/widgets/rating_form_field.dart';

class JournalEntryCreationScreen extends StatelessWidget {
  const JournalEntryCreationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text("New Journal Entry"),
          actions: const [OptionsOpenWidget()],
        ),
        body: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Title";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: InputDatePickerFormField(
                      firstDate: DateTime.utc(10, 4, 20),
                      lastDate: DateTime.utc(3000, 9, 13),
                      initialDate: DateTime.now(),
                    ),
                  ),
                  Expanded(
                    child: Center(child: RatingFormField()),
                  ),
                ],
              ),
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
              ),
            ],
          ),
        ),
        endDrawer: const OptionsWidget(),
    );
  }
}