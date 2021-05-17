import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Shows the welcome message.

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Getting the screen size
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        //Set container size = screen size
        width: _width,
        height: _height,
        //set Background color
        color: Colors.white,
        child: Center(
          child: Text(
            "WELCOME",
            maxLines: 1,
            style: TextStyle(
              fontSize: 50,
              color: Colors.black,
              fontFamily: 'Brush font',
              fontWeight: FontWeight.bold,
              letterSpacing: 2.5,
            ),
          ),
        ),
      ),
    );
  }
}
