import 'package:flutter/material.dart';
import 'package:demo_1/model/modes.dart';
import 'mode_row.dart';

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double uni_height = MediaQuery.of(context).size.height;
    double uni_width = MediaQuery.of(context).size.width;


    return Expanded(
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(child: new ModeRow(Modes[0], onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/Levels', (Route<dynamic> route) => false);
            }
          ), height: uni_height/2.7234),
          SizedBox(child: new ModeRow(Modes[1], onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/Levels', (Route<dynamic> route) => false);
          }), height: uni_height/2.56,),
          Padding(padding: EdgeInsets.only(top: uni_height/13),),
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: uni_width/30)),
              Container(
                height: uni_height/16,
                width: uni_width/2.2781,
                child: RaisedButton(
                  splashColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                    child: Text('How to Play',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: uni_width/16.36,
                          fontFamily: 'Poppins'
                      ),),
                    elevation: 20.0,
                    color: Color(0xFF333366),
                    onPressed: (){},
                ),
              ),
              Padding(padding: EdgeInsets.only(left: uni_width/17)),
              Container(
                height: uni_height/16,
                width: uni_width/2.32258,
                child: RaisedButton(
                  splashColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text('Settings',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: uni_width/16.36,
                        fontFamily: 'Poppins'
                    ),),
                  elevation: 20.0,
                  color: Color(0xFF333366),
                  onPressed: (){},
                ),
              ),
           //   Padding(padding: EdgeInsets.only(right: uni_width/12)),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: uni_height/13),),
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: uni_width/30)),
              Container(
                height: uni_height/16,
                width: uni_width/2.32258,
                child: RaisedButton(
                  splashColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text('About Us',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: uni_width/16.36,
                        fontFamily: 'Poppins'
                    ),),
                  elevation: 20.0,
                  color: Color(0xFF333366),
                  onPressed: (){},
                ),
              ),
              Padding(padding: EdgeInsets.only(left: uni_width/17)),
              Container(
                height: uni_height/16,
                width: uni_width/2.32258,
                child: RaisedButton(
                  splashColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text('Rate Us', style: TextStyle(
                      color: Colors.white,
                      fontSize: uni_width/16.36,
                      fontFamily: 'Poppins'
                  ),),
                  elevation: 20.0,
                  color: Color(0xFF333366),
                  onPressed: (){},
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: uni_height/16)),
        ],
      ),
    );
  }
}
