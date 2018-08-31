import 'package:flutter/material.dart';
import 'package:demo_1/model/modes.dart';
import 'mode_row.dart';

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(child: new ModeRow(Modes[0], onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/GameHome', (Route<dynamic> route) => false);
            }
          ), height: 200.0),
          SizedBox(child: new ModeRow(Modes[1], onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/GameHome', (Route<dynamic> route) => false);
          }), height: 215.0,),
          SizedBox(child: new ModeRow(Modes[2], onPressed: (){
            Navigator.of(context).pushNamed('/ComingSoon');
          },), height: 200.0,),
        ],
      ),
    );
  }
}
