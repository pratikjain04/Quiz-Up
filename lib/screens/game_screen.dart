import 'package:flutter/material.dart';

class GameHome extends StatefulWidget {

  @override
  GameHomeState createState()=> GameHomeState();
}

class GameHomeState extends State<GameHome> with SingleTickerProviderStateMixin{

    List<Color> _color = new List();
    AnimationController controller;
    Animation<double> animation;

    @override
    void initState() {
      super.initState();
      for(int i = 1; i < 5; i++)
        _color.add(Colors.black54);
      controller = AnimationController(duration: Duration(milliseconds: 1800),vsync: this);
      animation =  CurvedAnimation(parent: controller, curve: Curves.bounceIn);

      controller.addListener(() => setState(() {}));
      controller.forward();
    }

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(image: AssetImage('images/darkthemeblue.jpg'), fit: BoxFit.cover,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 188.0,
                width: 350.0,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.white),
                gradient: LinearGradient(colors: <Color>[
                  Colors.black45,
                  Colors.black54
                  ])
                ),
                child: Center(
                  child: Text('Questions will be\n'
                      '\r\r\r\r\r\rput here',
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: (animation.value*25),
                      fontFamily: 'Raleway'
                      ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 30.0)),
              Container(
              height: 300.0,
              width: 300.0,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                elevation: 20.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.deepPurple,
                        Colors.deepPurpleAccent,
                        Colors.purple[300],
                        Colors.yellow
                      ]
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _color.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    child: Container(
                                      child: CircleAvatar(
                                        backgroundColor: _color[index],
                                        radius: 10.0,
                                        child: ClipOval(
                                          child: Material(
                                            color: _color[index],
                                            child: Icon(Icons.check, size: 15.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: (){
                                      setState(() {
                                        for(int i = 0; i < _color.length; i++)
                                          _color[i] = Colors.black54;
                                        if(_color[index] == Colors.black54)
                                          _color[index] = Colors.greenAccent;
                                        else if(_color[index] == Colors.greenAccent)
                                          _color[index] = Colors.black54;
                                      });
                                    },
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10.0)),
                                  Text('Option $index')
                                ],
                              ),
                            );
                          },
                        ),
                     )
                    ],
                  ),
                ),
              )
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            Container(
              height: 40.0,
              width: 120.0,
              child: RaisedButton(
                color: Colors.deepPurpleAccent,
                child: Text('Exit', style: TextStyle(color: Colors.white, fontSize: 22.0),),
                  onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
                }
              ),
            )
           ]
          ),
        ]
      )
    );
  }
}



