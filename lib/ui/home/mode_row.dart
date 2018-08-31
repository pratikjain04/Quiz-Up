import 'package:flutter/material.dart';
import 'package:demo_1/model/modes.dart';

class ModeRow extends StatelessWidget {

  final Mode mode;
  final VoidCallback onPressed;

  ModeRow(this.mode, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    final modeThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
        vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: new AssetImage(mode.image),
        height: 92.0,
        width: 92.0,
      ),
    );

    final baseTextStyle = const TextStyle(
      fontFamily: 'Poppins'
    );
    final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 9.0,
      fontWeight: FontWeight.w400
    );
    final subHeaderTextStyle = regularTextStyle.copyWith(
      fontSize: 12.0
    );
    final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600
    );


    final modeCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(mode.name, style: headerTextStyle),
          new Container(height: 6.0),
          new Text(mode.description, style: subHeaderTextStyle),
          new Container(
            margin: new EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 18.0,
            color: new Color(0xff00c6ff)
          ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10.0)),
                elevation: 40.0,
                color: Colors.lightBlueAccent,
                splashColor: Colors.blue[600],
                child: Center(
                    child: Text('Play', style: TextStyle(color: Colors.white, fontSize: 22.0),)),
                onPressed: onPressed
                ),
        ],
      ),
    );


    final modeCard = new Container(
      child: modeCardContent,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );


    return new Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: new Stack(
        children: <Widget>[
          modeCard,
          modeThumbnail,
        ],
      )
    );
  }
}
