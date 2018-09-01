import 'package:flutter/material.dart';
import 'twopanels.dart';
import 'package:demo_1/ui/home/home_page_body.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BackDrop extends StatefulWidget {
  @override
  _BackDropState createState() => _BackDropState();
}

class _BackDropState extends State<BackDrop> with SingleTickerProviderStateMixin {

  AnimationController controller;


  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signOut() async {
    _auth.signOut().whenComplete(() {
      googleSignIn.signOut();
    });
    Navigator.of(context).pushNamedAndRemoveUntil('/SignIn', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 100),vsync: this);
    controller.fling(velocity: 1.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //checking for backPanel Visibility
  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54.withOpacity(0.75),
        elevation: 0.0,
        title: Center(child: Text('Quiz-Up')),
        leading: IconButton(
            icon: AnimatedIcon(
                icon: AnimatedIcons.home_menu,
                progress: controller.view
            ),
            onPressed: (){
              controller.fling(velocity: isPanelVisible ? -1.0: 1.0);   //1.0 is the default value
            }),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: _signOut)
        ],
      ),
      body: TwoPanels(controller: controller,),
    );
  }
}
