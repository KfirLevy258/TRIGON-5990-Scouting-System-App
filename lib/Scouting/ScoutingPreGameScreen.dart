
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