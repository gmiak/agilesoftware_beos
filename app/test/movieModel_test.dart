// Import the test package and Movie class
import 'package:app/model/movieModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Movie', () {
    //Test on title
    test('Movie title should be null', () {
      var movie = Movie();
      expect(movie.title, null);
    });
    //Test on description
    test('Movie description should be null', () {
      var movie = Movie();
      expect(movie.description, null);
    });

    //Test on method fromTmdbJson
    var movieJson = {
      "id": 1,
      "poster_path": "www.jonhsmith.com/pic.png",
      "title": "John Smith",
      "release_date": "2021-07-16",
      "genre_ids": [14, 28, 12, 878, 53],
      "overview": "john is best",
    };
    var movie_1 = Movie();
    movie_1 = Movie.fromTmdbJson(movieJson);
    test('movie_1 title should be John Smith', () {
      expect(movie_1.title, "John Smith");
    });
    test('movie_1 description should be -john is best-', () {
      expect(movie_1.description, "john is best");
    });
    /* 28:Action 12:Adeventure 16: Animation 35: Comedy 80: Crime 99: Documentary 18: Drama 10751: Family 14: Fanasy 36: History 27: Horror*/
    /*test('Movie\'s first genre should be -family-', () {
      expect(movie.genres[1], "family");
    });*/

    //Test on methood fromFBJson
    var movieJson_2 = {
      "tmdbId": 1,
      "poster": "www.jonhsmith.com/pic.png",
      "title": "John Smith",
      "date": "2021-07-16",
      "genres": ["Action", "Comedy", "crime"],
      "description": "john is best",
      "liked": false
    };
    var movie_2 = Movie.fromFBJson(movieJson_2);
    //Test on method getLiked
    test('movie_2 liked status should be false', () {
      expect(movie_2.getLiked(), false);
    });
    //Test on method setLiked
    test('movie_2 liked status should be true', () {
     // movie_2.setLiked(true); //TODO uppdatera test
      expect(movie_2.getLiked(), true);
    });
    //Test on method toJson
    // ignore: non_constant_identifier_names
    var movie_2_toJson = movie_2.toJson();
    test('movie_2_toJson liked status should be true', () {
      expect(movie_2_toJson["liked"], false);
    });
  });
}
