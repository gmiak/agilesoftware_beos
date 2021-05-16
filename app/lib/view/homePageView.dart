import 'package:app/controller/movieController.dart';
import 'package:app/loginscreen.dart';
import 'package:app/model/listModel.dart';
import 'package:app/view/listViewInfo.dart';
import 'package:app/view/widgets/themeBlack.dart';
import 'package:flutter/material.dart';
import 'package:app/networking/authentication.dart';

///Applikationens huvudsida där man skapar eller går in i listor.

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<CommonList> _commonLists = <CommonList>[];
  TextEditingController listNameController = new TextEditingController();
  Authentication auth = Authentication();

  @override
  void initState() {
    super.initState();
    _populateCommonLists();
  }

  ///Populates [_commonLists] with lists for this user.
  void _populateCommonLists() async {
    print(MovieController.getAppRepository().getLists(auth.email));
    final commonLists =
        await MovieController.getAppRepository().getLists(auth.email);

    setState(() {
      _commonLists = commonLists;
    });
  }

  ///Activates the functionallity of the diffrent choices in the bottom menu.
  Future<void> _onItemTapped(int index) async {
    switch (index) {
      case 0:
        {
          await openAddListDialog();
        }
        break;
      case 1:
        {
          await auth.signOut().then((v) => {
                auth.email = null,
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()))
              });
        }
    }
  }

  ///Builds the widget with [ListViewInfo] as body to display the lists.
  ///
  ///The Widget has a [BottomNavigationBar] with Buttons.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My lists'),
        automaticallyImplyLeading: false,
      ),
      body: ListViewInfo(
        commonLists: _commonLists,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryYellow,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_rounded,
                size: 40, color: Colors.black),
            label: 'Create list',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
              size: 40,
            ),
            label: 'Sign out',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  ///Opens a Dialog window to be able to add a list.
  Future<String> openAddListDialog() {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
              title: Text('Enter list name.'),
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
                        controller: listNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'List name'),
                      )),
                  IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.add),
                    onPressed: () {
                      print(auth.email);
                      auth.checkAuth();
                      MovieController.getAppRepository()
                          .createList(listNameController.text, auth.email);
                      showFeedbackDialog(context, 'List created');
                      _populateCommonLists();
                      listNameController.clear();
                    },
                    padding: EdgeInsets.only(top: 20),
                  )
                ],
              )));
        });
  }

  /// Gives feedback that a list has been added.
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
