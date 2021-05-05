import 'package:flutter/material.dart';
import 'controller/movieController.dart';
import 'model/movieModel.dart';
import 'view/movieViewInfo.dart';

class LikedList extends StatefulWidget {

  final String listId;

  LikedList({Key key, @required this.listId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _LikedList(listId);
  }
}

class _LikedList extends State<LikedList> {
  List<Movie> _movies = <Movie>[];
    String listId;

  _LikedList(listId) : this.listId = listId; 


  // Function to initiate the movies
  @override
  void initState() {
    super.initState();
    _populateLikedMovies();
  }

  // Function to get all movies we fetched
  void _populateLikedMovies() async {
    final movies = await MovieController.getAppRepository().getLikedMovies(listId);

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
