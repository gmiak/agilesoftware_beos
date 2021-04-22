import 'package:flutter/material.dart';
import 'MovieGenre.dart';
import 'MultipleSelection.dart';

/*
28:Action
12:Adeventure
16: Animation
35: Comedy
80: Crime
99: Documentary
18: Drama
10751: Family
14: Fanasy
36: History
27: Horror
10402: Music
9648: Mystery
10749: Romance
878: Science Fiction
10770: Tv Movie
53: Thriller
10752: War
37: Western

19 st Genres
*/

void main() => runApp(MaterialApp(
      home: Genre(),
    ));

class Genre extends StatefulWidget {
  @override
  _GenreState createState() => _GenreState();
}

// A map to map the genres name to it's ID.
Map<String, int> genreMap = {
  'Action': 28,
  'Adventure': 12,
  'Animation': 16,
  'Comedy': 35,
  'Crime': 80,
  'Documentary': 99,
  'Drama': 18,
  'Family': 10751,
  'Fantasy': 14,
  'History': 36,
  'Horror': 27,
  'Music': 10402,
  'Mystery': 9648,
  'Romance': 10749,
  'Science Fiction': 878,
  'Tv Movie': 10770,
  'Thriller': 53,
  'War': 10752,
  'Western': 37
};

class _GenreState extends State<Genre> {
  //List of type MoviGenre which contains the genres. Has a boolean-value in it's class to indicate if active or not

  List<MovieGenre> genres = [
    MovieGenre('Action'),
    MovieGenre('Adventure'),
    MovieGenre('Animation'),
    MovieGenre('Comedy'),
    MovieGenre('Crime'),
    MovieGenre('Documentary'),
    MovieGenre('Drama'),
    MovieGenre('Family'),
    MovieGenre('Fantasy'),
    MovieGenre('History'),
    MovieGenre('Horror'),
    MovieGenre('Music'),
    MovieGenre('Mystery'),
    MovieGenre('Romance'),
    MovieGenre('Science Fiction'),
    MovieGenre('Tv Movie'),
    MovieGenre('Thriller'),
    MovieGenre('War'),
    MovieGenre('Western')
  ];

//Builds the widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Genres"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog().then((onValue) {
            //Pass the method getIdString(onValue) to (discover with genres)
            print(getIdString(onValue));
          });
        },
      ),
    );
  }

// Opens a dialog for the filter
  Future<List> openDialog() {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
              title: Text('Genres'),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Apply'),
                  onPressed: () {
                    Navigator.of(context).pop(genres);
                  },
                )
              ],
              content: Container(
                  width: 300, height: 600, child: MultipleSelection(genres)));
        });
  }

// Generates string of genre ID's
  String getIdString(List<MovieGenre> list) {
    StringBuffer sb = StringBuffer();
    String string;
    for (MovieGenre g in list) {
      if (g.isSelected) {
        // print(g.genreName);
        sb.write(genreMap[g.genreName].toString() + ",");
      }
      string = sb.toString();
      if (string != null && string.length > 0) {
        string = string.substring(0, string.length - 1);
      }
    }
    return string;
  }
}
