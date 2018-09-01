import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: Page strictly under construction
// TODO: Add a timer
// TODO: Add a submit button
// TODO: More fleshed out UI

class GameHome extends StatefulWidget {

  @override
  GameHomeState createState() => GameHomeState();
}

class GameHomeState extends State<GameHome> with TickerProviderStateMixin{

    List<Color> _color = new List();
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
      controller = AnimationController(duration: Duration(milliseconds: 1800),vsync: this);
      animation =  CurvedAnimation(parent: controller, curve: Curves.bounceIn);
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
        _color.add(Colors.blue);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(image: AssetImage('images/darkthemeblue.jpg'), fit: BoxFit.cover,),
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
                        color: (loadinganim.value >= 0.0 && loadinganim.value < 1.0) ? Colors.blue : null,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.0,
                          color: Colors.blue
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: (loadinganim.value > 1.0 && loadinganim.value < 2.0)? 20.0 : 10.0,
                        height: (loadinganim.value > 1.0 && loadinganim.value < 2.0)? 20.0 : 10.0,
                        decoration: BoxDecoration(
                          color: (loadinganim.value > 1.0 && loadinganim.value < 2.0) ? Colors.blue : null,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.0,
                            color: Colors.blue
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: (loadinganim.value > 2.0 && loadinganim.value <= 3.0) ? 20.0 : 10.0,
                        height: (loadinganim.value > 2.0 && loadinganim.value <= 3.0) ? 20.0 : 10.0,
                        decoration: BoxDecoration(
                          color: (loadinganim.value > 2.0 && loadinganim.value <= 3.0) ? Colors.blue: null,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1.0,
                                color: Colors.blue
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _color.length,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: (options[index] != null) ? Opacity(
                      opacity: optionsOpacity[index].value,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 60.0,
                          color: _color[index],
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
                      ),
                    ) : Container(height: 60.0),
                  );
                },
              ),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              Container(
                height: 40.0,
                width: 120.0,
                child: RaisedButton(
                  color: Colors.deepPurpleAccent,
                  child: Text('Exit', style: TextStyle(color: Colors.white, fontSize: 22.0),),
                    onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
                  }
                ),
              )
            ]
          ),
        ]
      )
    );
  }
}