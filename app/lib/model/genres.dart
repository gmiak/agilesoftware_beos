import 'package:app/controller/movieController.dart';

class Genres {
  static final Map<int, String> _genres = new Map<int, String>();

  /// Populate the list of genres with the ones retrieved from the TMDB API.
  static Future<void> populateGenres() async {
    dynamic genresResponse = await MovieController.getConnection().getGenres();

    if (genresResponse != null) {
      _genres.clear();

      genresResponse.forEach((key, value) {
        for (Map<String, dynamic> map in value) {
          if (map.containsKey("id") && map.containsKey("name"))
            _genres.putIfAbsent(map["id"], () => map["name"]);
        }
      });
    }
  }

  /// Get the name of a genre by its id.
  static String getGenreName(int genreId) {
    if (_genres.containsKey(genreId))
      return _genres[genreId];
    else
      return "";
  }
}
