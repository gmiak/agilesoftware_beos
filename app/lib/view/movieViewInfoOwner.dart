import 'package:app/controller/movieController.dart';
import 'package:app/model/movieModel.dart';
import 'package:app/view/widgets/movieDetailsDialogScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

/// Klassen tar in en parameter som är ID för en lista,
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
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                MovieDetailsDialogScreen(
                              movie: movie,
                            ),
                          );
                        },
                        child: ClipRRect(
                          child: movie.poster != null
                              ? Image.network(
                                  "https://image.tmdb.org/t/p/w500${movie.poster}")
                              : Image.asset('assets/missingPoster.png'),
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                subtitle: Row(
                  children: <Widget>[
                    RatingBar.builder(
                      initialRating: movie.averageVote,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                          default:
                            return null;
                        }
                      },
                      onRatingUpdate: (rating) {},
                      minRating: 0,
                      maxRating: 5,
                      allowHalfRating: true,
                      ignoreGestures: true,
                    ),
                    SizedBox(width: 8),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          new TextSpan(
                            text: '${movie.averageVote}/5.0',
                          ),
                          new TextSpan(text: ' (${movie.totalVotes})'),
                        ],
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
