import 'package:flutter/material.dart';
import 'twopanels.dart';


class BackDrop extends StatefulWidget {
  @override
  _BackDropState createState() => _BackDropState();
}

class _BackDropState extends State<BackDrop> with SingleTickerProviderStateMixin {

  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 100),vsync: this);
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
        title: Text('BackDrop'),
        leading: IconButton(
            icon: AnimatedIcon(
                icon: AnimatedIcons.home_menu,
                progress: controller.view
            ),
            onPressed: (){
              controller.fling(velocity: isPanelVisible ? -1.0: 1.0);   //1.0 is the default value
            }),
      ),
      body: TwoPanels(controller: controller,),
    );
  }
}
