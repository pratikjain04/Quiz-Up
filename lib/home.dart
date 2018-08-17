import 'package:flutter/material.dart';
import 'package:demo_1/backend/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget{

  bool isLogged;
  String text;

  @override
  HomeState createState()=> HomeState();
  Home({this.isLogged, this.text});

}

class HomeState extends State<Home>{

  final GoogleSignIn googleSignIn = new GoogleSignIn();

  void _signOut() {
    googleSignIn.signOut();
    setState(() {
      widget.isLogged = false;
      widget.text = 'Signed out successfully';
    });
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SignIn(isLogged: widget.isLogged, text: widget.text)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.cyan,
        padding: new EdgeInsets.all(32.0),
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text(""),
                ],
              ),
              Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 220.0,
                      child: RaisedButton(
                        onPressed: widget.isLogged ? _signOut : null,
                        color: Colors.blue,
                        child: Text('Sign out', style: new TextStyle(color: Colors.white, fontSize: 18.0) ),
                      ),
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


