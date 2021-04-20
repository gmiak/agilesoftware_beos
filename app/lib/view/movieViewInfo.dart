import 'package:app/model/movieModelInfo.dart';
import 'package:flutter/material.dart';

/*
* This is the class which displays the movie
**/
class MovieViewInfo extends StatelessWidget {
  final List<MovieModelInfo> movies;
  //constructor
  MovieViewInfo({this.movies});
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
                  child: Image.network(
                      "https://image.tmdb.org/t/p/w500${movie.poster}"),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(movie.title), Text(movie.year)],
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