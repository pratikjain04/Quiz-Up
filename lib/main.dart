import 'package:flutter/material.dart';
import 'dart:async';
import 'package:demo_1/backend/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/game_screen.dart';
import 'screens/comingsoon.dart';
import 'backdrop_home//load_two_panel.dart';
import 'package:flutter/services.dart';



void main() {

 SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).whenComplete((){
   runApp(new MaterialApp(
     debugShowCheckedModeBanner: false,

     home: new Splash(),
     routes: <String, WidgetBuilder>{
       '/Home': (BuildContext context) => new BackDrop(),
       '/SignIn': (BuildContext context) => new SignIn(),
       '/GameHome': (BuildContext context) => new GameHome(),
       '/ComingSoon': (BuildContext context) => new ComingSoon()
     },
   ));
 });
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _auth.currentUser().then((user){
      if(user != null)
        Timer(Duration(milliseconds: 3200), () => Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false));
      else
        Timer(Duration(milliseconds: 3200), () => Navigator.of(context).pushNamedAndRemoveUntil('/SignIn', (Route<dynamic> route) => false ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            gradient: LinearGradient(colors: <Color>[
              Colors.lightBlueAccent,
              Colors.lightBlue[400],
              Colors.blue[600],
            ])),
        padding: EdgeInsets.all(32.0),
        child: Center(
            child: Container(
                height: 200.0,
                width: 100.0,
                child: Image(
                    image: AssetImage('images/whiteloader.gif')))
        ),
      ),
    );
  }
}

