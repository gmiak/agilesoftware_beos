import 'dart:convert';

import 'package:app/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _App createState() => _App();
}

class _App extends State<MyApp> {
  // Function for fetch all movies
  Future<List<Movie>> _fetchAllMovies() async {
    //Api keys.
    var apiKey = 'b4cc0c5b697aa656e542ee4110939d7e';

    //api with out console logs
    final response = await http.get(
        "http://api.themoviedb.org/3/movie/popular?api_key=b4cc0c5b697aa656e542ee4110939d7e");
    if (response.statusCode == 200) {
      //Get a dictionary with all popular movies
      final result = jsonDecode(response.body);
      //Get an iterable list of all popular movies from result where key = results
      Iterable list = result["results"];
      //Mapping our list to Movie object
      return list.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movies App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("BeOs"),
          ),
        ));
  }
}
