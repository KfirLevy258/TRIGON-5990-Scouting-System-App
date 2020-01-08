
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ScoutingAutonomousPeriod.dart';

class PreGameScreen extends StatefulWidget{
  final String teamName;
  final String teamNumber;
  final String tournament;
  final String qualNumber;
  final String userId;

  PreGameScreen({Key key, @required this.teamName, this.teamNumber, this.tournament, this.qualNumber, this.userId}) : super(key:key);

  @override
  PreGameScreenState createState() => PreGameScreenState();
}

class PreGameScreenState extends State<PreGameScreen> {


  @override
  void initState()  {
    setOrientation();
    super.initState();
  }

  setOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
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
              FlatButton(
                color: Colors.blue,
                onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => AutonomyPeriod(teamName: teamName)),
//                    );
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