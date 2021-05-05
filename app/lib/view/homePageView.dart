import 'package:app/coList.dart';
import 'package:flutter/material.dart';

import '../likedList.dart';
import '../movieList.dart';
import '../swipeMovie.dart';

/*
** The App Home Page
*/
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Home Page'),
        ),
        body: Column(
          children: <Center>[
            Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: ElevatedButton(
                child: Text("Movies"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MovieList()),
                  );
                },
              ),
              // This trailing comma makes auto-formatting nicer for build methods.
            ),
            Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: ElevatedButton(
                child: Text("Swipe"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SwipeMovie()),
                  );
                },
              ),
              // This trailing comma makes auto-formatting nicer for build methods.
            ),
            Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: ElevatedButton(
                child: Text("Liked"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CoList(listId: 'testList')),
                  );
                },
              ),
              // This trailing comma makes auto-formatting nicer for build methods.
            ),
          ],
        ));
  }
}
