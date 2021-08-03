import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';

class ConfirmAction extends StatelessWidget {
  final String name;
  final String actionText;
  final Function() action;

  const ConfirmAction({
    required this.name,
    required this.actionText,
    required this.action,
    Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(name),
      content: Text("Are you sure you want to " + actionText + "?"),
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