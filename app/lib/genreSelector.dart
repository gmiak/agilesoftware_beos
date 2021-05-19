import 'package:app/view/widgets/themeBlack.dart';
import 'package:flutter/material.dart';

import 'controller/movieController.dart';

class GenreSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _GenreSelector();
  }
}

class _GenreSelector extends State<GenreSelector> {
  Map<String, bool> _genres = {};
  TextStyle yellowText = new TextStyle(color: primaryYellow);

  @override
  void initState() {
    super.initState();
    _populateGenres();
  }

  /// Populate all of the local genres, with the ones from [MovieController].
  void _populateGenres() async {
    final genres = await MovieController.getGenres();

    setState(() {
      _genres = genres;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(
        primarySwatch: primaryBlack,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Filter",
            style: yellowText,
          ),
        ),
        body: Stack(alignment: Alignment.bottomRight, children: [
          Container(
              child: new ListView(
                  children: _genres.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(key),
              value: _genres[key],
              onChanged: (bool value) {
                setState(() {
                  _genres[key] = value;
                  MovieController.selectGenre(key, value);
                });
              },
            );
          }).toList())),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton.extended(
                    heroTag: 1,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    foregroundColor: primaryYellow,
                    label: const Text('Apply'),
                    backgroundColor: primaryBlackLight),
              ),
            )
          ]),
        ]),
      ),
    );
  }
}
