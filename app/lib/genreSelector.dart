import 'package:flutter/material.dart';

class GenreSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _GenreSelector();
  }
}

class _GenreSelector extends State<GenreSelector> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.teal)),
      child: CheckboxListTile(
        title: const Text('Woolha.com'),
        subtitle: const Text('A programming blog'),
        secondary: const Icon(Icons.web),
        activeColor: Colors.red,
        checkColor: Colors.yellow,
        selected: _isChecked,
        value: _isChecked,
        onChanged: (bool value) {
          setState(() {
            _isChecked = value;
          });
        },
      ),
    );
  }
}
