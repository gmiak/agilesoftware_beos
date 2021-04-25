import 'package:app/networking/connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/model/movieModel.dart';

/*
* Klassen returnerar en lista med populära filmer från tmdb
* tmdb-apiet returnerar cirka 20 filmer/sida
* Klassen är en Singleton: Iden med singletonklass är alltså att det i programmet bara
* kommer finnas en och endast en instans av klassen och att den som använder klassen inte behöver veta när
* den skapas. SingletonKlassen skapas första gången någon ber om en referens till kalssen.
**/

class MovieController {
  //Singleton configuration
  static final MovieController _movieController = MovieController._internal();
  MovieController._internal();
  //local attributs
  Connection connection;
  int pageCall;
  List<Movie> _movies = <Movie>[];

  //Constructor
  factory MovieController({int page}) {
    _movieController.pageCall = page;
    _movieController.connection =
        new Connection(page: _movieController.pageCall);
    _movieController.getMovies();
    return _movieController;
  }

  //Fetches all movies
  Future<List<Movie>> getMovies() async {
    // Internal cache: Check if list of movies has already been retrieved.
    if (_movies.isNotEmpty) {
      return _movies;
    } else {
      //api with out console logs
      final response = await http.get(connection.getUrl());
      if (response.statusCode == 200) {
        //Get a dictionary with all popular movies
        final result = jsonDecode(response.body);
        //Get an iterable list of all popular movies from result where key = results
        Iterable list = result["results"];
        //Mapping our list to Movie object
        _movies = list.map((movie) => Movie.fromJson(movie)).toList();

        return _movies;
      } else {
        throw Exception("Failed to load movies");
      }
    }
  }
}
