
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
    return Scaffold(
        appBar: AppBar(
        title: Text(
        "Pre game: " + widget.teamNumber + ' - ' + widget.teamName,
        textAlign: TextAlign.center,
        ),
      ),
    body: ListView(
      children: <Widget>[
        Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15),),
              Container(
                child: GestureDetector(
                  child: Image.asset(
                      'assets/StartingPosition.png',
                    fit: BoxFit.fill,
                  ),
                  onTapDown: ((details)  {
                    final Offset offset = details.localPosition;
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
}