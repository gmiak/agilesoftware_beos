import 'package:app/view/swipeMovieView.dart';
import 'package:flutter/material.dart';
import 'package:app/controller/movieController.dart';
import 'package:app/model/movieModel.dart';
import 'coList.dart';
import 'genreSelector.dart';

class SwipeMovie extends StatefulWidget {
  final String listId;

  SwipeMovie({Key key, @required this.listId}) : super(key: key);

  @override
  _SwipeMovie createState() => _SwipeMovie(listId);
}

class _SwipeMovie extends State<SwipeMovie> with TickerProviderStateMixin {
  List<Movie> _movies = <Movie>[];
  String listId;
  MovieController movieController = MovieController();

  _SwipeMovie(listId) : this.listId = listId;

  var _result = 0;
  void _resultat(int index) {
    _movies[index].setLiked(listId, true);

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
    final movies = (await MovieController.getFilteredMovies())
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
        body: Stack(alignment: Alignment.bottomRight, children: [
          Container(
              child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Like: $_result",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SwipeMovieView(movies: _movies, liked: _resultat),
            ],
          )),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton.extended(
                    heroTag: 1,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CoList(listId: 'testList')),
                      );
                    },
                    label: const Text('Return'),
                    icon: const Icon(Icons.keyboard_return),
                    backgroundColor: Colors.blue),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton.extended(
                    heroTag: 2,
                    onPressed: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new GenreSelector()))
                          .then((value) => _populateAllMovies());
                    },
                    label: const Text('Filter'),
                    icon: const Icon(Icons.filter_list),
                    backgroundColor: Colors.blue),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
