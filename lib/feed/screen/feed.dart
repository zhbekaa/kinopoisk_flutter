import 'package:flutter/material.dart';
import 'package:flutter_application_1/feed/domain/models/films_models.dart';
import 'package:flutter_application_1/feed/domain/services/films_api_service.dart';
import 'package:flutter_application_1/feed/widgets/film_card_widget.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<StatefulWidget> createState() => FeedState();
}

class FeedState extends State<Feed> {
  late Future<List<FilmCard>> futureFilms;
  var page = 1;
  @override
  void initState() {
    super.initState();
    futureFilms = fethcFilms(1);
  }

  void fetchNextFilms() {
    setState(() {
      page++;
      futureFilms = fethcFilms(page);
    });
  }

  void fetchPreviousFilms() {
    setState(() {
      page--;
      futureFilms = fethcFilms(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Column(
      children: [
        FutureBuilder<List<FilmCard>>(
          future: futureFilms,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              debugPrint('${snapshot.error}');
              return const SizedBox(
                height: 100,
                child: Text('There is an error with your connection')
              );
               
            } else if (snapshot.hasData) {
              final films = snapshot.data;
              return Column(
                children: films!
                    .map((FilmCard film) => FilmCardWidget(film: film, width: 300))
                    .toList(),
              );
            } else {
              return const Text('No data available');
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: page == 1
                      ? null
                      : () {
                          fetchPreviousFilms();
                        },
                  child: const Text('Back')),
              // const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    fetchNextFilms();
                  },
                  child: const Text('Next'))
            ],
          ),
        )
      ],
    )));
  }
}
