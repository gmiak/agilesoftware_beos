import 'package:app/model/movieModel.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

/*
** Shows Movie's details
*/
// ignore: must_be_immutable
class MovieDetailsDialogScreen extends StatelessWidget {
  //Variabels
  final Movie movie;
  //Constant for padding
  static const double padding = 10.0;
  // Tas bort sen
  List<String> genre = ["Action", "Comedy", "Adventure"];
  //Constructor
  MovieDetailsDialogScreen({@required this.movie});
  @override
  Widget build(BuildContext context) {
    //Getting the screen size
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Container(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(padding),
        ),
        //Making the container scrollable wiht SingleChidScrollView
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: padding,
            horizontal: padding,
          ),
          child: Column(
            //Making the pop up with minimun size
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //Card for hold the movie's poster
              Center(
                child: Card(
                  child: Container(
                    //Set size = 40% of the screen
                    height: _height * 0.40, //450,
                    width: _width * 0.40,
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
              ),
              //Create space between movie's poster and movie's title
              SizedBox(height: padding),
              AutoSizeText(
                movie.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                ),
              ),
              //Create space between movie's title and movie's genres
              SizedBox(height: padding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Ersättas senare med den riktiga listan med alla genrer
                  for (int i = 0; i < genre.length; i++)
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, right: 10, left: 10),
                        child: Column(
                          children: <Widget>[
                            Text(
                              genre[i],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              //Create space between movie's genres and movie's year
              SizedBox(height: padding),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 10, left: 10),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        size: 45,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        movie.year,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //Create space between movie's year and movie's description
              SizedBox(height: padding),
              Text(
                "Synopsis",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: padding),
              AutoSizeText(
                movie.description,
                maxLines: 5,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: padding),
            ],
          ),
        ),
      ),
    );
  }
}
