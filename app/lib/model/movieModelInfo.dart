/*
* This class represents the object movie
* */
class MovieModelInfo {
  final String tmdbId;
  final String poster;
  final String title;
  final String year;
  final String category;
  final String description;

  //constructor
  MovieModelInfo(
      {this.tmdbId,
      this.title,
      this.poster,
      this.year,
      this.category,
      this.description});

  // Function which return an instans of movie from Json
  factory MovieModelInfo.fromJson(Map<String, dynamic> json) {
    return MovieModelInfo(
      tmdbId: json["id"],
      poster: json["poster_path"],
      title: json["title"],
      year: json["release_date"],
      category: json["genre_ids"],
      description: json["overview"],
    );
  }
}
