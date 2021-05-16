/*
* Klassen bygger abstraktionen (en objektmodell) av en film.
* */
import 'dart:math';

import 'package:app/controller/movieController.dart';
import 'genres.dart';

class Movie {
  final int tmdbId;
  final String poster;
  final String title;
  final String date;
  final List<String> genres;
  final String description;
  final double averageVote;
  final int totalVotes;

  bool _liked;

  //constructor
  Movie(
      {this.tmdbId,
      this.title,
      this.poster,
      this.date,
      this.genres,
      this.description,
      this.averageVote,
      this.totalVotes,
      liked = false}) {
    this._liked = liked;
  }

  /// Convert the JSON response from the TMDB API to an instance of [Movie].
  factory Movie.fromTmdbJson(Map<String, dynamic> json) {
    List<String> _genres = [];
    for (int genre in json["genre_ids"]) {
      _genres.add(Genres.getGenreName(genre));
    }

    double _averageVote = double.parse(json["vote_average"].toString());
    if (_averageVote > 0) _averageVote = _averageVote / 2;
    _averageVote = _roundToDecimals(_averageVote, 2);

    return Movie(
        tmdbId: json["id"],
        poster: json["poster_path"],
        title: json["title"],
        date: json["release_date"],
        genres: _genres,
        description: json["overview"],
        averageVote: _averageVote,
        totalVotes: json["vote_count"]);
  }

  /// Round a double to x decimal places.
  /// Source: https://stackoverflow.com/a/66840734
  static double _roundToDecimals(double numToRound, int deciPlaces) {
    double modPlus1 = pow(10.0, deciPlaces + 1);
    String strMP1 = ((numToRound * modPlus1).roundToDouble() / modPlus1)
        .toStringAsFixed(deciPlaces + 1);
    int lastDigitStrMP1 = int.parse(strMP1.substring(strMP1.length - 1));

    double mod = pow(10.0, deciPlaces);
    String strDblValRound =
        ((numToRound * mod).roundToDouble() / mod).toStringAsFixed(deciPlaces);
    int lastDigitStrDVR =
        int.parse(strDblValRound.substring(strDblValRound.length - 1));

    return (lastDigitStrMP1 == 5 && lastDigitStrDVR % 2 != 0)
        ? ((numToRound * mod).truncateToDouble() / mod)
        : double.parse(strDblValRound);
  }

  /// Convert the JSON response from the Firestore database to an instance of [Movie].
  factory Movie.fromFBJson(Map<String, dynamic> json) {
    return Movie(
        tmdbId: json["tmdbId"],
        poster: json["poster"],
        title: json["title"],
        date: json["date"],
        genres:
            (json['genres'] as List)?.map((genre) => genre as String)?.toList(),
        description: json["description"],
        averageVote: json["averageVote"],
        totalVotes: json["totalVotes"],
        liked: json["liked"]);
  }

  /// Convert this instance of [Movie] to a Map that can later be stored in the Firestore database.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'tmdbId': this.tmdbId,
        'poster': this.poster,
        'title': this.title,
        'date': this.date,
        'genres': this.genres,
        'description': this.description,
        'averageVote': this.averageVote,
        'totalVotes': this.totalVotes,
        'liked': getLiked()
      };

  //Returns title
  String getTitle() {
    return title;
  }

  /// Set if the movie was liked
  void setLiked(String listId, bool liked) {
    this._liked = liked;
    MovieController.setMovieLiked(listId, this, liked);
  }

  /// Get if the movie was liked
  bool getLiked() {
    return this._liked;
  }
}
