import 'package:app/model/movieModel.dart';
import 'package:flutter/material.dart';

/*
** Shows Movie's details
*/
class MovieDetailsDialogScreen extends StatelessWidget {
  //Variabels
  final Movie movie;
  //Constant for padding
  static const double padding = 20.0;
  //Constructor
  MovieDetailsDialogScreen({@required this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(padding),
        ),
        child: Column(
          //Making the pop up with minimun size
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //Card for hold the movie's poster
            Card(
              child: Container(
                height: 450,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://image.tmdb.org/t/p/w500${movie.poster}",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
