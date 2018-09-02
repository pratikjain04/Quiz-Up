import 'package:demo_1/ui/home/home_page_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo_1/ui/home/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TwoPanels extends StatefulWidget{

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> with SingleTickerProviderStateMixin{

  AnimationController controller;

  static const header_height = 52.0;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  double startDragY = 0.0;
  double dragY = 0.0;

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

  void _signOut() async {
    _auth.signOut().whenComplete(() {
      googleSignIn.signOut();
    });
    Navigator
        .of(context)
        .pushNamedAndRemoveUntil('/SignIn', (Route<dynamic> route) => false);
  }

  @override
  void initState(){
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    controller.fling(velocity: 1.0);
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }
  //For Sliding Effect

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints, double padding){
  //BoxConstraints for taking the complete space of its parent widget

    final height = constraints.biggest.height - dragY;
    final backPanelHeight = height - header_height - padding;
    final frontPanelHeight = -header_height;

    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frontPanelHeight),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0)
    ).animate(new CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image(image: AssetImage('images/profile_background.jpg')),
            ],
          ),
          Container(
            child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: AnimatedIcon(
                            icon: AnimatedIcons.home_menu,
                            progress: controller.view),
                        onPressed: () {
                          controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
                        },
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 130.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          'Profile',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 108.0, top: 20.0),
                      ),
                      IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: _signOut,
                        color: Colors.white,
                      )
                    ])),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0, left: 25.0),
            child: Container(
              height: 350.0,
              width: 350.0,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Pratik Jain', style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),),
                      Padding(padding: EdgeInsets.only(top: 3.0)),
                      Text(
                        'Rookie',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black54.withOpacity(0.70),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(left: 40.0)),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text('120', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                          ),
                          Padding(padding: EdgeInsets.only(left: 140.0)),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text('T', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                          ),

                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index){
                            return Row(
                              children: <Widget>[
                                Text('Normal Icon'),
                                Padding(
                                  padding: EdgeInsets.only(left: 40.0),
                                ),
                                Text('Current Level: 20'),
                              ],
                            );
                          },
                          itemCount: 2,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 150.0, top: 135.0),
            child: ClipOval(
              child: Container(
                height: 92.0,
                width: 92.0,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage('images/profile_background.jpg'),
                ),
              ),
            ),
          ),
          PositionedTransition(
            rect: getPanelAnimation(constraints, 70.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Material(
                elevation: 12.0,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36.0),
                  topRight: Radius.circular(36.0),
                ),
                //Front Panel Starts Here
                child: Scaffold(
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
                ),
              ),
            ),
          )
        ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: bothPanels);
  }
}

