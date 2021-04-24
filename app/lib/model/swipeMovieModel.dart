/*
* Klassen bygger abstraktionen (en objektmodell) av en film.
* */
import 'package:app/model/movieModel.dart';

class SwipeMovieModel {
  List<Movie> commonList;
  List<Movie> likedMovies;

  //constructor
  SwipeMovieModel({this.commonList}) {
    likedMovies = <Movie>[];
  }

  void saveLikedMovies(Movie movie) {
    likedMovies.add(movie);
  }

  List<Movie> getLikedMovies() {
    return likedMovies;
  }
}
