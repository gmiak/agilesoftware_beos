import 'package:app/view/widgets/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:app/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Ser till att Flutter har lästs in innan Firebase.
  runApp(MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {

  final Future<FirebaseApp> fbApp =
      Firebase.initializeApp(); //Initierar Firebase

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
                return SplashScreen();
              }
            }));
  }
}
