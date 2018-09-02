import 'package:flutter/material.dart';
import 'package:demo_1/ui/home/home_page_body.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    Navigator.of(context).pushNamedAndRemoveUntil('/SignIn', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {

    double uni_height = MediaQuery.of(context).size.height;
    double uni_width = MediaQuery.of(context).size.width;

    return new Scaffold(
      body: OrientationBuilder(

        builder: (context, orientation) {
        return Container(
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
                  padding: EdgeInsets.only(top: uni_height / 64.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: uni_width / 5.14),),
                        Text('Game Modes',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 36.0),
                        ),
                      ],
                    ),
                  ),
                ),
                new HomePageBody(),
              ],
            ),
          );
        }
      ),
    );
  }
}


