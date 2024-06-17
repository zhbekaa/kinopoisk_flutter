import 'package:flutter/material.dart';
import 'package:flutter_application_1/feed/domain/models/films_models.dart';
import 'package:flutter_application_1/feed/screen/film_detailed.dart';

class FilmCardWidget extends StatelessWidget {


  const FilmCardWidget({super.key, required this.film, required this.width});

  final FilmCard film;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint(film.id.toString());

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FilmDetailedScreen(id: film.id)),
          );
        },
        child: SizedBox(
            width: width,
            child: Column(
              children: [
                Image.network(film.img, scale: 0.6),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          film.title,
                          style: const TextStyle(fontSize: 18),
                        ),
                        if (film.year != 0)
                          Text(
                            '${film.year}, ${film.genre}',
                          )
                      ]),
                )
              ],
            )),
      ),
    );
  }
}
