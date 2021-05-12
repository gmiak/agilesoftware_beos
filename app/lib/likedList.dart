import 'package:flutter/material.dart';
import 'view/movieViewInfo.dart';

class LikedList extends StatefulWidget {
  final String listId;

  LikedList({Key key, @required this.listId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _LikedList(listId);
  }
}

class _LikedList extends State<LikedList> {
  String listId;

  _LikedList(listId) : this.listId = listId;

  // Function to initiate the movies

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Liked"),
        ),
        body: MovieViewInfo(
          listId: listId,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);
          },
          label: const Text('Return'),
          icon: const Icon(Icons.keyboard_return),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
