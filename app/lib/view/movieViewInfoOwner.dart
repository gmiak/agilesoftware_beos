import 'package:app/controller/movieController.dart';
import 'package:app/model/movieModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// Klassen tar in en parameter som är listan av alla filmer,
///Därmed målas varje filmer med samma format på skärmen.
///Vyn används av ägare till listan.

class MovieViewInfoOwner extends StatefulWidget {
  final String listId;

  ///constructor
  MovieViewInfoOwner({Key key, @required this.listId}) : super(key: key);

  @override
  _MovieViewInfoState createState() {
    return new _MovieViewInfoState(listId);
  }
}

class _MovieViewInfoState extends State<MovieViewInfoOwner> {
  String listId;
  List<Movie> _movies = <Movie>[];

  _MovieViewInfoState(listId) : this.listId = listId;

  @override
  void initState() {
    super.initState();
    _populateLikedMovies();
  }

  ///Populates [_movies] with liked movies and uppdates the screen.
  void _populateLikedMovies() async {
    final movies =
        await MovieController.getAppRepository().getLikedMovies(listId);

    setState(() {
      _movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index];
          return Slidable(
            actionPane: SlidableStrechActionPane(),
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      child: ClipRRect(
                        child: movie.poster != null
                            ? Image.network(
                                "https://image.tmdb.org/t/p/w500${movie.poster}")
                            : Image.asset('assets/missingPoster.png'),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(movie.title),
                            Text(movie.date),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  setState(() {
                    movie.setLiked(listId, false);
                    MovieController.deleteMovie(listId, movie);
                    _movies.removeAt(index);
                  });
                },
              )
            ],
          );
        });
  }
}
