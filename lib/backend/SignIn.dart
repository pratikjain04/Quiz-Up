import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(new MaterialApp(
  home: new SignIn(),
  debugShowCheckedModeBanner: false,
));

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => new SignInState();
}

class SignInState extends State<SignIn>{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  bool _isLogged = false;
  String _text = '';

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount gSI = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await gSI.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken,
        accessToken: gSA.accessToken
    );
    setState((){
      _isLogged = true;
      _text = 'Signed in successfully';
    });
    print("User name: ${user.displayName}");
    return user;
  }

  void _signOut() {
    googleSignIn.signOut();
    setState(() {
      _isLogged = false;
      _text = 'Signed out successfully';
    });
    print("User Signed out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RaisedButton(
                onPressed: _isLogged ? null : () => _signIn().then((FirebaseUser user) => print(user)).catchError((e) => print(e)),
                color: Colors.green,
                child: Text('Sign In'),
              ),
            ),
            RaisedButton(
              onPressed: _isLogged ? _signOut : null,
              color: Colors.red,
              child: Text('Sign out'),
            ),
            Text(_text)
          ],
        ),
      ),
    );
  }
}