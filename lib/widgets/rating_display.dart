import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final int rating;

  const RatingWidget(this.rating, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Icon>.generate(5, (i) {
        if (i < rating) {
          return const Icon(Icons.star);
        } else {
          return const Icon(Icons.star_outline);
        }
      }),
    );
  }
}