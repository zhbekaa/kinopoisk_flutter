import 'package:intl/intl.dart';

class FilmCard {
  final int id;
  final String img;
  final String title;
  final int year;
  final String genre;
  final double rating;

  const FilmCard({
    required this.id,
    required this.title,
    required this.img,
    required this.year,
    required this.genre,
    required this.rating,
  });

  factory FilmCard.fromJson(Map<String, dynamic> json) {
    return FilmCard(
      id: json['kinopoiskId'] ?? json['filmId'],
      img: json['posterUrlPreview'],
      title: json['nameRu'] ?? json['nameEn'] ?? json['nameOriginal'] ?? "",
      year: json['year'] ?? 0,
      genre: json['genres'] != null && json['genres'].isNotEmpty
          ? json['genres'][0]['genre']
          : "",
      rating: json['ratingKinopoisk'] ?? json['ratingImdb'] ?? 0,
    );
  }
}

String convertMoney(int number) {
  final formatter = NumberFormat('#,##0', 'en_US');
  return formatter.format(number);
}

class FilmDetailed {
  final int id;
  final String title;
  final String description;
  final int year;
  final List<dynamic> genres;
  final String img;
  final String trailerUrl;
  final double ratingKinopoisk;
  final double ratingImdb;
  final String boxOfficeWorld;
  final String boxOfficeUSA;
  final String boxOfficeRus;
  final List<FilmCard> similar;

  FilmDetailed({
    required this.id,
    required this.title,
    required this.description,
    required this.year,
    required this.genres,
    required this.img,
    required this.trailerUrl,
    required this.ratingKinopoisk,
    required this.ratingImdb,
    required this.boxOfficeWorld,
    required this.boxOfficeUSA,
    required this.boxOfficeRus,
    required this.similar,
  });

  factory FilmDetailed.fromJson(
      Map<String, dynamic> detailedJson,
      Map<String, dynamic> similarJson,
      Map<String, dynamic> boxOfficeJson,
      Map<String, dynamic> videosJson) {
    final similarItems = similarJson['items'] as List<dynamic>;
    final boxOfficeItems = boxOfficeJson['items'] as List<dynamic>;
    final videosItems = videosJson['items'] as List<dynamic>;
    // final boxOfficeWorld = boxOfficeItems[''];

    List<FilmCard> similars = similarItems
        .map((e) => FilmCard.fromJson(e as Map<String, dynamic>))
        .toList();
    final boxOfficeWorld = boxOfficeItems
        .firstWhere((item) => item['type'] == "WORLD", orElse: () => null);
    final boxOfficeUSA = boxOfficeItems
        .firstWhere((item) => item['type'] == "USA", orElse: () => null);
    final boxOfficeRus = boxOfficeItems
        .firstWhere((item) => item['type'] == "RUS", orElse: () => null);
    final trailerUrlItem = videosItems.firstWhere(
      (item) => item['site'] == 'YOUTUBE',
      orElse: () => null,
    );

    final trailerUrl = trailerUrlItem != null ? trailerUrlItem['url'] : '';
    return FilmDetailed(
        id: detailedJson['kinopoiskId'] ?? detailedJson['filmId'],
        title: detailedJson['nameRu'] ??
            detailedJson['nameEn'] ??
            detailedJson['nameOriginal'] ??
            "",
        description: detailedJson['description'] ?? '',
        year: detailedJson["year"],
        genres:
            detailedJson['genres'] != null && detailedJson['genres'].isNotEmpty
                ? detailedJson['genres']
                : "",
        img: detailedJson['posterUrlPreview'],
        trailerUrl: trailerUrl,
        ratingKinopoisk: detailedJson['ratingKinopoisk'] ?? 0.0,
        ratingImdb: detailedJson['ratingImdb'] ?? 0.0,
        boxOfficeWorld: convertMoney(
            (boxOfficeWorld != null && boxOfficeWorld['amount'] != null)
                ? boxOfficeWorld['amount']
                : 0),
        boxOfficeUSA: convertMoney(
            (boxOfficeUSA != null && boxOfficeUSA['amount'] != null)
                ? boxOfficeUSA['amount']
                : 0),
        boxOfficeRus: convertMoney(
            (boxOfficeRus != null && boxOfficeRus['amount'] != null)
                ? boxOfficeRus['amount']
                : 0),
        similar: similars);
  }
}
