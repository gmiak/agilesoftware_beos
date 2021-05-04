import 'dart:async';
import 'dart:math';

import 'package:app/model/appRepository.dart';
import 'package:app/model/genres.dart';
import 'package:app/networking/connection.dart';
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
  static final int maxPages = 10;

  static final AppRepository _appRepository = AppRepository();
  static final Connection _connection = new Connection();
  static final Random _random = new Random();

  static List<Movie> _movies = <Movie>[];
  static List<Movie> _likedMovies = <Movie>[];

  static Future<Null> _isSettingUp;
  static Future<Null> _isTearingDown;
  static bool _hasSetup = false;

  static Future<bool> setUp() async {
    if (await _sanityCheck()) return true;

    var completer = new Completer<Null>();
    _isSettingUp = completer.future;

    List<Movie> movies = await _appRepository.getMovies();
    if (movies.isEmpty) movies = await _reloadMovies();

    _hasSetup = movies != null && movies.isNotEmpty;

    if (_hasSetup) {
      movies.shuffle();
      _movies.addAll(movies.getRange(0, (movies.length / 2).ceil()));

      _likedMovies = await _appRepository.getLikedMovies() ?? <Movie>[];
    }

    completer.complete();
    _isSettingUp = null;

    return _hasSetup;
  }

  static Future<bool> tearDown(
      {bool emptyMoviesDB = false, bool emptyLikedMoviesDB = false}) async {
    if (!await _sanityCheck()) return true;

    var completer = new Completer<Null>();
    _isTearingDown = completer.future;

    _movies.clear();
    if (emptyMoviesDB) await _appRepository.clearMovies();
    if (emptyLikedMoviesDB) await _appRepository.clearLikedMovies();

    _hasSetup = false;

    return !_hasSetup;
  }

  static Future<List<Movie>> getMovies() async {
    if (!await _sanityCheck()) return <Movie>[];

    return _movies;
  }

  static Future<List<Movie>> getMoviesByGenre(String genre) async {
    if (!await _sanityCheck()) return <Movie>[];

    return _movies.where((movie) => movie.genres.contains(genre));
  }

  static Future<List<String>> getPresentGenres() async {
    if (!await _sanityCheck()) return <String>[];

    List<String> presentGenre = <String>[];
    _movies.forEach((movie) => presentGenre.addAll(movie.genres));

    return presentGenre;
  }

  static Future<List<Movie>> getLikedMovies() async {
    if (!await _sanityCheck()) return <Movie>[];

    return _likedMovies;
  }

  static Future<void> setMovieLiked(Movie movie, bool liked) async {
    if (!await _sanityCheck()) return;

    if (liked && !_likedMovies.contains(movie))
      _likedMovies.add(movie);
    else if (!liked && _likedMovies.contains(movie)) _likedMovies.remove(movie);

    _appRepository.updateMovieLiked(movie, liked);
  }

  //Fetches all movies
  static Future<List<Movie>> _reloadMovies() async {
    await Genres.populateGenres();
    Map<dynamic, dynamic> movies = await _connection
        .getTmdb()
        .v3
        .discover
        .getMovies(sortBy: SortMoviesBy.popularityDesc);

    if (movies != null) {
      List<Movie> _movies = <Movie>[];

      int pageFin = 0;
      if (movies.containsKey("total_pages")) {
        int pageTot = movies["total_pages"];

        if (pageTot > 0) {
          int pageNum = _random.nextInt(pageTot) + 1;

          while (pageTot >= pageNum) {
            if (movies != null) {
              Iterable list = movies["results"];

              if (list.length > 0) {
                List<Movie> movieResults =
                    list.map((movie) => Movie.fromTmdbJson(movie)).toList();
                movieResults.shuffle();

                _movies.addAll(movieResults.getRange(
                    0, (movieResults.length / 2).round()));
              } else {
                break;
              }

              if (pageFin >= maxPages) break;

              pageNum = _random.nextInt(pageTot) + 1;
              pageFin++;
              movies = await _connection.getTmdb().v3.discover.getMovies(
                  sortBy: SortMoviesBy.releaseDateDesc, page: pageNum);
            } else {
              break;
            }
          }
        }

        _appRepository.clearMovies().then((value) => {
              for (Movie movie in _movies) {_appRepository.addMovie(movie)}
            });

        return _movies;
      }
    }

    throw Exception("Failed to load movies");
  }

  static Future<bool> _sanityCheck() async {
    if (_isSettingUp != null) await _isSettingUp;
    if (_isTearingDown != null) await _isTearingDown;

    return _hasSetup;
  }

  static Connection getConnection() => _connection;
  static AppRepository getAppRepository() => _appRepository;
}
