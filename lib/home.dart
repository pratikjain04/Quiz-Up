import 'package:flutter/material.dart';
import 'theme_color.dart';

void main() => runApp(new MaterialApp(home: new Home(),));

class Home extends StatefulWidget{

  @override
  HomeState createState()=> HomeState();
}

class HomeState extends State<Home>{

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
                      new Text('Quiz Questions here: '),
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

