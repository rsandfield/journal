

import 'package:flutter/material.dart';
import 'package:journal/widgets/options.dart';

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
              RatingFormField(),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
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

class RatingFormField extends StatefulWidget {
  final List<bool> _rating = [false, true, true, false, false, false];
  late final List<Widget> _buttons;

  RatingFormField({Key? key}) : super(key: key) {
    _buttons = List<Widget>.generate(_rating.length, (i) {
      if (i == 0) {
        return _RatingFormStar(checked: _rating[i], zero: true);
      }
      else {
        return _RatingFormStar(checked: _rating[i]);
      }
    });
  }

  @override
  State<RatingFormField> createState() => _RatingFormFieldState();
}

class _RatingFormFieldState extends State<RatingFormField> {

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: widget._buttons,
      isSelected: widget._rating,
      onPressed: (int index) => _buttonPressed(index)
    );
  }

  void _buttonPressed(int index) {
    setState(() {
      widget._rating[0] = index == 0;
      widget._buttons[0] = _RatingFormStar(checked: widget._rating[0], zero: true);

      for (int i = 1; i < widget._rating.length; i++) {
        widget._rating[i] = index >= i;
        widget._buttons[i] = _RatingFormStar(checked: widget._rating[i]);
      }
    });
  }
}

class _RatingFormStar extends StatelessWidget {
  final bool checked;
  final bool zero;
  const _RatingFormStar({this.checked = false, this.zero = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(zero) {
      return const Icon(Icons.radio_button_unchecked);
    }
    else if(checked) {
      return const Icon(Icons.star);
    }
    else {
      return const Icon(Icons.star_outline);
    }
  }
}
