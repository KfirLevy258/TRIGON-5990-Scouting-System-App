import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Field/AutoPowerCellsCollect.dart';
import 'package:pit_scout/Field/PowerCelldEndOfAuto.dart';
import 'package:pit_scout/Field/PowerPortDialogs.dart';
import 'ScoutingTeleop.dart';
import 'package:flutter/services.dart';

class ScoutingAutonomousPeriod extends StatefulWidget{
  final String teamNumber;
  final String teamName;

  ScoutingAutonomousPeriod({Key key, @required this.teamName, this.teamNumber}) : super(key:key);

  @override
  ScoutingAutonomousPeriodState createState() => ScoutingAutonomousPeriodState();
}

class ScoutingAutonomousPeriodState extends State<ScoutingAutonomousPeriod>{

  int bottomScore;
  int upperScoreInner;
  int upperScoreOuter;
  int amountOfPowerCells;

  @override
  void initState()  {
    setOrientation();
    bottomScore = 0;
    upperScoreInner = 0;
    upperScoreOuter = 0;
    amountOfPowerCells = 0;
    super.initState();
  }

  setOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
          "Autonomous Period: " + widget.teamNumber.toString() + ' - ' + widget.teamName,
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(15.0),),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(3.0),),
                    Column(
                      children: <Widget>[
                        Container(
                          width: (width-30)/2,
                          child: GestureDetector(
                            child: Image.asset('assets/PowerPort.png'),
                            onTapDown: ((details)  {
                              final Offset offset = details.localPosition;
                              if (offset.dx > (40.0/411.0)*width && offset.dx < (170.0/411.0)*width && offset.dy > (45.0/411.0)*width && offset.dy < (160.0/411.0)*width)
                                showDialog(
                                    context: context,
                                  builder: (_) {
                                      return UpperScoreDialog(message: 'UpperPort',
                                          scoreResult: ((score1, score2) {
                                            upperScoreInner = upperScoreInner + score1;
                                            upperScoreOuter = upperScoreOuter + score2;
                                          }));
                                  }
                                );
                              if (offset.dx > (25.0/411.0)*width && offset.dx < (161.0/411.0)*width && offset.dy > (285.0/411.0)*width && offset.dy < (354.0/411.0)*width)
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return BottomScoreDialog(message: 'Bottom Port',
                                        scoreResult: ((score) {bottomScore = bottomScore + score;}));
                                  }
                                );
                            }),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: (width-20)/2,
                          height: buttonHeight(width),
                          child: FlatButton(
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AutoPowerCellsCollect()),
                              ).then((_) {
                                setOrientation();
                              });
                            },
                            child: Text(
                              'איסוף\nכדורים',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30.0, color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0),),
                        Container(
                          width: (width-20)/2,
                          height: buttonHeight(width),
                          child: FlatButton(
                            child: Text(
                              'כמות\nכדורים\nבסוף',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_){
                                    return EndOfAutoPowerCells(message: 'כמות כדורים על הרובוט \n בסוף השלב האוטונומי',
                                      scoreResult: ((amount) {amountOfPowerCells = amount;}),);
                                  }
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    print('bottom score ' + bottomScore.toString());
                    print('upper score inner ' + upperScoreInner.toString());
                    print('upper score outer ' + upperScoreOuter.toString());
                    print('amount ' + amountOfPowerCells.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScoutingTeleop(teamName: widget.teamName, teamNumber: widget.teamNumber,)),
                    ).then((val) {
                      setOrientation();
                    });
                  },
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Teleop",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  double buttonHeight(double width) {
    double newWidth = (width-30)/2;
    double ratio = newWidth/212;
    double powerPortHeight = 460*ratio;
    double buttonHeight = (powerPortHeight/2)-35;
    return buttonHeight;
  }
}

