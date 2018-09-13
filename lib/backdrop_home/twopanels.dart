import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_1/ui/home/home_page_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TwoPanels extends StatefulWidget {
  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  static const header_height = 52.0;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DocumentReference documentReference;
  Map<String, int> data = null;

  FirebaseUser user;
  String displayName = null;
  String displayPhoto = null;
  
  double startDragY = 0.0;
  double dragY = 0.0;
  
  
  Future<FirebaseUser> _getUserData() async{
    user = await _auth.currentUser();
    return user;
  }
  
  //todo: create document for stars in firebase, and render trophies according to the stars fetched from the database
  //todo: modify the card, the normal and GRE Mode Current level area
  //TODO: Add Level Selection Page in Between Panel and gAME sCREEN


  void _onPanStart(DragStartDetails details) {
    startDragY = details.globalPosition.dy;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      dragY = startDragY - details.globalPosition.dy;
      controller.fling(velocity: (dragY < 0.0) ? -1.0 : 1.0);

    });
  }

  void _onPanEnd(DragEndDetails details) {
    startDragY = 0.0;
  }

  void _signOut() async {
    _auth.signOut().whenComplete(() {
      googleSignIn.signOut();
    });
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/SignIn', (Route<dynamic> route) => false);
  }
  
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    controller.fling(velocity: 1.0);
    
    _getUserData().then((user) {
        setState(() {
          displayName = user.displayName;
          documentReference = Firestore.instance.document('users/${displayName}');
          documentReference.get().then((datasnapshot){
            if(datasnapshot.exists){
              setState(() {
                data = <String, int>{
                  'GRELevels' : datasnapshot.data['GRELevels'],
                  'GREStars' : datasnapshot.data['GREStars'],
                  'GRETrophies' : datasnapshot.data['GRETrophies'],
                  'NormalLevels' : datasnapshot.data['NormalLevels'],
                  'NormalStars' : datasnapshot.data['NormalStars'],
                  'NormalTrophies' : datasnapshot.data['NormalTrophies'],
                };
              });
            } else {
              setState(() {
                data = <String, int>{
                  'GRELevels' : 0,
                  'GREStars' : 0,
                  'GRETrophies': 0,
                  'NormalLevels' : 0,
                  'NormalStars' : 0,
                  'NormalTrophies': 0,
                };
              });
              documentReference.setData(data);
            }
          });
          displayPhoto = user.photoUrl;
        });
      }).catchError((e){
        print(e);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  //For Sliding Effect

  Animation<RelativeRect> getPanelAnimation(
      BoxConstraints constraints, double padding) {
    //BoxConstraints for taking the complete space of its parent widget

    double height = (dragY >= padding)
        ? constraints.biggest.height - dragY
        : constraints.biggest.height;
    final backPanelHeight = height - header_height - padding;
    final frontPanelHeight = -header_height;

    return RelativeRectTween(
            begin: RelativeRect.fromLTRB(
                0.0, backPanelHeight, 0.0, frontPanelHeight),
            end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(new CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    double uni_height = MediaQuery.of(context).size.height;
    double uni_width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(
              image: AssetImage('images/PROFILE.jpeg'),
              colorBlendMode: BlendMode.darken,
              color: Colors.black54,
            ),
          ],
        ),
        Container(
          child: Padding(
              padding: EdgeInsets.only(top: uni_height / 32),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: AnimatedIcon(
                          icon: AnimatedIcons.home_menu,
                          progress: controller.view),
                      onPressed: () {
                        setState(() {
                          if (dragY > 0.0) dragY = 0.0;
                        });
                        controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
                      },
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: uni_width / 3.1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: uni_height / 42.66667),
                      child: Stack(children: <Widget>[
                        AnimatedOpacity(
                          opacity: isPanelVisible ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 500),
                          child: Text(
                            'Alpas',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: 'Nexa'),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: isPanelVisible ? 0.0 : 1.0,
                          duration: Duration(milliseconds: 500),
                          child: Text(
                            'Profile',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        )
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: uni_width / 4.25, top: uni_height / 32),
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: _signOut,
                      color: Colors.white,
                    )
                  ])),
        ),
        Padding(
          padding: EdgeInsets.only(top: uni_height / 3.2, left: uni_width / 95),
          child: Container(
            height: uni_height / 1.828,
            width: uni_width / 1.0285,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(top: uni_height/13.33),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //Firebase Integration HERE

                    displayName == null ? CircularProgressIndicator() :
                    Text(
                      displayName,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(top: 3.0)),
                    Text(
                      'Rookie',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54.withOpacity(0.70),
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                    //INTERNAL CARD

                    Padding(padding: EdgeInsets.only(top: uni_height/160.0)),
                    Container(
                      height: uni_height/5.8,
                      width: uni_width/1.12,
                      child: Card(
                        color: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        elevation: 20.0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FlutterLogo(size: (uni_height*uni_width)/3840.0),
                              Padding(
                                padding: EdgeInsets.only(left: uni_width/90, right: uni_width/27.692),
                                child: ClipOval(
                                  child: Container(
                                    height: uni_height/6.4,
                                    width: uni_width/180,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Levels',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: uni_width/25
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: uni_height/64),
                                    child: Text(
                                      'X',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top:  uni_height/64),
                                    child: (data != null) ? Text(
                                      data['NormalLevels'].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: uni_width/25
                                      ),
                                    ) : CircularProgressIndicator(),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: uni_width/27.692, right: uni_width/14.4),
                                child: ClipOval(
                                  child: Container(
                                    height: uni_height/6.4,
                                    width: uni_width/180,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage('images/star.png'),
                                    width: uni_width/15,
                                    height: uni_height/24,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: uni_height/64),
                                    child: Text(
                                      'X',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top:uni_height/64),
                                    child: (data != null) ? Text(
                                      data['NormalStars'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: uni_width/25
                                      ),
                                    ) : Container(
                                      child: CircularProgressIndicator(),
                                      height: 20.0,
                                      width: 20.0,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:  uni_width/15, right: uni_width/45),
                                child: ClipOval(
                                  child: Container(
                                    height: uni_height/6.4,
                                    width: uni_width/180,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Trophies',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: uni_width/25
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: uni_height/64),
                                    child: Text(
                                      'X',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: uni_height/64.0),
                                    child: (data != null) ? Row(
                                      children: <Widget>[
                                        (data['NormalTrophies'] >= 1) ? Image(
                                          image: AssetImage('images/trophies/bronze.png'),
                                          width: uni_width/15,
                                          height: uni_height/24,
                                        ) : Container(),
                                        (data['NormalTrophies'] >= 2) ? Image(
                                          image: AssetImage('images/trophies/silver.png'),
                                          width: uni_width/15,
                                          height: uni_height/24,
                                        ) : Container(),
                                        (data['NormalTrophies'] == 3) ? Image(
                                          image: AssetImage('images/trophies/gold.png'),
                                          width: uni_width/15,
                                          height: uni_height/24,
                                        ) : Container(),
                                      ]
                                    ) : CircularProgressIndicator(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: uni_height/64.0)),
                    Container(
                      height: uni_height/5.8,
                      width: uni_width/1.12,
                      child: Card(
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          elevation: 20.0,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                FlutterLogo(size: (uni_height*uni_width)/3840.0),
                                Padding(
                                  padding: EdgeInsets.only(left: uni_width/90, right: uni_width/27.692),
                                  child: ClipOval(
                                    child: Container(
                                      height: uni_height/6.4,
                                      width: uni_width/180,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Levels',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: uni_width/25
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: uni_height/64),
                                      child: Text(
                                        'X',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top:  uni_height/64),
                                      child: (data != null) ? Text(
                                        data['GRELevels'].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: uni_width/25
                                        ),
                                      ) : CircularProgressIndicator(),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: uni_width/27.692, right: uni_width/14.4),
                                  child: ClipOval(
                                    child: Container(
                                      height: uni_height/6.4,
                                      width: uni_width/180,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage('images/star.png'),
                                      width: uni_width/15,
                                      height: uni_height/24,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: uni_height/64),
                                      child: Text(
                                        'X',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top:uni_height/64),
                                      child: (data != null) ? Text(
                                        data['GREStars'].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: uni_width/25
                                        ),
                                      ) : Container(
                                        child: CircularProgressIndicator(),
                                        height: 20.0,
                                        width: 20.0,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left:  uni_width/15, right: uni_width/45),
                                  child: ClipOval(
                                    child: Container(
                                      height: uni_height/6.4,
                                      width: uni_width/180,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Trophies',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: uni_width/25
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: uni_height/64),
                                      child: Text(
                                        'X',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: uni_height/64.0),
                                      child: (data != null) ? Row(
                                        children: <Widget>[
                                          (data['GRETrophies'] >= 1) ? Image(
                                            image: AssetImage('images/trophies/bronze.png'),
                                            width: uni_width/15,
                                            height: uni_height/24,
                                          ) : Container(),
                                          (data['GRETrophies'] >= 2) ? Image(
                                            image: AssetImage('images/trophies/silver.png'),
                                            width: uni_width/15,
                                            height: uni_height/24,
                                          ) : Container(),
                                          (data['GRETrophies'] == 3) ? Image(
                                            image: AssetImage('images/trophies/gold.png'),
                                            width: uni_width/15,
                                            height: uni_height/24,
                                          ) : Container(),
                                        ]
                                      ) : CircularProgressIndicator(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: uni_width / 2.61, top: uni_height / 4.5),
          child: ClipOval(
            child: Container(
              height: 92.0,
              width: 92.0,
              child: _loadImage(),
            ),
          ),
        ),
        PositionedTransition(
          rect: getPanelAnimation(constraints, uni_height / 9.14),
          child: Padding(
            padding: EdgeInsets.only(top: uni_height / 9.14), //top: 70
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
                        padding: EdgeInsets.only(top: uni_height / 64.0),
                        child: GestureDetector(
                          onPanStart: _onPanStart,
                          onPanUpdate: _onPanUpdate,
                          onPanEnd: _onPanEnd,
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: uni_width / 5.14),
                                ),
                                Text(
                                  'Game Modes',
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

  Widget _loadImage(){
    Image image;
    try{

      image = Image.network(displayPhoto, fit: BoxFit.cover,);
      return image;
    } catch(e){
      print(e);
    }
    return CircularProgressIndicator();
  }


}