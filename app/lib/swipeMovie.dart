import 'package:app/view/swipeMovieView.dart';
import 'package:flutter/material.dart';
import 'package:app/controller/movieController.dart';
import 'package:app/model/movieModel.dart';
import 'coList.dart';

class SwipeMovie extends StatefulWidget {
  
  final String listId;

  SwipeMovie({Key key, @required this.listId}) : super(key: key);

  @override
  _SwipeMovie createState() => _SwipeMovie();
}

class _SwipeMovie extends State<SwipeMovie> with TickerProviderStateMixin {
  List<Movie> _movies = <Movie>[];
  MovieController movieController = MovieController();
  var _result = 0;
  void _resultat(int index) {
    _movies[index].setLiked(true);

    setState(() {
      _result++;
    });
  }

  // Function to initiate the movies
  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }

  // Function to get all movies we fetched
  void _populateAllMovies() async {
    final likedMovies = await MovieController.getLikedMovies();
    final movies = (await MovieController.getMovies())
        .where((movie1) => likedMovies
            .where((movie2) => movie2.tmdbId == movie1.tmdbId)
            .isEmpty)
        .toList();

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
        body: Column(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "Like: $_result",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SwipeMovieView(movies: _movies, liked: _resultat),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CoList(listId: 'testList')),
            );
          },
          label: const Text('Return'),
          icon: const Icon(Icons.keyboard_return),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
