import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Field/PowerPortDialogs.dart';
import 'package:pit_scout/Field/ShotFrom.dart';
import 'package:pit_scout/Field/TrenchDialog.dart';
import 'package:pit_scout/Scouting/ScoutingEndGame.dart';
import 'package:pit_scout/Widgets/alert.dart';
import 'package:pit_scout/Widgets/booleanInput.dart';
import 'package:pit_scout/Widgets/plusminus.dart';
import 'package:provider/provider.dart';
import 'package:pit_scout/Model/GameDataModel.dart';
import '../DataPackages.dart';
import '../addToScouterScore.dart';

class ScoutingTeleop extends StatefulWidget{
  final String teamName;
  final String teamNumber;

  ScoutingTeleop({Key key, @required this.teamName, this.teamNumber}) : super(key:key);

  @override
  ScoutingTeleopState createState() => ScoutingTeleopState();
}

class ScoutingTeleopState extends State<ScoutingTeleop>{

  int bottomScore;
  int bottomShoot;
  int upperScoreInner;
  int upperScoreOuter;
  int upperShoot;
  int fouls;
  int preventedBalls;
  bool rotateTheTrench;
  bool stopTheTrench;
  bool didDefense;

  List<List<double>> shootingFrom;
  List<TeleopUpperTargetData> upperData;

  @override
  void initState()  {
    bottomScore =0;
    upperScoreInner =0;
    upperScoreOuter = 0;
    bottomShoot = 0;
    upperShoot = 0;
    fouls = 0;
    preventedBalls = 0;
    rotateTheTrench = false;
    stopTheTrench = false;
    didDefense = false;
    shootingFrom = [];
    upperData = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    double height= MediaQuery. of(context). size. height;
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: AppBar(
          title: Text(
            "Teleop Period: " + widget.teamNumber + ' - ' + widget.teamName,
            textAlign: TextAlign.center,
          ),
          bottom: new TabBar(
            tabs: <Widget>[
              new Tab(
                text: "Attack",
              ),
              new Tab(
                text: "Defense",
              ),
            ],
          ),
        ),
        body: new TabBarView(
          children: <Widget>[
            new ListView(
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
                                        MaterialPageRoute(builder: (context) => ShotFrom(userId: Provider.of<GameDataModel>(context, listen: false).getUserId(),)),
                                      ).then((val) {
                                        print(val);
                                        List<double> offset = getPointOfShot(val.toString() ,(height-80));
                                        print(offset);
                                        print(offset[1]);
                                        shootingFrom.add(offset);
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return UpperScoreDialog(message: 'UpperPort',
                                                scoreResult: ((score1, score2, score3) {
                                                  upperScoreInner = upperScoreInner + score1;
                                                  upperScoreOuter = upperScoreOuter + score2;
                                                  upperShoot = upperShoot + score3;
                                                  upperData.add(new TeleopUpperTargetData(score1, score2, score3, offset[0], offset[1]));
                                                }));
                                          },
                                        );
                                      });
                                    if (offset.dx > (25.0/411.0)*width && offset.dx < (161.0/411.0)*width && offset.dy > (285.0/411.0)*width && offset.dy < (354.0/411.0)*width)
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return BottomScoreDialog(message: 'Bottom Port',
                                              scoreResult: ((score1, score2) {
                                                bottomScore = bottomScore + score1;
                                                bottomShoot = bottomShoot + score2;
                                              }));
                                        },
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
                          Provider.of<GameDataModel>(context, listen: false).setTeleopGameData(upperScoreInner, upperScoreOuter, bottomScore, rotateTheTrench, stopTheTrench, upperShoot, bottomShoot, upperData, didDefense, fouls, preventedBalls);
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
                ),
              ],
            ),
            new ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(10.0),),
                    booleanInputWidget('Did defense', this.didDefense, ((val) {
                      setState(() {
                        this.didDefense = val;
                      });
                    })),
                    Padding(padding: EdgeInsets.all(10.0),),
                    plusMinus(this.fouls, 'Fouls amount', ((val) {
                      setState(() {
                        this.fouls = val;
                      });
                    })),
                    Padding(padding: EdgeInsets.all(10.0),),
                    plusMinus(this.preventedBalls, 'Power Cells prevented', ((val) {
                      setState(() {
                        this.preventedBalls = val;
                      });
                    }))
                  ],
                )
              ],
            )
          ],
        )
      ),
    );
  }

  List<double> getPointOfShot(String val, double height) {
    List<String> offset = val.toString().split('Offset(');
    List<String> offset1 = offset[1].split(', ');
    List<String> offset2 =  offset1[1].split(')');
    String x = offset1[0];
    String y = offset2[0];
    double relativeY = double.parse(y)/height;
    double relativeX = double.parse(x)/imageWidth(height, 317, 607);
    List<double> list = new List<double>();
    list.add(relativeY);
    list.add(relativeX);
    return list;
  }

  double imageWidth(double height, double originalWidth, double originalHeight) {
    double ratio = originalHeight/height;
    print(height);
    double imageHeight = originalWidth/ratio;
    return imageHeight;
  }
}