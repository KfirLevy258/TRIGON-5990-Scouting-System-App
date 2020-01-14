
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ScoutingAutonomousPeriod.dart';

class ScoutingPreGameScreen extends StatefulWidget{
  final String teamName;
  final String teamNumber;
  final String tournament;
  final String qualNumber;
  final String userId;

  ScoutingPreGameScreen({Key key, @required this.teamName, this.teamNumber, this.tournament, this.qualNumber, this.userId}) : super(key:key);

  @override
  ScoutingPreGameScreenState createState() => ScoutingPreGameScreenState();
}

class ScoutingPreGameScreenState extends State<ScoutingPreGameScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    return Scaffold(
        appBar: AppBar(
        title: Text(
        "Pre game: " + widget.teamNumber + ' - ' + widget.teamName,
        textAlign: TextAlign.center,
        ),
      ),
    body: ListView(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(15),),
        Center(
          child: Stack(
            children: <Widget>[
              Container(
                child: GestureDetector(
                  child: Image.asset(
                      'assets/StartingPosition.png',
                    fit: BoxFit.fill,
                  ),
                  onTapDown: ((details)  {
                    final Offset offset = details.localPosition;
                    print(offset);
//                            if (offset.dx > 40 && offset.dx < 170 && offset.dy > 45 && offset.dy < 160)
//                              showDialog(
//                                  context: context,
//                                  builder: (_) {
//                                    return UpperScoreDialog(message: 'UpperPort',
//                                        scoreResult: ((score1, score2) {
//                                          upperScoreInner = upperScoreInner + score1;
//                                          upperScoreOuter = upperScoreOuter + score2;
//                                        }));
//                                  }
//                              );
//
//                            if (offset.dx > 25 && offset.dx < 180 && offset.dy > 310 && offset.dy < 390)
//                              showDialog(
//                                  context: context,
//                                  builder: (_) {
//                                    return BottomScoreDialog(message: 'Bottom Port',
//                                        scoreResult: ((score) {bottomScore = bottomScore + score;}));
//                                  }
//                              );
                  }),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(15),),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 15,
                        ),
                        startPosition('Left position', Colors.blue, (width-30)/3, 100),
                        startPosition('Middle position', Colors.red, (width-30)/3, 100),
                        startPosition('Right Position', Colors.green , (width-30)/3, 100),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15),),
              FlatButton(
                color: Colors.blue,
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScoutingAutonomousPeriod(teamName: widget.teamName)),
                    );
                },
                padding: EdgeInsets.all(20),
                child: Text(
                  "Start Game",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ],
    )
    );
  }

  Widget startPosition(String label, Color color, double width, double height){
    return Container(
      width: width,
      height: height,
      color: color,
      child: FlatButton(
        onPressed: () {
          print(label);
        },
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      ),
    );
  }
}