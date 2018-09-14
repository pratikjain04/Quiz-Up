import 'package:flutter/material.dart';

class LevelScreen extends StatefulWidget {
  @override
  _LevelScreen createState() => new _LevelScreen();
}

class _LevelScreen extends State<LevelScreen> with TickerProviderStateMixin {
  TabController _controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {
          currentIndex = _controller.index;
        });
      });
  }

  List<String> imageNames = <String>[
    'images/bgrdimage.jpeg',
    'images/LevelsBackground/SilverBackground.jpeg',
    'images/LevelsBackground/BronzeBackground.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    final double uni_width = MediaQuery.of(context).size.width;
    final double uni_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(children: <Widget>[
        Positioned.fill(
          child: Image.asset(imageNames[0], fit: BoxFit.fill),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: uni_width / 41.1, top: uni_height / 24.36, bottom: uni_height / 24.36),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25.0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 30.0),
                      onPressed: (){
                        Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
                      }
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed('/GameHome');
                          },
                          child: Container(
                            height: uni_height / 14.62,
                            width: uni_width / 1.28,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('Current Level: ', style: TextStyle(fontFamily: 'Nexa', fontStyle: FontStyle.italic)),
                                  Padding(
                                    padding: EdgeInsets.only(left: uni_width/51.37, right: uni_width/41.1),
                                    child: Text('1', style: TextStyle(fontFamily: 'Nexa', fontWeight: FontWeight.bold, fontSize: 18.0)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: uni_width/51.37),
                                    child: Text('Stars Achieved: ', style: TextStyle(fontFamily: 'Nexa', fontStyle: FontStyle.italic)),
                                  ),
                                  FractionalTranslation(translation: Offset(0.0, -0.2),child: Image.asset('images/star.png', height: uni_height / 36.55, width: uni_width / 20.55)),
                                  FractionalTranslation(translation: Offset(0.0, -0.2),child: Image.asset('images/star.png', height: uni_height / 36.55, width: uni_width / 20.55)),
                                  FractionalTranslation(translation: Offset(0.0, -0.2),child: Image.asset('images/star.png', height: uni_height / 36.55, width: uni_width / 20.55)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
            Expanded(
              child: Container(
                child: TabBarView(controller: _controller, children: <Widget>[
                  Scrollbar(
                    child: ListView.builder(
                        itemCount: 25,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: <Widget>[
                            Container(
                              height: uni_height / 2.924,
                              width: uni_width / 1.02,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: (index == 0) ? uni_height / 36.55 : uni_height / 18.27,
                                    left: uni_width / 41.1,
                                    right: uni_width / 41.1,
                                    bottom: (index == 0) ? uni_height / 12.1 : uni_height / 18.27),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pushNamed('/GameHome');
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10.0),
                                                  child: Container(
                                                    height: 2.0,
                                                    width: uni_width / 2.9,
                                                    color: Colors.blue,
                                                  )),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: Text(
                                                  '${(index + 1).toString()}',
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Nexa'),
                                                ),
                                              ),
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10.0),
                                                  child: Container(
                                                    height: 2.0,
                                                    width: uni_width / 2.9,
                                                    color: Colors.blue,
                                                  )
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Text(
                                              'Stars Achieved:',
                                              style: TextStyle(
                                                fontFamily: 'Nexa',
                                                fontStyle: FontStyle.italic,
                                                fontSize: 20.0
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          (index < 24) ? ClipOval(
                              child: Container(
                                color: Colors.black45,
                                height: 2.0,
                                width: uni_width / 1.37,
                              ),
                            ) : Container()
                          ]);
                        }),
                  ),
                  Scrollbar(
                    child: ListView.builder(
                        itemCount: 25,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: <Widget>[
                            Container(
                              height: uni_height / 2.924,
                              width: uni_width / 1.02,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: (index == 0) ? uni_height / 36.55 : uni_height / 18.27,
                                    left: uni_width / 41.1,
                                    right: uni_width / 41.1,
                                    bottom: (index == 0) ? uni_height / 12.1 : uni_height / 18.27),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(30.0)),
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                child: Container(
                                                  height: 2.0,
                                                  width: uni_width / 2.9,
                                                  color: Colors.blue,
                                                )),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Text(
                                                '${(index + 1).toString()}',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Nexa'),
                                              ),
                                            ),
                                            ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                child: Container(
                                                  height: 2.0,
                                                  width: uni_width / 2.9,
                                                  color: Colors.blue,
                                                )
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            'Stars Achieved:',
                                            style: TextStyle(
                                                fontFamily: 'Nexa',
                                                fontStyle: FontStyle.italic,
                                                fontSize: 20.0
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            (index < 24) ? ClipOval(
                              child: Container(
                                color: Colors.black45,
                                height: 2.0,
                                width: uni_width / 1.37,
                              ),
                            ) : Container()
                          ]);
                        }),
                  ),
                  Scrollbar(
                    child: ListView.builder(
                        itemCount: 25,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: <Widget>[
                            Container(
                              height: uni_height / 2.924,
                              width: uni_width / 1.02,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: (index == 0) ? uni_height / 36.55 : uni_height / 18.27,
                                    left: uni_width / 41.1,
                                    right: uni_width / 41.1,
                                    bottom: (index == 0) ? uni_height / 12.1 : uni_height / 18.27),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(30.0)),
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                child: Container(
                                                  height: 2.0,
                                                  width: uni_width / 2.9,
                                                  color: Colors.blue,
                                                )),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Text(
                                                '${(index + 1).toString()}',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Nexa'),
                                              ),
                                            ),
                                            ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                child: Container(
                                                  height: 2.0,
                                                  width: uni_width / 2.9,
                                                  color: Colors.blue,
                                                )
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            'Stars Achieved:',
                                            style: TextStyle(
                                                fontFamily: 'Nexa',
                                                fontStyle: FontStyle.italic,
                                                fontSize: 20.0
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            (index < 24) ? ClipOval(
                              child: Container(
                                color: Colors.black45,
                                height: 2.0,
                                width: uni_width / 1.37,
                              ),
                            ) : Container()
                          ]);
                        }),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: uni_height / 48.73),
              child: Container(
                child: TabBar(
                  isScrollable: true,
                  controller: _controller,
                  tabs: <Widget>[
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.only(right: uni_width / 20.55),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                              child: Image.asset('images/bronzemedal.png')),
                        ),
                      ),
                    ),
                    Tab(
                        child: Padding(
                      padding: EdgeInsets.only(right: uni_width / 20.55),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          child: Image.asset('images/silvermedal.png'),
                        ),
                      ),
                    )),
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.only(right: uni_width / 20.55),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            child: Image.asset('images/goldmedal.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                  indicator: CustomTabIndicator(),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class CustomTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([onChanged]) {
    return _CustomBoxPainter(this, onChanged);
  }
}

class _CustomBoxPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CustomBoxPainter(this.decoration, VoidCallback onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    //final indicatorHeight = 20.0;
    final Paint paint = new Paint();
    paint.color = Colors.white;
    //paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3.0;
    paint.strokeCap = StrokeCap.round;
    canvas.drawCircle(
        Offset(offset.dx + (configuration.size.width / 3),
            configuration.size.height / 2),
        5.0,
        paint);
  }
}
