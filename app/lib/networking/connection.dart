import 'package:tmdb_api/tmdb_api.dart';

/*
* This class is responsible for the connection with the movie-
* database "tmdb"
**/
class Connection {
  TMDB _tmdb;

  Connection(
      {String apiKey = "b4cc0c5b697aa656e542ee4110939d7e",
      String apiReadAccessTokenV4 =
          "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNGNjMGM1YjY5N2FhNjU2ZTU0MmVlNDExMDkzOWQ3ZSIsInN1YiI6IjYwNzg3NGRkMWIxZjNjMDA1N2I4OGYzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qN2UHE8GkoB0tCf0X2xGIkJFeXgMkhx8W2-lBv4Cotk"}) {
    this._tmdb = new TMDB(ApiKeys(apiKey, apiReadAccessTokenV4));
  }

  Future<Map<dynamic, dynamic>> getGenres() async {
    return await _tmdb.v3.geners.getMovieList();
  }

  //Returns tmdb
  TMDB getTmdb() {
    return _tmdb;
  }
}
