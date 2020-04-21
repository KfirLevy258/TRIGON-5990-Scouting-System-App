import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Field/AutoPowerCellsCollect.dart';
import 'package:pit_scout/Field/PowerCelldEndOfAuto.dart';
import 'package:pit_scout/Field/PowerPortDialogs.dart';
import 'package:pit_scout/Model/GameDataModel.dart';
import 'package:pit_scout/Widgets/booleanInput.dart';
import 'package:provider/provider.dart';
import '../DataPackages.dart';
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
  int bottomShoot;
  int upperShoot;
  int upperScoreInner;
  int upperScoreOuter;
  List<AutoUpperTargetData> upperData;
  bool climb1BallCollected = false;
  bool climb2BallCollected = false;
  bool climb3BallCollected = false;
  bool climb4BallCollected = false;
  bool climb5BallCollected = false;
  bool trench1BallCollected = false;
  bool trench2BallCollected = false;
  bool trench3BallCollected = false;
  bool trench4BallCollected = false;
  bool trench5BallCollected = false;
  bool trenchSteal1BallCollected = false;
  bool trenchSteal2BallCollected = false;
  bool autoLine = false;

  @override
  void initState()  {
    setOrientation();
    bottomScore = 0;
    upperScoreInner = 0;
    upperScoreOuter = 0;
    upperShoot = 0;
    bottomShoot = 0;
    upperData = [];
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
                                          scoreResult: ((score1, score2, score3) {
                                            upperScoreInner = upperScoreInner + score1;
                                            upperScoreOuter = upperScoreOuter + score2;
                                            upperShoot = upperShoot + score3;
                                            upperData.add(new AutoUpperTargetData(score1, score2, score3));
                                          }));
                                  }
                                );
                              if (offset.dx > (25.0/411.0)*width && offset.dx < (161.0/411.0)*width && offset.dy > (285.0/411.0)*width && offset.dy < (354.0/411.0)*width)
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return BottomScoreDialog(message: 'Bottom Port',
                                        scoreResult: ((score1, score2) {
                                          bottomScore = bottomScore + score1;
                                          bottomShoot = bottomShoot + score2;
                                        }));
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
                                MaterialPageRoute(builder: (context) => AutoPowerCellsCollect(bool12callback: ((climb1, climb2, climb3, climb4, climb5,
                                    trench1, trench2, trench3, trench4, trench5, steal1, steal2) {
                                    this.climb1BallCollected = climb1;
                                    this.climb2BallCollected = climb2;
                                    this.climb3BallCollected = climb3;
                                    this.climb4BallCollected = climb4;
                                    this.climb5BallCollected = climb5;
                                    this.trench1BallCollected = trench1;
                                    this.trench2BallCollected = trench2;
                                    this.trench3BallCollected = trench3;
                                    this.trench4BallCollected = trench4;
                                    this.trench5BallCollected = trench5;
                                    this.trenchSteal1BallCollected = steal1;
                                    this.trenchSteal2BallCollected = steal2;
                                  }),
                                  climb1BallCollected: this.climb1BallCollected,
                                  climb2BallCollected: this.climb2BallCollected,
                                  climb3BallCollected: this.climb3BallCollected,
                                  climb4BallCollected: this.climb4BallCollected,
                                  climb5BallCollected: this.climb5BallCollected,
                                  trench1BallCollected: this.trench1BallCollected,
                                  trench2BallCollected: this.trench2BallCollected,
                                  trench3BallCollected: this.trench3BallCollected,
                                  trench4BallCollected: this.trench4BallCollected,
                                  trench5BallCollected: this.trench5BallCollected,
                                  trenchSteal1BallCollected: this.trenchSteal1BallCollected,
                                  trenchSteal2BallCollected: this.trenchSteal2BallCollected,
                                )),
                              ).then((_) {
                                setOrientation();
                              });
                            },
                            child: Text(
                              'Balls\nCollect',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30.0, color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0),),
                        Container(
                          width: (width-20)/2,
                          height: buttonHeight(width),
                          child: booleanInputWidget('Auto Line', this.autoLine, ((val) {
                            setState(() {
                              this.autoLine = val;
                            });
                          })),
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
                    print('upper score shoot ' + upperShoot.toString());

                    Provider.of<GameDataModel>(context, listen: false).setAutoGameData(this.upperScoreInner, this.upperScoreOuter,
                        this.bottomScore,  this.upperShoot, this.bottomShoot, this.upperData,
                        this.climb1BallCollected, this.climb2BallCollected, this.climb3BallCollected,
                        this.climb4BallCollected, this.climb5BallCollected, this.trench1BallCollected, this.trench2BallCollected, this.trench3BallCollected,
                        this.trench4BallCollected, this.trench5BallCollected, this.trenchSteal1BallCollected, this.trenchSteal2BallCollected, this.autoLine);

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

