import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.rating});
  final double rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 10; i++)
          if (i < rating)
            if ((rating - i) < 1)
              const Icon(
                Icons.star_half,
                color: Colors.yellow,
              )
            else
              const Icon(
                Icons.star,
                color: Colors.yellow,
              )
          else
            const Icon(
              Icons.star_border,
              color: Colors.yellow,
            )
      ],
    );
  }
}
