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
  List<Movie> _movies = <Movie>[];

  // Function to initiate the movies
  @override
  void initState() {
    super.initState();
    _populateLikedMovies();
  }

  // Function to get all movies we fetched
  void _populateLikedMovies() async {
    final movies = await MovieController.getAppRepository().getLikedMovies();

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
