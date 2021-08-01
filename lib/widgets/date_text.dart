import 'package:flutter/material.dart';

class DateText extends StatelessWidget {
  final DateTime date;

  const DateText(this.date, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(date.toString().substring(0, 10));
  }
}
