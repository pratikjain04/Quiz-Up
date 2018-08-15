import 'package:flutter/material.dart';
import 'theme_color.dart';
import 'home.dart';
import 'dart:async';

void main() => runApp(new MaterialApp(
  theme: ThemeData(
    primaryColor: primaryColor,
    accentColor: accentColor,
  ),
  home: new Splash(),
  routes: <String, WidgetBuilder>{
    '/Splash' : (BuildContext context) => new Splash(),
    '/Home': (BuildContext context) => new Home(),
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
    Timer(Duration(seconds: 5) , () => Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false ));

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: primaryColor),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.book,
                          color: accentColor,
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        'Word Power',
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text("Word Game \nFor Everyone",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),),

                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
