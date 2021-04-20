import 'package:app/controller/movieController.dart';
import 'package:app/model/movieModelInfo.dart';
import 'package:app/view/movieViewInfo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _App createState() => _App();
}

class _App extends State<MyApp> {
  List<MovieModelInfo> _movies = new List<MovieModelInfo>();
  MovieController movieController = new MovieController(pageCall: 2);

  // Function to initiate the movies
  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }

  // Function to get all movies we fetched
  void _populateAllMovies() async {
    final movies = await movieController.fetchAllMovies();
    setState(() {
      _movies = movies;
    });
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
          body: MovieViewInfo(movies: _movies),
        ));
  }
}
