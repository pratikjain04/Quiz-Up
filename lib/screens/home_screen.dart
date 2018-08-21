import 'package:flutter/material.dart';


void main() => runApp(new MaterialApp(home: new GameHome(),));

class GameHome extends StatefulWidget{

  @override
  GameHomeState createState()=> GameHomeState();
}

class GameHomeState extends State<GameHome> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState(){
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 1800),vsync: this);
    animation =  CurvedAnimation(parent: controller, curve: Curves.bounceIn);

    controller.addListener(() => setState(() {}));
    controller.forward();
  }


  @override
  void dispose()
  {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
         Image(image: new AssetImage('images/darkthemeblue.jpg'),
         fit: BoxFit.cover,
         ),
         Column(
           children: <Widget>[
             Padding(padding: EdgeInsets.only(top: 50.0),),
             Container(
               height: 250.0,
               width: 500.0,
               decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                 border: Border.all(color: Colors.white),
                 gradient: LinearGradient(colors: <Color>[
                   Colors.black45,
                   Colors.black54
                 ])
               ),
              child: Text('Questions will be\n put here',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: (animation.value*14),
                ),),
             ),
           ],
         )
        ],
      ),
    );
  }
}



