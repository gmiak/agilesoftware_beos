import 'package:app/view/homePageView.dart';
import 'package:flutter/material.dart';
import 'controller/movieController.dart';
import 'model/movieModel.dart';
import 'view/movieViewInfo.dart';
import 'model/appRepository.dart';
import 'swipeMovie.dart';

class CoList extends StatefulWidget {
  final String listId;

  CoList({Key key, @required this.listId}) : super(key: key);
  @override
  _CoListState createState() => _CoListState(listId);
}

class _CoListState extends State<CoList> {
  int _selectedIndex = 0;
  String listId;
  static final AppRepository _appRepository = AppRepository();

  _CoListState(listId) : this.listId = listId;

  List<Movie> _movies = <Movie>[];
  TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _populateLikedMovies();
  }

  // Function to get all movies we fetched
  void _populateLikedMovies() async {
    final movies =
        await MovieController.getAppRepository().getLikedMovies(listId);

    setState(() {
      _movies = movies;
    });
  }

  // TODO() : add functionality to the buttons.
  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            openDialog();
          }
          break;
        case 1:
          {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SwipeMovie()));
          }
          break;
        case 2:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ));
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

  Future<String> openDialog() {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
              title: Text('Users'),
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
                    onPressed: () {
                      //TODO() Add auth
                      _appRepository.addMemberToList(
                          emailController.text, listId);
                      emailController.clear();
                      showAlertDialog(context, 'User added');
                    },
                    padding: EdgeInsets.only(top: 20),
                  )
                ],
              )));
        });
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
