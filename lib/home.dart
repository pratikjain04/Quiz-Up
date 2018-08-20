import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signOut() async {
    _auth.signOut().whenComplete(() {
      googleSignIn.signOut();
    });
    Navigator
        .of(context)
        .pushNamedAndRemoveUntil('/SignIn', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: new AssetImage('images/bluebrickwall.jpg'),
            fit: BoxFit.cover,

          ),

           Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 220.0,
                  child: RaisedButton(
                    onPressed: _signOut,
                    color: Colors.blue,
                    child: Text('Sign Out',
                        style:
                            new TextStyle(color: Colors.white, fontSize: 18.0)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
