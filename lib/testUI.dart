import 'package:demo_1/theme_color.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
  home: new SignIn(),
));


class SignIn extends StatefulWidget {
  bool isLogged;
  String text;

  SignIn({this.isLogged = false, this.text = ''});

  @override
  SignInState createState() => new SignInState();
}

class SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
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
        clipper: new MyClipper(),
      ),
              

    ]));
  }
}

class MyClipper extends CustomClipper<Path>{

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
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;





}
