import 'package:flutter/material.dart';
import 'main.dart';
import 'package:app/networking/authentication.dart';

/*
Registreringsskärm som skall använda sig av autentication när man startar appen. 
*/

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  Authentication auth = Authentication();
    TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register account"),
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
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  await auth.signUp(emailController.text, passwordController.text);
                  await auth.signIn(emailController.text, passwordController.text);
                  await auth.checkAuth();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MyHomePage())); //TODO Åberopa authentication för login.
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}