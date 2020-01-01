
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ScoutingAutonomyPeriod.dart';

class PreGameScreen extends StatefulWidget{
  final String teamName;

  PreGameScreen({Key key, @required this.teamName}) : super(key:key);

  @override
  PreGameScreenState createState() => PreGameScreenState(teamName);
}

class PreGameScreenState extends State<PreGameScreen>{
  String teamName;

  PreGameScreenState(String teamName){
    this.teamName = teamName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(
        "Pre game: " + this.teamName,
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
                      MaterialPageRoute(builder: (context) => AutonomyPeriod(teamName: teamName)),
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