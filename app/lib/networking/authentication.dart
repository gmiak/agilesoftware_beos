import 'package:app/controller/movieController.dart';
import 'package:firebase_auth/firebase_auth.dart';

///Klass som sköter backend för autentisiering, signup, login och nollställning av lösenord.

class Authentication {
  //Singleton configuration
  static final Authentication authentication = Authentication._internal();
  Authentication._internal();

  //local attributes
  FirebaseAuth auth;
  String email;

  //Constructor
  factory Authentication() {
    //tar in en instans av Firebase och skapar en för FirebaseAuth.
    authentication.auth = FirebaseAuth.instance;
    authentication.auth.signOut();
    return authentication;
  }

  ///Kollar om inloggad.
  Future<void> checkAuth() async {
    if (auth.currentUser != null) {
      print("Already Signed in as ${auth.currentUser.email}");
    } else {
      print("Signed Out");
    }
  }

  ///Logik för att skapa konto
  Future<String> signUp(String _email, String _password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      email = identifyEmail();
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'An account already exists for that email.';
      } else
        return "Something went wrong";
    } catch (e) {
      return e.toString();
    }
  }

  ///Logik för login.
  Future<String> signIn(String _email, String _password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      await MovieController.setUp();
      email = identifyEmail();
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.code.toString();
      }
    }
  }

  ///Logga ut
  Future<void> signOut() async {
    try {
      await MovieController.tearDown();
      await FirebaseAuth.instance.signOut();
      email = null;
      print("Success");
    } catch (e) {
      print(e.toString());
    }
  }
///Nollställ lösenord.
  Future<void> resetPassword(String _email) async {
    
    auth.sendPasswordResetEmail(
        email: _email);
  }

///Verifiera email
  Future<void> verifyEmail() async {
    User user = FirebaseAuth.instance.currentUser;
    user.sendEmailVerification();
  }
///Hitta email för inloggad användare. Fungerar dåligt från Firebase sida och skall undvikas. 
  String identifyEmail() {
    email = auth.currentUser.email;
    return auth.currentUser.email;
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
