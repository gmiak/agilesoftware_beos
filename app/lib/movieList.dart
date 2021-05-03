import 'package:app/controller/movieController.dart';
import 'package:app/model/movieModel.dart';
import 'package:app/view/movieViewInfo.dart';
import 'package:flutter/material.dart';

/*
** Main klass för filmlistan.
** Den klassen kompletterar i stor sett klassen view/MovieViewInfo.
**/
class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MovieList();
  }
}

class _MovieList extends State<MovieList> {
  List<Movie> _movies = <Movie>[];
  MovieController movieController = MovieController();

  // Function to initiate the movies
  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }

  // Function to get all movies we fetched
  void _populateAllMovies() async {
    final movies = await movieController.getMovies(null);
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
          title: Text("Movies"),
        ),
        body: MovieViewInfo(movies: _movies),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);
          },
          label: const Text('Return'),
          icon: const Icon(Icons.keyboard_return),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
