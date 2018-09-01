import 'package:flutter/material.dart';
import 'twopanels.dart';

class BackDrop extends StatefulWidget {
  @override
  _BackDropState createState() => _BackDropState();
}

class _BackDropState extends State<BackDrop>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.black54.withOpacity(0.75),
        elevation: 0.0,
        title: Center(child: Text('Quiz-Up')),
        leading: IconButton(
            icon: AnimatedIcon(
                icon: AnimatedIcons.home_menu, progress: controller.view),
            onPressed: () {
              controller.fling(
                  velocity:
                      isPanelVisible ? -1.0 : 1.0); //1.0 is the default value
            }),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: _signOut)
        ],
      ),*/
      body: Stack(children: <Widget>[
          TwoPanels(),
      ]),
    );
  }
}
