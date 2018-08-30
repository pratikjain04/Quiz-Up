import 'dart:async';
import 'package:demo_1/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState(){
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 2300),vsync: this);
    animation =  CurvedAnimation(parent: controller, curve: Curves.decelerate);
    
    controller.addListener(() => setState(() {}));
    controller.forward();
  }

  @override
  void dispose()
  {
    controller.dispose();
    super.dispose();
  }

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
      body: Stack(fit: StackFit.expand, children: <Widget>[
        ClipPath(
          child: Container(
            //gradient defined inside the BoxDecoration
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                gradient: LinearGradient(colors: <Color>[
                  Colors.lightBlueAccent,
                  Colors.lightBlue[400],
                  Colors.blue[600],
                ])),
          ),
          clipper: SignInClipper(),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 100.0),
            ),
            FlutterLogo(
              size: (animation.value * 90),
            ),
            Padding(padding: EdgeInsets.only(top: 40.0)),
            Text(
              "Quiz Up",
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold),
            ),


            Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Center(
                child: Container(
                  width: 330.0,
                  height: 50.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    elevation: 30.0,
                    onPressed: () => _signIn().catchError((e) => print(e)),
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
      ]),
    );  }
}

class SignInClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.moveTo(0.0, size.height);
    path.lineTo(0.0, size.height - 150.0);
    path.lineTo(size.width, size.height - 510.0);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
