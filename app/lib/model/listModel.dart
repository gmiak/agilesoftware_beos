/*
* Klassen bygger abstraktionen (en objektmodell) av en lista.
* */

//TODO Fixa allt likt movieModel
import 'genres.dart';

class CommonList {
  final int tmdbId;
  final String poster;
  final String title;
  final String date;
  final List<String> genres;
  final String description;

  bool _liked;

  //constructor
  CommonList(
      {this.tmdbId,
      this.title,
      this.poster,
      this.date,
      this.genres,
      this.description,
      liked = false}) {
    this._liked = liked;
  }

  //Returns an instans of movie from Json
  factory CommonList.fromTmdbJson(Map<String, dynamic> json) {
    List<String> _genres = [];
    for (int genre in json["genre_ids"]) {
      _genres.add(Genres.getGenreName(genre));
    }

    return CommonList(
        tmdbId: json["id"],
        poster: json["poster_path"],
        title: json["title"],
        date: json["release_date"],
        genres: _genres,
        description: json["overview"]);
  }

  factory CommonList.fromFBJson(Map<String, dynamic> json) {
    return CommonList(
        tmdbId: json["tmdbId"],
        poster: json["poster"],
        title: json["title"],
        date: json["date"],
        genres:
            (json['genres'] as List)?.map((genre) => genre as String)?.toList(),
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

  // Get if the movie was liked
  bool getLiked() {
    return this._liked;
  }
}
