import 'package:app/controller/movieController.dart';

class Genres {
  static final MovieController _movieController = MovieController();
  static final Map<int, String> _genres = new Map<int, String>();

  static Future<void> populateGenres() async {
    dynamic genresResponse = await _movieController.connection.getGenres();

    if (genresResponse != null) {
      genresResponse.forEach((key, value) {
        for (Map<String, dynamic> map in value) {
          if (map.containsKey("id") && map.containsKey("name"))
            _genres.putIfAbsent(map["id"], () => map["name"]);
        }
      });
    }
  }

  static String getGenreName(int genreId) {
    if (_genres.containsKey(genreId))
      return _genres[genreId];
    else
      return "";
  }
}
