import 'package:app/view/homePageView.dart';
import 'package:app/view/widgets/themeBlack.dart';
import 'package:flutter/material.dart';
import 'package:app/networking/authentication.dart';

///Registreringsskärm som skall använda sig av autentication när man startar appen.

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Authentication auth = Authentication();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextStyle yellowText = new TextStyle(color: primaryYellow);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Register account",
          style: yellowText,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/logo.png')), //Logotype
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryYellow),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryYellow),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryYellow),
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as john.doe@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryYellow),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryYellow),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryYellow),
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            SizedBox(height: 50),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: primaryYellow,
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  await auth.signOut();
                  String register;
                  register = await auth.signUp(
                      emailController.text, passwordController.text);
                  if (register == 'Success') {
                    await auth.signIn(
                        emailController.text, passwordController.text);
                    await auth.checkAuth();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MyHomePage()));
                  } else {
                    showAlertDialog(context, register);
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: primaryBlackLight, fontSize: 25),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 55, right: 280),
              //  child: Align(
              //  alignment: Alignment.bottomLeft,
              child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  foregroundColor: primaryYellow,
                  label: const Text('Return'),
                  icon: const Icon(Icons.keyboard_return),
                  backgroundColor: primaryBlackLight),
            ),
            //   )
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
