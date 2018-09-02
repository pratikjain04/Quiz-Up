import 'package:flutter/material.dart';
import 'package:demo_1/ui/home/home_page_body.dart';

class HomePage extends StatefulWidget{

  ValueSetter<double> func;

  HomePage({this.func});

  @override
  HomePageState createState() => HomePageState();
}


class HomePageState extends State<HomePage> {
  double startDragY;
  double dragY;

  void _onPanStart(DragStartDetails details){
    startDragY = details.globalPosition.dy;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      dragY = startDragY - details.globalPosition.dy;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    startDragY = null;
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
              padding: const EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: Container(
                  child: Row(
                    children: <Widget>[
                     Padding(padding: EdgeInsets.only(left: 70.0),),
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
            ),
            new HomePageBody(),
          ],
        ),
      ),
    );
  }
}


