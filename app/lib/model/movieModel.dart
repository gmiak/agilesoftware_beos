/*
* Klassen bygger abstraktionen (en objektmodell) av en film.
* */
class Movie {
  final String tmdbId;
  final String poster;
  final String title;
  final String year;
  //final String category;
  final String description;

  //constructor
  Movie({this.tmdbId, this.title, this.poster, this.year, this.description});

  //Returns an instans of movie from Json
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      tmdbId: json["year"],
      poster: json["poster_path"],
      title: json["title"],
      year: json["release_date"],
      //category: json["genre_ids"],
      description: json["overview"],
    );
  }
  //Returns title
  String getTitle() {
    return title;
  }
}
