import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:demo_1/ui/home/home_page_body.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';



//Todo: Add Buttons, and Functionality in each
//Todo: Add Modal for Profile Page, 3rd Card , and render a new page for the other two


class HomePage extends StatefulWidget{

  @override
  HomePageState createState() => HomePageState();
}


class HomePageState extends State<HomePage> {

  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signOut() async {
    _auth.signOut().whenComplete(() {
      googleSignIn.signOut();
    });
  //  Navigator.of(context).pushNamedAndRemoveUntil('/SignIn', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            gradient: LinearGradient(colors: <Color>[
              Colors.lightBlueAccent,
              Colors.lightBlue[400],
              Colors.blue[600],
            ])),
        child: new Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Container(
                child: Row(

                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 100.0),),
                       Text('Quiz-Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 36.0),),

                    Padding(padding: EdgeInsets.only(left: 70.0)),
                    IconButton(
                      icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 36.0,
                    ),
                     onPressed: _signOut
                   )
                  ],
                ),
              ),
            ),
            new HomePageBody(),
          ],
        ),
      ),
    );


  }


}


