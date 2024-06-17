import 'package:flutter/material.dart';
import 'package:flutter_application_1/feed/domain/models/films_models.dart';
import 'package:flutter_application_1/feed/domain/services/films_api_service.dart';
import 'package:flutter_application_1/feed/widgets/rating_widget.dart';
import 'package:flutter_application_1/feed/widgets/similars_widget.dart';

class FilmDetailedScreen extends StatefulWidget {
  final int id;

  const FilmDetailedScreen({super.key, required this.id});

  @override
  State<StatefulWidget> createState() {
    return FilmDetailedState();
  }
}

class FilmDetailedState extends State<FilmDetailedScreen> {
  late Future<FilmDetailed> futureFilm;

  void fetchFilm() {
    setState(() {
      futureFilm = fetchFilmDetailed(widget.id);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFilm();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FilmDetailed>(
      future: futureFilm,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Loading'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return const Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        }
        if (snapshot.hasData) {
          final film = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(film!.title),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        film.img,
                        scale: 0.1,
                        height: 300,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'О фильме',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Text('Дата выпуска: ${film.year}'),
                        Text(
                            'Жанр: ${film.genres.map((e) => e['genre']).join(', ')}'),
                        Text('Сборы в России: ${film.boxOfficeRus}'),
                        Text('Сборы в США: ${film.boxOfficeUSA}'),
                        Text('Сборы в Мире: ${film.boxOfficeWorld}'),
                        const SizedBox(height: 20),
                        const Text(
                          'Короткое описание',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Text(
                          film.description,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Рейтинг фильма',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  film.ratingKinopoisk.toString(),
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const Text('Рейтинг Kinopoisk'),
                              ],
                            ),
                            const SizedBox(width: 40),
                            Column(
                              children: [
                                Text(
                                  film.ratingImdb.toString(),
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const Text('Рейтинг IMDb'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingWidget(rating: film.ratingKinopoisk)
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Похожие фильмы',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Similars(similars: film.similar),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        }
      },
    );
  }
}
