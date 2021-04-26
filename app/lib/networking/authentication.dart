import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

/*
Klass som sköter backend för autentisiering, signup, login och nollställning av lösenord. 
*/

class Authentication {
  //Singleton configuration
  static final Authentication authentication = Authentication._internal();
  Authentication._internal();
  //local attributes
  Firebase fbApp;
  FirebaseAuth auth;

  //Constructor
  factory Authentication(Firebase fbApp) { //tar in en instans av Firebase och skapar en för FirebaseAuth.
    authentication.fbApp = fbApp;
    authentication.auth = FirebaseAuth.instance;
    return authentication;
  }

Future<void> checkAuth() async { //Kollar om inloggad.
  if (auth.currentUser != null) {
    print("Already Signed in");
  } else {
    print("Signed Out");
  }
}

Future<void> signUp() async { //Logik för att skapa konto
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "albin.rossle@gmail.com", password: "123456"); //Gör om för att ta in info från tangentbord.
    print("Success");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('An account already exists for that email.');
    }
  } catch (e) {
    print(e.toString());
  }
}

Future<void> signIn() async { //Logik för login.
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "albin.rossle@gmail.com", password: "123456"); //Gör om för att ta in info från tangentbord.
    print("Success");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    } else {
      print(e.code.toString());
    }
  }
}

Future<void> signOut() async { //Logga ut
  try {
    await FirebaseAuth.instance.signOut();
    print("Success");
  } catch (e) {
    print(e.toString());
  }
}

Future<void> resetPassword() async { //Nollställ lösenord.
  auth.sendPasswordResetEmail(email: "albin.rossle@gmail.com"); //Gör om för att ta in info från tangentbord.
}

Future<void> verifyEmail() async { 
  User user = FirebaseAuth.instance.currentUser;
  user.sendEmailVerification();
}
/* Kan användas för att välja ett namn att visa senare. 
Future<void> setDisplayName() async {
  User user = FirebaseAuth.instance.currentUser;
  user.updateProfile(displayName: "Abbelonius");
}

Future<void> checkDisplayName() async {
  User user = FirebaseAuth.instance.currentUser;
  print(user.displayName);
}
*/
}

