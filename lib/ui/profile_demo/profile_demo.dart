import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(image: AssetImage('images/profile_background.jpg')),
          ],
        ),

        //APP BAR CONTAINER
        Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 100.0),
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
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 110.0),
            ),
            Container(
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
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(left: 135.0, top: 135.0),
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
        )
      ],
    ));
  }
}
