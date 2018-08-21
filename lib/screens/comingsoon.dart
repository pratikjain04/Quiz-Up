import 'package:flutter/material.dart';


void onPressed(){       //Just to make tapping work.
  print('Pressed');
}

class ComingSoon extends StatefulWidget {
  @override
  ComingSoonState createState() => new ComingSoonState();
}

class ComingSoonState extends State<ComingSoon> {
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: new Text(
            'Coming Soon',
            style: new TextStyle(
              color: Colors.white,
              fontFamily: 'Raleway',      //need to add fonts in fonts folder and also specify in pubspec.yaml
              fontStyle: FontStyle.italic,
            ),),
        ),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.search, color: Colors.white,), onPressed: (){onPressed();}),
          new IconButton(icon: new Icon(Icons.more_vert, color: Colors.white), onPressed: (){onPressed();}),
        ],


      ),
      body: Center(
        child: new Container(
          padding: new EdgeInsets.symmetric(vertical: 175.0),
          child: Center(
            child: new Column(
              children: <Widget>[
                Image.asset('images/smiley.png', height: 75.0,width: 75.0),
                Padding(padding: EdgeInsets.only(top: 20.0),),
                new Text(
                  'Coming Soon',
                  softWrap: true,
                  style: new TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),),
                Padding(padding: EdgeInsets.only(top: 20.0),),
                new Text('Under Development'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
