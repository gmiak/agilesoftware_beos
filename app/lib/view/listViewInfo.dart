import 'package:app/model/movieModel.dart';
import 'package:flutter/material.dart';

/// Klassen tar in en parameter som är listan av alla filmer,
///Därmed målas varje filmer med samma format på skärmen.

class ListViewInfo extends StatelessWidget {
  final List<Movie> movies;

  ///constructor
  ListViewInfo({this.movies, List commonLists});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          title: Row(
            children: [
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
                    children: [Text(movie.title), Text(movie.date)],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
