import 'package:app/movieList.dart';
import 'package:app/likedList.dart';
import 'package:flutter/material.dart';
import 'package:app/swipeMovie.dart';
import 'package:app/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Ser till att Flutter har lästs in innan Firebase.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Future<FirebaseApp> fbApp = Firebase.initializeApp(); //Initierar Firebase

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BeOs',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            //Väntar på att anslutning till Firebase är klar.
            future: fbApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('You have an error!');
                return Text('Something went wrong!');
              } else if (snapshot.hasData) {
                return LoginScreen(); //Hämtat klart.
              } else {
                return Center(child: CircularProgressIndicator() //Väntar.
                    );
              }
            }));
  }
}















// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

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
                    MaterialPageRoute(builder: (context) => LikedList()),
                  );
                },
              ),
              // This trailing comma makes auto-formatting nicer for build methods.
            ),
          ],
        ));
  }
}
