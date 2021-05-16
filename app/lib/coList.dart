import 'package:app/model/listModel.dart';
import 'package:app/view/homePageView.dart';
import 'package:app/view/widgets/themeBlack.dart';
import 'package:flutter/material.dart';
import 'controller/movieController.dart';
import 'swipeMovie.dart';
import 'view/movieViewInfo.dart';
import 'package:app/networking/authentication.dart';
import 'view/movieViewInfoOwner.dart';

class CoList extends StatefulWidget {
  final CommonList commonList;

  CoList({Key key, @required this.commonList}) : super(key: key);

  @override
  _CoListState createState() => _CoListState(commonList);
}

class _CoListState extends State<CoList> {
  int _selectedIndex = 0;
  CommonList commonList;
  _CoListState(commonList) : this.commonList = commonList;

  TextEditingController emailController = new TextEditingController();
  Authentication auth = Authentication();

  ///Activates the functionallity of the diffrent choices in the bottom menu.
  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            openAddMemberDialog();
          }
          break;
        case 1:
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SwipeMovie(commonList: commonList)),
            );
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

  /// Decides wheter to show [MovieViewInfoOwner] or [MovieViewInfo] depending on if current user is owner of list or not.
  Widget chooseMVI(String email) {
    if (email == commonList.getListOwner()) {
      return MovieViewInfoOwner(listId: commonList.getListId());
    } else {
      return MovieViewInfo(listId: commonList.getListId());
    }
  }

  ///Builds the widget with [MovieViewInfo] as body to display the liked movies.
  ///
  ///The Widget has a [BottomNavigationBar] with Buttons. One to be able to swipe movies to the list,
  ///one to be able to add a member to the list, and one to be able to go back to choose other lists.

  @override
  Widget build(BuildContext context) {
    final String email = auth.email;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(commonList.getListName()),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 150),
          )
        ],
      ),
      body: chooseMVI(email),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryYellow,
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
        onTap: _onItemTapped,
      ),
    );
  }

  ///Opens a Dialog window to be able to add members to a list.
  Future<String> openAddMemberDialog() {
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
                    onPressed: () {
                      MovieController.getAppRepository().addMemberToList(
                          emailController.text, commonList.getListId());
                      showFeedbackDialog(context, 'User added');
                      emailController.clear();
                    },
                    padding: EdgeInsets.only(top: 20),
                  )
                ],
              )));
        });
  }

  /// Gives feedback that a user has been added as a member to a list.
  showFeedbackDialog(BuildContext context, String message) {
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
