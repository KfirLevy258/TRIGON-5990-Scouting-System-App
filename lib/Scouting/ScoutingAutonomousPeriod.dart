import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Field/AutoPowerCellsCollect.dart';
import 'package:pit_scout/Field/PowerPortDialogs.dart';
import 'ScoutingTeleop.dart';
import 'package:flutter/services.dart';

class ScoutingAutonomousPeriod extends StatefulWidget{
  final String teamName;

  ScoutingAutonomousPeriod({Key key, @required this.teamName}) : super(key:key);

  @override
  ScoutingAutonomousPeriodState createState() => ScoutingAutonomousPeriodState();
}

class ScoutingAutonomousPeriodState extends State<ScoutingAutonomousPeriod>{

  int bottomScore;
  int upperScoreInner;
  int upperScoreOuter;

  @override
  void initState()  {
    setOrientation();
    bottomScore = 0;
    upperScoreInner = 0;
    upperScoreOuter = 0;
    super.initState();
  }

  setOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
          "Autonomous Period: " + widget.teamName,
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(15),),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: GestureDetector(
                            child: Image.asset('assets/PowerPort.png'),
                            onTapDown: ((details)  {
                              final Offset offset = details.localPosition;

                              if (offset.dx > 40 && offset.dx < 170 && offset.dy > 45 && offset.dy < 160)
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

                              if (offset.dx > 25 && offset.dx < 180 && offset.dy > 310 && offset.dy < 390)
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
                        FlatButton(
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AutoPowerCellsCollect()),
                            );
                          },
                          child: Text(
                            'איסוף\nכדורים',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40.0, color: Colors.white),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0),),

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScoutingTeleop(teamName: widget.teamName,)),
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
}

