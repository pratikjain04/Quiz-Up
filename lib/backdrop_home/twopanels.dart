import 'package:flutter/material.dart';
import 'package:demo_1/ui/home/home_page.dart';

class TwoPanels extends StatefulWidget{

  final AnimationController controller;
  TwoPanels({this.controller});

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> {

  static const header_height = 52.0;
  //For Sliding Effect

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints){
  //BoxConstraints for taking the complete space of its parent widget

    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    final frontPanelHeight = -header_height;

    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frontPanelHeight),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0)
    ).animate(new CurvedAnimation(parent: widget.controller, curve: Curves.linear));
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
          color: Colors.black54.withOpacity(0.75),
          child: Center(
              child: Text('Profile', style: TextStyle(fontSize: 24.0, color: Colors.white)),
            ),
          ),
          PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: Material(
              elevation: 12.0,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36.0),
                topRight: Radius.circular(36.0),
              ),
              //Front Panel Starts Here
              child: new HomePage()
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: bothPanels);
  }
}

