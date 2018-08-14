import 'package:flutter/material.dart';

const Color primaryColor = const Color(0xFF8F66D6);
const Color accentColor = const Color(0xFFC2BDF0);

void main() => runApp(new MaterialApp(
  home: new Demo(),
  theme: ThemeData(
    primaryColor: primaryColor,
    accentColor: Colors.greenAccent,
  ),
));

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
      )
    );
  }
}
