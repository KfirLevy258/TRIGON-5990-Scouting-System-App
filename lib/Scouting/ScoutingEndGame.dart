import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:pit_scout/Model/GameDataModel.dart';
import 'package:pit_scout/Scouting/GameDataConsume.dart';
import 'package:pit_scout/Scouting/ScoutingDataReview.dart';
import 'package:pit_scout/Widgets/alert.dart';
import 'package:pit_scout/Widgets/booleanInput.dart';
import 'package:pit_scout/Widgets/selectionInput.dart';
import 'package:provider/provider.dart';

class EndGame extends StatefulWidget {
  final String teamName;
  final String teamNumber;

  EndGame({Key key, @required this.teamName, this.teamNumber}) : super(key:key);

  @override
  _EndGameState createState() => _EndGameState();
}

class _EndGameState extends State<EndGame> {
  double _lowerValue = 150;
  String _climbStatus = 'Not selected';
  String _whyDidntSucceeded = 'Not selected';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'End Game: '+ widget.teamNumber + ' - ' + widget.teamName,
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15.0),),
              selectionInputWidget('Climb status', _climbStatus, ["Climbed successfully", "Tried", "Parked", "Dident tried"], (val) => setState(() => _climbStatus = val)),
              Padding(padding: EdgeInsets.all(15.0),),
              _climbStatus == "Climbed successfully"
                  ? climb(width, height)
                  : Container(),
              _climbStatus == "Tried"
                  ? Column(
                    children: <Widget>[
                      selectionInputWidget('Why didnt climb?', _whyDidntSucceeded, ["Fell", "Mechanical failure", "Time is upן" ,"Other"], (val) => setState(() => _whyDidntSucceeded = val)),
                      Padding(padding: EdgeInsets.all(15.0),),
                    ],
                  )
                  : Container(),

              Padding(padding: EdgeInsets.all(15.0),),
              Container(
                width: 200,
                height: 100,
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    if (_climbStatus == 'Not selected') {
                      alert(
                        context,
                        'Error',
                        'You must enter a value for the climb status',
                      );
                    } else {
                      if (_climbStatus == 'Tried' && _whyDidntSucceeded=='Not selected') {
                        alert(
                          context,
                          'Error',
                          'You need to enter value why the robot didnt climb',
                        );
                      } else{
                        Provider.of<GameDataModel>(context, listen: false).setEndGameData(this._climbStatus, (this._lowerValue.round()), this._whyDidntSucceeded);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GameDataConsume()),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Validation',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget climb(double width, double height){
    return Column(
      children: <Widget>[
        Text(
          'Where did he climb?',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue, fontSize: 30.0),
        ),
        Padding(padding: EdgeInsets.all(10.0),),
        Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: width-60,
                child: Image.asset('assets/Genrator.png'),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: (305.0/411.428)*width, left: (25.0/683.428)*height),),
                Container(
                  width: width-60,
                  child: FlutterSlider(
                    values: [150],
                    max: 300,
                    min: 0,
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      setState(() {
                        this._lowerValue = lowerValue;
                      });
                      },
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
