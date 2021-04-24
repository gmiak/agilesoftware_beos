import 'package:app/view/swipeMovieView.dart';
import 'package:flutter/material.dart';
import 'package:app/controller/movieController.dart';
import 'package:app/model/movieModel.dart';

class SwipeMovie extends StatefulWidget {
  @override
  _SwipeMovie createState() => _SwipeMovie();
}

class _SwipeMovie extends State<SwipeMovie> with TickerProviderStateMixin {
  List<Movie> _movies = <Movie>[];
  MovieController movieController = MovieController(page: 2);

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Swipe"),
        ),
        body: SwipeMovieView(movies: _movies),
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
