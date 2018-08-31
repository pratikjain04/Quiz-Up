import 'package:flutter/material.dart';
import 'theme_color.dart';
import 'dart:async';
import 'package:demo_1/backend/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/game_screen.dart';
import 'screens/comingsoon.dart';
import 'ui/home/home_page.dart';
import 'demo/load_two_panel.dart';

void main() => runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: primaryColor,
    accentColor: accentColor,
  ),
  home: new Splash(),
  routes: <String, WidgetBuilder>{
    '/Home': (BuildContext context) => new BackDrop(),
    '/SignIn': (BuildContext context) => new SignIn(),
    '/GameHome': (BuildContext context) => new GameHome(),
    '/ComingSoon': (BuildContext context) => new ComingSoon()
  },
));

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

