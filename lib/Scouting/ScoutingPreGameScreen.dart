import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Widgets/alert.dart';
import 'package:pit_scout/Model/GameDataModel.dart';
import 'ScoutingAutonomousPeriod.dart';
import 'package:provider/provider.dart';

class ScoutingPreGameScreen extends StatefulWidget{
  final String teamName;
  final String teamNumber;
  final String tournament;
  final String qualNumber;
  final String matchKey;
  final String allianceColor;
  final String userId;

  ScoutingPreGameScreen({Key key, @required this.teamName, this.teamNumber, this.tournament, this.qualNumber, this.userId, this.allianceColor, this.matchKey}) : super(key:key);

  @override
  ScoutingPreGameScreenState createState() => ScoutingPreGameScreenState();
}

class ScoutingPreGameScreenState extends State<ScoutingPreGameScreen> {

  String _robotStartingPosition = 'Not selected';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<GameDataModel>(context, listen: false).setGameData(widget.qualNumber, widget.tournament, widget.userId, widget.teamNumber, widget.teamName, widget.allianceColor, widget.matchKey);
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
                width: width,
                child: GestureDetector(
                  child: Image.asset(
                      'assets/StartingPosition.png',
                    fit: BoxFit.fill,
                  ),
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
                        startPosition('Left', Colors.blue, (width-30)/3, 100),
                        startPosition('Center', Colors.red, (width-30)/3, 100),
                        startPosition('Right', Colors.green , (width-30)/3, 100),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(15),),
        Center(
          child: Text(
            'Starting position: ' + _robotStartingPosition,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              color: _robotStartingPosition=='Not selected'
                  ? Colors.black
                  : _robotStartingPosition=='Left'
                    ? Colors.blue
                    : _robotStartingPosition=='Center'
                      ? Colors.red
                      : Colors.green
            ),
          ),
        ),
//        allianceSelect((val) {
//          setState(() {
//            this._allianceColor = val;
//          });
//        }),
        Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15),),
              FlatButton(
                color: Colors.blue,
                onPressed: () {
                  if (_robotStartingPosition=='Not selected'){
                    alert(
                      context,
                      'Error',
                      'You must select one of the positions to in order to continue to the next screen'
                    );
                  } else {
                    Provider.of<GameDataModel>(context, listen: false).setPreGameData(_robotStartingPosition);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScoutingAutonomousPeriod(teamName: widget.teamName, teamNumber: widget.teamNumber,)),
                    );
                  }
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
          setState(() {
            this._robotStartingPosition = label;
          });
        },
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
  }
}