import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pit_scout/Model/GameData.dart';

class ScoutingDataReview extends StatefulWidget{
  final GameData gameData;

  ScoutingDataReview({Key key, this.gameData}) : super(key:key);

  @override
  ScoutingDataReviewState createState() => ScoutingDataReviewState();
}

class ScoutingDataReviewState extends State<ScoutingDataReview>{

  GameData localGameData = new GameData();

  @override
  void initState()  {
    setOrientation();
    super.initState();
  }

  setOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
//    print(widget.gameData.climbLocation);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Data Review: " + widget.gameData.teamNumber + ' - ' + widget.gameData.teamName,
            textAlign: TextAlign.center,
          ),
        ),
        body: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(15.0),),
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
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