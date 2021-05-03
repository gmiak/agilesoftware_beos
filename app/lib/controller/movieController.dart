import 'dart:math';

import 'package:app/model/appRepository.dart';
import 'package:app/model/genres.dart';
import 'package:app/networking/connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/model/movieModel.dart';
import 'package:tmdb_api/tmdb_api.dart';

/*
* Klassen returnerar en lista med populära filmer från tmdb
* tmdb-apiet returnerar cirka 20 filmer/sida
* Klassen är en Singleton: Iden med singletonklass är alltså att det i programmet bara
* kommer finnas en och endast en instans av klassen och att den som använder klassen inte behöver veta när
* den skapas. SingletonKlassen skapas första gången någon ber om en referens till kalssen.
**/

class MovieController {
  static final AppRepository _appRepository = AppRepository();
  //Singleton configuration
  static final MovieController _movieController = MovieController._internal();
  MovieController._internal();
  //local attributs
  Connection connection;
  Future<void> genrePopulation;

  //Constructor
  factory MovieController() {
    _movieController.connection = new Connection();
    _movieController.genrePopulation = Genres.populateGenres();
    return _movieController;
  }

  //Fetches all movies
  Future<List<Movie>> getMovies(List<int> genres) async {
    final Random rnd = new Random();
    await this.genrePopulation;

    dynamic movies = connection.getTmdb().v3.discover.getMovies(
        withGenres: genres != null ? genres.join(",") : "",
        sortBy: SortMoviesBy.releaseDateDesc);

    if (movies != null) {
      List<Movie> _movies = <Movie>[];

      int pageFin = 0;
      int pageTot = movies["total_pages"];

      if (pageTot > 0) {
        int pageNum = rnd.nextInt(pageTot) + 1;

        while (pageTot >= pageNum) {
          if (movies != null) {
            Iterable list = movies["results"];

            if (list.length > 0) {
              List<Movie> movieResults =
                  list.map((movie) => Movie.fromTmdbJson(movie)).toList();
              movieResults.shuffle();

              _movies.addAll(
                  movieResults.getRange(0, (movieResults.length / 2).round()));
            } else {
              break;
            }

            if (pageFin >= 3) break;

            pageNum = rnd.nextInt(pageTot) + 1;
            pageFin++;
            movies = connection.getTmdb().v3.discover.getMovies(
                withGenres: genres != null ? genres.join(",") : "",
                sortBy: SortMoviesBy.releaseDateDesc,
                page: pageNum);
          } else {
            break;
          }
        }
      }

      _appRepository.clearMovies();
      for (Movie movie in _movies) {
        _appRepository.addMovie(movie);
      }

      return _movies;
    } else {
      throw Exception("Failed to load movies");
    }
  }
}
