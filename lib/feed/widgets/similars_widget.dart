import 'package:flutter/material.dart';
import 'package:flutter_application_1/feed/domain/models/films_models.dart';
import 'package:flutter_application_1/feed/widgets/film_card_widget.dart';

class Similars extends StatelessWidget {
  const Similars({super.key, required this.similars});

  final List<FilmCard> similars;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            for (int i = 0; i < similars.length; i++) ...[
              FilmCardWidget(film: similars[i], width: 200),
              if (i < similars.length - 1)
                const SizedBox(width: 16), // Adjust the width as needed
            ],
          ],
        ),
      ),
    );
  }
}
