import 'package:flutter/material.dart';

class LevelScreen extends StatefulWidget{

  @override
  LevelScreenState createState()=> LevelScreenState();
}


class LevelScreenState extends State<LevelScreen>{

  List<String> imageNames = <String>[
    'images/LevelsBackground/GoldBackground.jpeg',
    'images/LevelsBackground/SilverBackground.jpeg',
    'images/LevelsBackground/BronzeBackground.jpeg'
  ];


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: Stack(
       children: <Widget>[
         MediaQuery.removePadding(
           removeTop: true,
           context: context,
           child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index){
              return ListImage(imageNames[index], index);
            }),
         ),

         Padding(
           padding: const EdgeInsets.only(top: 8.0),
           child: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,),
             onPressed: (){
               Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
             },
           ),
         ),

        ],
      )
    );

  }


}

class ListImage extends StatelessWidget {

  List<int> levels = <int>[];
  String imageName;
  int image_index;
  ListImage(this.imageName, this.image_index);

  @override
  Widget build(BuildContext context) {

    for(int i =1; i<=25; i++){
      levels.add(i);
    }
    double uniheight = MediaQuery.of(context).size.height;
    double uniwidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Image(
          image: AssetImage(imageName),
          colorBlendMode: BlendMode.darken,
          color: Colors.black54,
        ),
        Padding(padding: EdgeInsets.only(left: uniwidth/2.25, top: uniheight/13),
        child: Container(
        //  color: Colors.transparent,
          height: uniheight/12.8,
          width: uniwidth/7.2,
          child: RaisedButton(
              child: Text('1'),
              splashColor: Colors.black54,
              shape: CircleBorder(),
              onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil('/GameHome', (Route<dynamic> route)=>false);
              }
          ),
        ),

        ),

        Padding(padding: EdgeInsets.only(left: uniwidth/21.2,top: uniheight/5.5),
        child: Container(
          height: uniheight/6.4,
          width: uniwidth/1.1,
          child: ListView.builder(
            shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 25,
              itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListLevels(levels[index], image_index),
                );
              }),
        ),
        )
      ],
    );
  }
}

class ListLevels extends StatelessWidget {

  int index;
  int level;
  ListLevels(this.level, this.index);

  @override
  Widget build(BuildContext context) {

    List<Color> colors = [Color(0xFFD5B900), Color(0xFFA1A1A1), Color(0xFFEB7335)];

    double uniheight = MediaQuery.of(context).size.height;
    double uniwidth = MediaQuery.of(context).size.width;

    return Container(
      //color: Colors.transparent,
      height: uniheight/12.8,
      width: uniwidth/7.2,
      child: RaisedButton(
        elevation: 10.0,
        color: colors[index],
        child: Text(level.toString()),
        splashColor: Colors.black54,
        shape: CircleBorder(),
        onPressed: (){
          Navigator.of(context).pushNamedAndRemoveUntil('/GameHome', (Route<dynamic> route)=>false);
        }
      ),
    );
  }
}

