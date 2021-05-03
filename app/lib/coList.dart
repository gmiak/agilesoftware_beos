import 'package:flutter/material.dart';
import 'controller/movieController.dart';
import 'model/movieModel.dart';
import 'view/movieViewInfo.dart';

class CoList extends StatefulWidget {
  @override
  _CoListState createState() => _CoListState();
}

class _CoListState extends State<CoList> {
  int _selectedIndex = 0;

  MovieController _movieController = MovieController();
  List<Movie> _movies = List.empty();

  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }

  // Function to get all movies we fetched
  void _populateAllMovies() async {
    final movies = await _movieController.getMovies();

    setState(() {
      _movies = movies.where((element) => element.getLiked()).toList() ??
          List.empty();
    });
  }

  // TODO() : add functionality to the buttons.
  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {}
          break;
        case 1:
          {}
          break;
        case 2:
          {
            Navigator.pop(context);
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('common Swipes'),
      ),
      body: MovieViewInfo(
        movies: _movies,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group_add_sharp),
            label: 'Add Friend',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swipe),
            label: 'Swipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_left_sharp),
            label: 'Go Back',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
