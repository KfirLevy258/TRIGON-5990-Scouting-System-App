import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Field/PowerPortDialogs.dart';
import 'package:pit_scout/Field/ShotFrom.dart';
import 'package:pit_scout/Field/TrenchDialog.dart';
import 'package:pit_scout/Scouting/ScoutingEndGame.dart';
import 'ScoutingDataReview.dart';

class ScoutingTeleop extends StatefulWidget{
  final String teamName;
  final String teamNumber;

  ScoutingTeleop({Key key, @required this.teamName, this.teamNumber}) : super(key:key);

  @override
  ScoutingTeleopState createState() => ScoutingTeleopState();
}

class ScoutingTeleopState extends State<ScoutingTeleop>{

  int bottomScore;
  int upperScoreInner;
  int upperScoreOuter;
  bool rotateTheTrench;
  bool stopTheTrench;
  List<String> shootingFrom;

  @override
  void initState()  {
    bottomScore =0;
    upperScoreInner =0;
    upperScoreOuter = 0;
    rotateTheTrench = false;
    stopTheTrench = false;
    shootingFrom = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Teleop Period: " + widget.teamNumber + ' - ' + widget.teamName,
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
                    Padding(padding: EdgeInsets.all(5.0),),
                    Column(
                      children: <Widget>[
                        Container(
                          width: (width-30)/2,
                          child: GestureDetector(
                            child: Image.asset('assets/PowerPort.png'),
                            onTapDown: ((details)  {
                              final Offset offset = details.localPosition;
                              if (offset.dx > (40.0/411.0)*width && offset.dx < (170.0/411.0)*width && offset.dy > (45.0/411.0)*width && offset.dy < (160.0/411.0)*width)
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ShotFrom()),
                                ).then((val) {
                                  print(val);
                                  List<String> offset = val.toString().split('Offset(');
                                  List<String> offset1 = offset[1].split(', ');
                                  List<String> offset2 =  offset1[1].split(')');
                                  String x = offset1[0];
                                  String y = offset2[0];
                                  print(x);
                                  print(y);
                                  shootingFrom.add('(' + x.toString() + ',' + y.toString() + ')');
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
                                });
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
                          width: (width-30)/2,
                          child: GestureDetector(
                            child: Image.asset('assets/Trench.png'),
                            onTapDown: ((details) {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return TrenchDialog(
                                    message: 'Trench',
                                    boolResult: ((canRotate, canStop) {
                                      this.rotateTheTrench = canRotate;
                                      this.stopTheTrench = canStop;
                                    }),
                                    rotate: rotateTheTrench,
                                    stop: stopTheTrench,
                                  );
                                }
                              );
                            }),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    print('bottom score ' + bottomScore.toString());
                    print('upper score inner ' + upperScoreInner.toString());
                    print('upper score outer ' + upperScoreOuter.toString());
                    print('rotate: ' + rotateTheTrench.toString());
                    print('stop: ' + stopTheTrench.toString());
                    print('shooting positions: ' + shootingFrom.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EndGame(teamName: widget.teamName, teamNumber: widget.teamNumber,)),
                    );
                  },
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "End Game",
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

}