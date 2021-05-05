import 'package:app/swipeMovie.dart';
import 'package:flutter/material.dart';
import 'controller/movieController.dart';
import 'model/movieModel.dart';
import 'view/movieViewInfo.dart';

class CoList extends StatefulWidget {

  final String listId;

  CoList({Key key, @required this.listId}) : super(key: key);

  @override
  _CoListState createState() => _CoListState(listId);
}

class _CoListState extends State<CoList> {
  int _selectedIndex = 0;
      String listId;

  _CoListState(listId) : this.listId = listId;

  List<Movie> _movies = <Movie>[];
  TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }

  // Function to get all movies we fetched
  void _populateAllMovies() async {
    final movies = await MovieController.getMovies();

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
          {
            openDialog(listId);
          }
          break;
        case 1:
          {
            Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SwipeMovie(listId : listId)),
                  );
          }
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
            icon: Icon(
              Icons.group_add_sharp,
              size: 40,
            ),
            label: 'Add Friend',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.swipe,
              size: 40,
            ),
            label: 'Swipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_left_sharp,
              size: 40,
            ),
            label: 'Go Back',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Future<String> openDialog(String listId) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
              title: Text('Enter email to add new list member.'),
              actions: <Widget>[
                IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.arrow_left_sharp),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
              content: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText:
                                'Enter valid email id as john.doe@gmail.com'),
                      )),
                  IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.add),
                    onPressed: (){
                      MovieController.addMember(listId, emailController.text);
                    },
                    padding: EdgeInsets.only(top: 20),
                  )
                ],
              )));
        });
  }
}