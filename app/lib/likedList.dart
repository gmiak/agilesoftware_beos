import 'package:flutter/material.dart';
import 'controller/movieController.dart';
import 'model/movieModel.dart';
import 'view/movieViewInfo.dart';

class LikedList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LikedList();
  }
}

class _LikedList extends State<LikedList> {
  MovieController _movieController = MovieController(page: 2);
  List<Movie> _movies = List.empty();

  // Function to initiate the movies
  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }

  // Function to get all movies we fetched
  void _populateAllMovies() async {
    final movies = await _movieController.getMovies();

    setState(() {
      _movies = movies.where((element) => element.getLiked()).toList() ??
          List.empty();
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
          title: Text("Liked"),
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
