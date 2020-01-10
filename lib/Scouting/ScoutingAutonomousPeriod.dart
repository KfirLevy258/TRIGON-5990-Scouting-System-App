import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Field/PowerPort.dart';
import 'ScoutingTeleop.dart';
import 'package:flutter/services.dart';

class ScoutingAutonomousPeriod extends StatefulWidget{
  final String teamName;

  ScoutingAutonomousPeriod({Key key, @required this.teamName}) : super(key:key);

  @override
  ScoutingAutonomousPeriodState createState() => ScoutingAutonomousPeriodState();
}

typedef void IntCallback(int result);

class ScoutingAutonomousPeriodState extends State<ScoutingAutonomousPeriod>{

  int bottomScore;

  @override
  void initState()  {
    setOrientation();
    bottomScore = 0;
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
                Container(
                  child: GestureDetector(
                    child: Image.asset('assets/PowerPort.png'),
                    onTapDown: ((details)  {
                      final Offset offset = details.localPosition;
                      if (offset.dx > 40 && offset.dx < 170 && offset.dy > 45 && offset.dy < 160) upTargetDialog(context, 'Up Port');
                      if (offset.dx > 25 && offset.dx < 180 && offset.dy > 310 && offset.dy < 390)
                        showDialog(
                          context: context,
                          builder: (_) {
                            return BottomScoreDialog(message: 'Bottom Port',);
                          }
                        );
//                      if (offset.dx > 25 && offset.dx < 180 && offset.dy > 310 && offset.dy < 390) bottomTargetDialog('Bottom Port',
//                          ((score) {bottomScore = bottomScore + score;}));
                    }),
                  ),
                ),
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    print(bottomScore);
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

//  bottomTargetDialog(String message, IntCallback callback) {
//    print(message);
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return Center(
//            child: Container(
//              child: AlertDialog(
//                content: Container(
//                  child: Column(
//                    children: <Widget>[
//                      Text(
//                        message,
//                        style: TextStyle(fontSize: 20.0, color: Colors.blue, fontStyle: FontStyle.italic),
//                        textAlign: TextAlign.center,
//                      ),
//                      powerCellsWidget(context, 3),
//                    ],
//                  ),
//                ),
//
//                actions: <Widget>[
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      FlatButton(
//                        color: Colors.redAccent,
//                        child: Text(
//                          'Close',
//                          textAlign: TextAlign.center,
//                        ),
//                        onPressed: () {
//                          Navigator.of(context).pop();
//                        },
//
//                      ),
//                      FlatButton(
//                        child: Text(
//                          'Save',
//                          textAlign: TextAlign.center,
//                        ),
//                        color: Colors.green,
//                        onPressed: () {
//                          callback(3);
//                          Navigator.of(context).pop();
//                        },
//
//                      ),
//                    ],
//                  )
//                ],
//              ),
//              height: 260.0,
//            ),
//          );
//        }
//    );
//  }
}

class BottomScoreDialog extends StatefulWidget {
  final String message;

  BottomScoreDialog({Key key, this.message}) : super(key: key);

  @override
  _BottomScoreDialogState createState() => _BottomScoreDialogState();
}

class _BottomScoreDialogState extends State<BottomScoreDialog> {

  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: AlertDialog(
          content: Container(
            child: Column(
              children: <Widget>[
                Text(
                  widget.message,
                  style: TextStyle(fontSize: 20.0, color: Colors.blue, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (() {
                        setState(() {
                          score = score == 1 ? 0 : 1;
                        });
                      }),
                      child: score > 0 ? Image.asset('assets/PowerCell.png') : Image.asset('assets/EmptyPowerCell.png'),
                    ),
                    GestureDetector(
                      onTap: (() {
                        setState(() {
                          score = 2;
                        });
                      }),
                      child: score >= 2 ? Image.asset('assets/PowerCell.png') : Image.asset('assets/EmptyPowerCell.png'),
                    ),
                    GestureDetector(
                      onTap: (() {
                        setState(() {
                          score = 3;
                        });
                      }),
                      child: score >= 3 ? Image.asset('assets/PowerCell.png') : Image.asset('assets/EmptyPowerCell.png'),
                    ),
                    GestureDetector(
                      onTap: (() {
                        setState(() {
                          score = 4;
                        });
                      }),
                      child: score >= 4 ? Image.asset('assets/PowerCell.png') : Image.asset('assets/EmptyPowerCell.png'),
                    ),
                    GestureDetector(
                      onTap: (() {
                        setState(() {
                          score = 5;
                        });
                      }),
                      child: score >= 5 ? Image.asset('assets/PowerCell.png') : Image.asset('assets/EmptyPowerCell.png'),
                    ),
                  ],
                )
              ],
            ),
          ),

          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.redAccent,
                  child: Text(
                    'Close',
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },

                ),
                FlatButton(
                  child: Text(
                    'Save',
                    textAlign: TextAlign.center,
                  ),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },

                ),
              ],
            )
          ],
        ),
        height: 260.0,
      ),
    );
  }
}


Widget powerCellsWidget(BuildContext context, int tempBottomScore) {
  return Row(
    children: <Widget>[
      GestureDetector(
        onTap: (() {
        }),
        child: tempBottomScore == 0 ? Image.asset('assets/EmptyPowerCell.png') : Image.asset('assets/PowerCell.png'),
      )
    ],
  );
}
