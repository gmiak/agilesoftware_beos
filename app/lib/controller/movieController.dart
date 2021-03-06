import 'dart:async';
import 'dart:math';

import 'package:app/model/appRepository.dart';
import 'package:app/model/genres.dart';
import 'package:app/networking/connection.dart';
import 'package:app/model/movieModel.dart';
import 'package:tmdb_api/tmdb_api.dart';

///Klassen returnerar en lista med populära filmer från tmdb
/// tmdb-apiet returnerar cirka 20 filmer/sida
///Klassen är en Singleton: Iden med singletonklass är alltså att det i programmet bara
///kommer finnas en och endast en instans av klassen och att den som använder klassen inte behöver veta när
///den skapas. SingletonKlassen skapas första gången någon ber om en referens till kalssen.

class MovieController {
  static final int maxPages = 10;

  static final AppRepository _appRepository = AppRepository();
  static final Connection _connection = new Connection();
  static final Random _random = new Random();

  static List<Movie> _movies = <Movie>[];
  static List<Movie> _likedMovies = <Movie>[];
  static Map<String, bool> _genres = {};

  static Future<Null> _isSettingUp;
  static Future<Null> _isTearingDown;
  static bool _hasSetup = false;

  /// Sets up the core of the app (retrieval of cached videos, liked videos, ..)
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

      List<String> genres = <String>[];
      _movies.forEach((movie) => genres.addAll(movie.genres));
      genres.sort();
      genres.forEach((genre) => _genres.putIfAbsent(genre, () => false));

      _likedMovies =
          await _appRepository.getLikedMovies('testList') ?? <Movie>[];
    }

    completer.complete();
    _isSettingUp = null;

    return _hasSetup;
  }

  /// Tears the app down and disposes of the retrieved data from Firestore.
  ///
  /// Empties the list of cached movies in the remote database if [emptyMoviesDB] is set to true.
  /// Empties the list of liked movies for all users if [emptyLikedMoviesDB] is set to true.
  static Future<bool> tearDown(
      {bool emptyMoviesDB = false, bool emptyLikedMoviesDB = false}) async {
    if (!await _sanityCheck()) return true;

    var completer = new Completer<Null>();
    _isTearingDown = completer.future;

    _movies.clear();
    _likedMovies.clear();
    _genres.clear();

    if (emptyMoviesDB) await _appRepository.clearMovies();
    if (emptyLikedMoviesDB) await _appRepository.clearLikedMovies('testList');

    _hasSetup = false;
    _isTearingDown = null;

    return !_hasSetup;
  }

  /// Return the list of cached movies.
  static Future<List<Movie>> getMovies() async {
    if (!await _sanityCheck()) return <Movie>[];

    return _movies;
  }

  /// Return the list of genres collected from the cached movies.
  static Future<Map<String, bool>> getGenres() async {
    if (!await _sanityCheck()) return {};

    return _genres;
  }

  /// Select/unselect a genre in the filter.
  static Future<void> selectGenre(String genre, bool selected) async {
    if (!await _sanityCheck()) return {};

    if (_genres.containsKey(genre)) _genres[genre] = selected;
  }

  /// Get the list of movies filtered by the current filter.
  /// Currently only supports filtering by genre(s).
  static Future<List<Movie>> getFilteredMovies() async {
    if (!await _sanityCheck()) return <Movie>[];

    if (!_genres.keys.any((genre) => _genres[genre]))
      return _movies;
    else
      return _movies
          .where((movie) => movie.genres.any((genre) =>
              _genres.keys.any((genre1) => _genres[genre1] && genre == genre1)))
          .toList();
  }

  /// Return the list of cached liked movies.
  static Future<List<Movie>> getLikedMovies() async {
    if (!await _sanityCheck()) return <Movie>[];

    return _likedMovies;
  }

  static Future<void> addMember(String listId, String newMember) async {
    await _appRepository.addMemberToList(newMember, listId);
  }

  /// Set a movie as liked.
  static Future<void> setMovieLiked(
      String listId, Movie movie, bool liked) async {
    if (!await _sanityCheck()) return;

    if (liked && !_likedMovies.contains(movie))
      _likedMovies.add(movie);
    else if (!liked && _likedMovies.contains(movie)) _likedMovies.remove(movie);

    _appRepository.updateMovieLiked(listId, movie, liked);
  }

  static Future<void> deleteMovie(String listId, Movie movie) async {
    await _appRepository.deleteLikedMovie(listId, movie);
  }

  /// Retrieve a new list of movies from the TMDB API.
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

  /// Check if there are any pending set up/tear down operations. True, if this is not the case.
  static Future<bool> _sanityCheck() async {
    if (_isSettingUp != null) await _isSettingUp;
    if (_isTearingDown != null) await _isTearingDown;

    return _hasSetup;
  }

  /// Get the instance of [Connection].
  static Connection getConnection() => _connection;

  /// Get the instance of [AppRepository].
  static AppRepository getAppRepository() => _appRepository;
}
