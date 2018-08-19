import 'dart:async';
import 'package:demo_1/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {

  @override
  SignInState createState() => new SignInState();
}

class SignInState extends State<SignIn> {

  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future _signIn() async {
    GoogleSignInAccount gSI = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await gSI.authentication;

    _auth.signInWithGoogle(idToken: gSA.idToken, accessToken: gSA.accessToken).then((user){
      Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //gradient defined inside the BoxDecoration
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            gradient: LinearGradient(colors: <Color>[
              Colors.lightBlueAccent,
              Colors.lightBlue[400],
              Colors.blue[600],
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                          elevation: 30.0,
                          onPressed: _signIn,
                          color: googleSignInColor,
                          child: Row(
                            children: <Widget>[
                              Image(
                                  image: AssetImage('images/whitegooglelogo.png'),
                                  height: 20.0,
                                  width: 20.0),
                              Padding(padding: EdgeInsets.all(25.0)),
                              Text(
                                'Sign In with Google',
                                style: TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }
}
