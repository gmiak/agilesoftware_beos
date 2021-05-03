/*
* Klassen bygger abstraktionen (en objektmodell) av en film.
* */
import 'appRepository.dart';
import 'genres.dart';

class Movie {
  static final AppRepository _appRepository = AppRepository();

  final int tmdbId;
  final String poster;
  final String title;
  final String date;
  final List<String> genres;
  final String description;

  bool _liked;

  //constructor
  Movie(
      {this.tmdbId,
      this.title,
      this.poster,
      this.date,
      this.genres,
      this.description,
      liked = false}) {
    setLiked(liked);
  }

  //Returns an instans of movie from Json
  factory Movie.fromTmdbJson(Map<String, dynamic> json) {
    List<String> _genres = [];
    for (int genre in json["genre_ids"]) {
      _genres.add(Genres.getGenreName(genre));
    }

    return Movie(
        tmdbId: json["id"],
        poster: json["poster_path"],
        title: json["title"],
        date: json["release_date"],
        genres: _genres,
        description: json["overview"]);
  }

  factory Movie.fromFBJson(Map<String, dynamic> json) {
    return Movie(
        tmdbId: json["tmdbId"],
        poster: json["poster"],
        title: json["title"],
        date: json["date"],
        genres: json["genres"],
        description: json["description"],
        liked: json["liked"]);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tmdbId': this.tmdbId,
        'poster': this.poster,
        'title': this.title,
        'date': this.date,
        'genres': this.genres,
        'description': this.description,
        'liked': getLiked()
      };

  //Returns title
  String getTitle() {
    return title;
  }

  // Set if the movie was liked
  void setLiked(bool liked) {
    this._liked = liked;
    _appRepository.updateMovieLiked(this, liked);
  }

  // Get if the movie was liked
  bool getLiked() {
    return this._liked;
  }
}
