import 'dart:async';
import 'package:demo_1/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../home.dart';

void main() => runApp(new MaterialApp(
      home: new SignIn(),
      debugShowCheckedModeBanner: false,
    ));

class SignIn extends StatefulWidget {
  bool isLogged;
  String text;

  SignIn({this.isLogged = false, this.text = ''});

  @override
  SignInState createState() => new SignInState();
}

class SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount gSI = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await gSI.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);
    setState(() {
      widget.isLogged = true;
      widget.text = 'Signed in successfully';
    });
    print("User name: ${user.displayName}");
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new Home(
              isLogged: widget.isLogged,
              text: widget.text,
            )));
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Sign In Page'),
        ],
      )),
      body: Container(

        //gradient defined inside the BoxDecoration
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            gradient: LinearGradient(colors: <Color>[
              Colors.lightBlueAccent,
              Colors.lightBlue[400],
              Colors.blue[600]
            ])),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Center(
                  child: Container(
                    width: 330.0,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: widget.isLogged
                          ? null
                          : () => _signIn()
                              .then((FirebaseUser user) => print(user))
                              .catchError((e) => print(e)),
                      color: googleSignInColor,
                      child: Row(
                        children: <Widget>[
                          new Image(
                              image:
                                  new AssetImage('images/whitegooglelogo.png'),
                              height: 20.0,
                              width: 20.0),
                          new Padding(padding: EdgeInsets.all(25.0)),
                          new Text(
                            'Sign In with Google',
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Text(widget.text)
            ],
          ),
        ),
      ),
    );
  }
}
