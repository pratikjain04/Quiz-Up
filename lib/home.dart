import 'package:flutter/material.dart';
import 'theme_color.dart';
import 'package:demo_1/backend/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


void main() => runApp(new MaterialApp(home: new Home(),));

class Home extends StatefulWidget{

  bool isLogged;
  String text;

  @override
  HomeState createState()=> HomeState();
  Home({this.isLogged, this.text});

}

class HomeState extends State<Home>{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  void _signOut() {
    googleSignIn.signOut();
    setState(() {
      widget.isLogged = false;
      widget.text = 'Signed out successfully';
    });
    print("User Signed out");
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: primaryColor,
        padding: new EdgeInsets.all(32.0),
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text("PlaceHolder"),
                ],
              ),
              Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: widget.isLogged ? _signOut : null,
                      color: Colors.blue,
                      child: Text('Sign out'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

