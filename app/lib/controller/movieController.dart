import 'package:app/networking/connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/model/movieModelInfo.dart';

/*
* Klassen returnerar en lista med populära filmer från tmdb
* tmdb-apiet returnerar cirka 20 filmer/sida
**/

class MovieController {
  Connection connection;
  int pageCall;
  //Constructor
  MovieController({this.pageCall}) {
    connection = new Connection(page: pageCall);
    fetchAllMovies();
  }
  //Fetches all movies
  Future<List<MovieModelInfo>> fetchAllMovies() async {
    //api with out console logs
    final response = await http.get(connection.getUrl());
    if (response.statusCode == 200) {
      //Get a dictionary with all popular movies
      final result = jsonDecode(response.body);
      //Get an iterable list of all popular movies from result where key = results
      Iterable list = result["results"];
      //Mapping our list to Movie object
      return list.map((movie) => MovieModelInfo.fromJson(movie)).toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }
}
