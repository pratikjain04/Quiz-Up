import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: Page strictly under construction
// TODO: Add a timer
// TODO: Add a submit button
// TODO: More fleshed out UI
// Todo: Add Current Level icon in game screen

class GameHome extends StatefulWidget {

  @override
  GameHomeState createState() => GameHomeState();
}

class GameHomeState extends State<GameHome> with TickerProviderStateMixin{

    List<Color> _colors = new List();
    AnimationController controller;
    AnimationController c_loading;
    List<AnimationController> c_options = [null, null, null, null];
    List<Animation<double>> optionsOpacity = [null, null, null, null];
    Animation<double> loadinganim;
    Animation<double> animation;
    DocumentReference documentReference = Firestore.instance.document("questions/FirstQuestion");
    String question;
    List<String> options = [null, null, null, null];

    @override
    void initState() {
      super.initState();
      controller = AnimationController(duration: Duration(milliseconds: 500),vsync: this);
      animation =  CurvedAnimation(parent: controller, curve: Curves.linear);
      controller.addListener(() => setState(() {}));
      documentReference.get().then((datasnap){
        if(datasnap.exists){
          setState(() {
            question = datasnap.data['name'];
            controller.forward();
          });
        }
      });
      for(int i = 0; i < 4; i++){
        c_options[i] = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
        optionsOpacity[i] = Tween(begin: 0.0, end: 1.0).animate(c_options[i]);
        c_options[i].addListener(() => setState((){}));
        if(i != 3){
          c_options[i].addStatusListener((status){
            if(status == AnimationStatus.completed)
              c_options[i+1].forward();
          });
        }
      }

      documentReference = Firestore.instance.document("questions/FirstQuestion/options/allOptions");
      documentReference.get().then((datasnap){
        if(datasnap.exists){
          for(int i = 0; i < 4; i++){
            options[i] = datasnap.data['Option ${i+1}'];
          }
          c_options[0].forward();
        }
      });


      for(int i = 1; i < 5; i++)
        _colors.add(null);
      c_loading = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
      loadinganim = Tween(begin: 0.0, end: 3.0).animate(c_loading);
      c_loading.addListener(()=> setState((){}));
      c_loading.addStatusListener((status){
        if(status == AnimationStatus.completed) {
          c_loading.reset();
          c_loading.forward();
        }
      });
      c_loading.forward();
    }

    @override
    void dispose() {
      controller.dispose();
      c_loading.dispose();
      for(int i = 0; i < 4; i++)
        c_options[i].dispose();
      super.dispose();
    }

    bool _isChecked() {
      for(int i = 0; i < 4; i++){
        if(_colors[i] == Color(0xFFF9E694))
          return true;
      }
      return false;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(image: AssetImage('images/GRE_Background.jpeg'),
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black54,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (question != null) ? Container(
                height: 100.0,
                width: 300.0,
                child: Text(
                  question,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Raleway',
                    fontSize: animation.value * 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ) : Container(
                height: 100.0,
                width: 300.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: (loadinganim.value >= 0.0 && loadinganim.value <1.0) ? 20.0 : 10.0,
                      width: (loadinganim.value >= 0.0 && loadinganim.value <1.0)? 20.0 : 10.0,
                      decoration: BoxDecoration(
                        color: (loadinganim.value >= 0.0 && loadinganim.value < 1.0) ? Color(0xFFF9E694) : null,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.0,
                          color: Colors.amber[700],                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: (loadinganim.value > 1.0 && loadinganim.value < 2.0)? 20.0 : 10.0,
                        height: (loadinganim.value > 1.0 && loadinganim.value < 2.0)? 20.0 : 10.0,
                        decoration: BoxDecoration(
                          color: (loadinganim.value > 1.0 && loadinganim.value < 2.0) ? Color(0xFFF9E694) : null,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.0,
                            color: Colors.amber[700],                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: (loadinganim.value > 2.0 && loadinganim.value <= 3.0) ? 20.0 : 10.0,
                        height: (loadinganim.value > 2.0 && loadinganim.value <= 3.0) ? 20.0 : 10.0,
                        decoration: BoxDecoration(
                          color: (loadinganim.value > 2.0 && loadinganim.value <= 3.0) ?Color(0xFFF9E694): null,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1.0,
                               color: Colors.amber[700],
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _colors.length,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: (options[index] != null) ? Opacity(
                      opacity: optionsOpacity[index].value,
                        child: GestureDetector(
                          onTap: (){
                            for(int i = 0; i < 4; i++)
                              _colors[i] = Color(0xFFF9E694);
                            _colors[index] = Colors.amber[700];
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                width: 3.0,
                                color: Colors.amber[700]
                              ),
                              color: Color(0xFFF9E694)
                            ),
                            height: 60.0,
                            child: Stack(
                              children: <Widget>[
                            Container(
                              height: 60.0,
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    options[index],
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600
                                    ),
                                  )
                                ],
                              ),
                            ),
                                AnimatedOpacity(
                                opacity: (_colors[index] == Colors.amber[700]) ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 500),
                                child: Container(
                                  height: 60.0,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: _colors[index],
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          options[index],
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]
                            ),
                          ),
                        ),
                    ) : Container(height: 60.0),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30.0,
                        child: Material(
                          shape: CircleBorder(),
                          color: Colors.redAccent,
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              color: Colors.white,
                              iconSize: 30.0,
                              onPressed: (){
                                Navigator.of(context).pushNamedAndRemoveUntil('/Levels', (Route<dynamic> route) => false);
                              },
                            ),
                          ),
                        )
                    ),
                    Expanded(child: Container()),
                    CircleAvatar(
                      radius: 30.0,
                      child: Material(
                        color: (_isChecked()) ? Colors.green : null,
                        shape: CircleBorder(),
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.arrow_forward),
                            color: Colors.white,
                            iconSize: 30.0,
                            onPressed: (_isChecked()) ? (){} : null
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]
          ),
        ]
      )
    );
  }
}