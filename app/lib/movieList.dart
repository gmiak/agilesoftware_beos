import 'package:app/controller/movieController.dart';
import 'package:app/model/movieModel.dart';
import 'package:app/view/movieViewInfo.dart';
import 'package:flutter/material.dart';

import 'coList.dart';
import 'genreSelector.dart';

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
    final movies = await MovieController.getFilteredMovies();

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
        body: Stack(alignment: Alignment.bottomRight, children: [
          Container(child: MovieViewInfo(movies: _movies)),
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
