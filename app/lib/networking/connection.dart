import 'package:tmdb_api/tmdb_api.dart';

/*
* This class is responsible for the connection with the movie-
* database "tmdb"
**/
class Connection {
  //Global variabels
  final apiKey = "b4cc0c5b697aa656e542ee4110939d7e";
  final apiReadAccessTokenV4 =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNGNjMGM1YjY5N2FhNjU2ZTU0MmVlNDExMDkzOWQ3ZSIsInN1YiI6IjYwNzg3NGRkMWIxZjNjMDA1N2I4OGYzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qN2UHE8GkoB0tCf0X2xGIkJFeXgMkhx8W2-lBv4Cotk';

  //Local attributs
  int page;
  String url;
  TMDB tmdb;

  //Constructor
  Connection({this.page = 1}) {
    url =
        "https://api.themoviedb.org/3/movie/popular?api_key=${apiKey}&page=${page}";
    tmdb = TMDB(ApiKeys(apiKey, apiReadAccessTokenV4));
  }

  //Returns url
  String getUrl() {
    return url;
  }

  //Returns tmdb
  TMDB getTmdb() {
    return tmdb;
  }
}
