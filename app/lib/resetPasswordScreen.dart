import 'package:app/loginscreen.dart';
import 'package:app/view/widgets/themeBlack.dart';
import 'package:flutter/material.dart';
import 'package:app/networking/authentication.dart';

///Skärm för att nollställa lösenord som skall använda sig av autentication när man startar appen.

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  Authentication auth = Authentication();
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Reset password"),
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
            SizedBox(height: 30),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: primaryYellow,
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  await auth.resetPassword(emailController.text);
                  await auth.checkAuth();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                },
                child: Text(
                  'Reset',
                  style: TextStyle(color: primaryBlackLight, fontSize: 25),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 150, right: 280),
              child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: const Text('Return'),
                  icon: const Icon(Icons.keyboard_return),
                  backgroundColor: primaryBlackLight),
            ),
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
