import 'package:app/registerScreen.dart';
import 'package:app/resetPasswordScreen.dart';
import 'package:app/view/homePageView.dart';
import 'package:flutter/material.dart';
import 'package:app/networking/authentication.dart';

/*
Loginskärm som skall använda sig av autentication när man startar appen. 
*/

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Authentication auth = Authentication();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
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
                    child: Image.asset('assets/BeOs_logo.png')), //Logotype
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
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
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ResetPasswordScreen()));
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  String login;
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    login = await auth.signIn(
                        emailController.text, passwordController.text);
                    await auth.checkAuth();
                    if (login == 'Success') {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => MyHomePage()));
                      // print(auth.identifyEmail());
                    } else {
                      showAlertDialog(context, login);
                    }
                  } else {
                    showAlertDialog(
                        context, "You must enter both email and password.");
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RegisterScreen()));
              },
              child: Text(
                'New User? Create Account',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () async {
                await auth.signIn('test@testsson.se', 'testar');
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyHomePage()));
              },
              child: Text(
                'Debug',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            )
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
