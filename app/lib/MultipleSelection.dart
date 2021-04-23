import 'package:flutter/material.dart';
import 'MovieGenre.dart';

class MultipleSelection extends StatefulWidget {
  final List<MovieGenre> movieGenres;

  MultipleSelection(this.movieGenres);

  @override
  _MultipleSelectionState createState() => _MultipleSelectionState();
}

// Sets up the checkboxes on the dialog.
class _MultipleSelectionState extends State<MultipleSelection> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: Row(
            children: <Widget>[
              Checkbox(
                  value: widget.movieGenres[index].isSelected,
                  onChanged: (s) {
                    widget.movieGenres[index].isSelected =
                        !widget.movieGenres[index].isSelected;
                    setState(() {});
                  }),
              Text(widget.movieGenres[index].genreName)
            ],
          ),
        );
      },
      itemCount: widget.movieGenres.length,
    );
  }
}
