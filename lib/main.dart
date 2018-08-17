import 'package:flutter/material.dart';
import 'theme_color.dart';
import 'home.dart';
import 'dart:async';
import 'package:demo_1/backend/SignIn.dart';

void main() => runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: primaryColor,
    accentColor: accentColor,
  ),
  home: new Splash(),
  routes: <String, WidgetBuilder>{
    '/Splash' : (BuildContext context) => new Splash(),
    '/Home': (BuildContext context) => new Home(),
    '/SignIn': (BuildContext context) => new SignIn(),
  },
));


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 6200) , () => Navigator.of(context).pushNamedAndRemoveUntil('/SignIn', (Route<dynamic> route) => false ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: loaderColor,
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
