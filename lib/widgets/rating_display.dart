import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final int rating;
  final int maxRating;

  const RatingWidget(this.rating, {this.maxRating = 4, Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Icon>.generate(maxRating, (i) {
        if (i < rating) {
          return const Icon(Icons.star);
        } else {
          return const Icon(Icons.star_outline);
        }
      }),
    );
  }
}