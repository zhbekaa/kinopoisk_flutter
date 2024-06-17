import 'dart:convert';

import 'package:flutter_application_1/feed/domain/models/films_models.dart';
import 'package:http/http.dart' as http;

Future<List<FilmCard>> fethcFilms(int page) async {
  final url = Uri.parse(
      'https://kinopoiskapiunofficial.tech/api//v2.2/films?page=$page');
  try {
    final response = await http.get(url, headers: <String, String>{
      'X-API-KEY': 'f693083c-4816-48be-98f0-fe811da4b553'
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = json.decode(utf8.decode(response.bodyBytes)) as dynamic;
      final items = data['items'] as List<dynamic>;

      return items
          .map((e) => FilmCard.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  } catch (e) {
    var testObj = [
      {
        "id": 1,
        'title': "Title",
        "img": "img",
        "year": 2024,
        "genre": "Мультиh",
        "rating": 1.0
      }
    ];
    return testObj.map((e) => FilmCard.fromJson(e)).toList();
    // throw 'Failed to load album';
  }
}

Future<FilmDetailed> fetchFilmDetailed(int id) async {
  const String baseURL = 'https://kinopoiskapiunofficial.tech/api';
  String apiKey = 'f693083c-4816-48be-98f0-fe811da4b553';
  final header = <String, String>{'X-API-KEY': apiKey};

  final urlDetailed = Uri.parse('$baseURL/v2.2/films/$id');
  final urlSimiral = Uri.parse('$baseURL/v2.2/films/$id/similars');
  final urlBoxOffice = Uri.parse('$baseURL/v2.2/films/$id/box_office');
  final urlVideos = Uri.parse('$baseURL/v2.2/films/$id/videos');

  // final header = ;
  final responseDetailed = await http.get(urlDetailed, headers: header);
  final responseSimilar = await http.get(urlSimiral, headers: header);
  final responseBoxOffice = await http.get(urlBoxOffice, headers: header);
  final responseVideos = await http.get(urlVideos, headers: header);

  final success = responseSimilar.statusCode == 200 &&
      responseDetailed.statusCode == 200 &&
      responseVideos.statusCode == 200 &&
      responseBoxOffice.statusCode == 200;

  if (success) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final detailed =
        json.decode(utf8.decode(responseDetailed.bodyBytes)) as dynamic;
    final similar =
        json.decode(utf8.decode(responseSimilar.bodyBytes)) as dynamic;
    final boxOffice =
        json.decode(utf8.decode(responseBoxOffice.bodyBytes)) as dynamic;
    final videos =
        json.decode(utf8.decode(responseVideos.bodyBytes)) as dynamic;

    return FilmDetailed.fromJson(detailed, similar, boxOffice, videos);
  } else {
    throw Exception('Could not fetch film');
  }
}
