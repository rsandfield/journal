import 'package:flutter/material.dart';

class RatingFormField extends FormField<int> {
  final int starCount;

  RatingFormField({this.starCount = 4, FormFieldSetter<int>? onSaved, Key? key})
      : super(
            initialValue: 1,
            builder: (FormFieldState<int> state) {
              return ToggleButtons(
                children: List<Widget>.generate(starCount, (index) {
                  return _RatingFormStar(checked: (state.value ?? 0) > index);
                }),
                isSelected:
                    List<bool>.generate(starCount, (index) => false),
                onPressed: (int index) => state.didChange(index + 1),
              );
            },
            onSaved: onSaved,
            key: key);
}

class NonNegRatingFormField extends FormField<int> {
  final int starCount;

  NonNegRatingFormField(
      {this.starCount = 4, FormFieldSetter<int>? onSaved, Key? key})
      : super(
            builder: (FormFieldState<int> state) {
              return ToggleButtons(
                children: List<Widget>.generate(starCount + 1, (index) {
                  if (index == 0) {
                    return _RatingFormStar(
                        checked: (state.value ?? 0) == 0, zero: true);
                  } else {
                    return _RatingFormStar(
                        checked: (state.value ?? 0) >= index);
                  }
                }),
                isSelected:
                    List<bool>.generate(starCount + 1, (index) => false),
                onPressed: (int index) => state.didChange(index),
              );
            },
            onSaved: onSaved,
            key: key);
}

class _RatingFormStar extends StatelessWidget {
  final bool checked;
  final bool zero;

  const _RatingFormStar({this.checked = false, this.zero = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (zero) {
      if (checked) {
        return const Icon(Icons.radio_button_checked);
      } else {
        return const Icon(Icons.radio_button_unchecked);
      }
    } else if (checked) {
      return const Icon(Icons.star);
    } else {
      return const Icon(Icons.star_outline);
    }
  }
}
