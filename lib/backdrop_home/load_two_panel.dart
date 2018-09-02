import 'package:flutter/material.dart';
import 'twopanels.dart';

class BackDrop extends StatefulWidget {
  @override
  _BackDropState createState() => _BackDropState();
}

class _BackDropState extends State<BackDrop>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
          TwoPanels(),
      ]),
    );
  }
}
