import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Widgets/alert.dart';

typedef void IntCallback(int result);
typedef void Int3Callback(int result1, int result2, int result3);

class UpperScoreDialog extends StatefulWidget {
  final String message;
  final Int3Callback scoreResult;

  UpperScoreDialog({Key key, this.message, this.scoreResult}) : super(key: key);

  @override
  _UpperScoreDialogState createState() => _UpperScoreDialogState();
}

class _UpperScoreDialogState extends State<UpperScoreDialog> {

  int innerScore = 0;
  int outerScore = 0;
  int powerCellsShoot = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: 600.0,
          child: SingleChildScrollView(
            child: AlertDialog(
              content: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.message,
                      style: TextStyle(fontSize: 30.0, color: Colors.blue, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.all(6.0),),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('inner port'),
                            Image.asset('assets/Inner.png')
                          ],
                        ),
                        powerCellsWidget(context, innerScore, (scoreRequested) => setState(() => innerScore = scoreRequested)),
                        Row(
                          children: <Widget>[
                            Text('outer port'),
                            Image.asset('assets/Outer.png')
                          ],
                        ),
                        powerCellsWidget(context, outerScore, (scoreRequested) => setState(() => outerScore = scoreRequested)),
                        Padding(padding: EdgeInsets.all(10.0),),
                        Row(
                          children: <Widget>[
                            Text('How much did he shoot?'),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10.0),),
                        powerCellsWidget(context, powerCellsShoot, (scoreRequested) => setState(() => powerCellsShoot = scoreRequested)),
                      ],
                    ),
                  ],
                ),
              ),

              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Close',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },

                    ),
                    FlatButton(
                      child: Text(
                        'Save',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        if (innerScore+outerScore>5){
                          alert(
                            context,
                            'שגיאה',
                            'לא יתכן מצב בו יכנסו בבת אחת יותר מ-5 כדורים למטרה, שהרי רובוט רשאי להחזיק חמישה כדורים בלבד',
                          );
                        } else if (powerCellsShoot<innerScore+outerScore) {
                          alert(
                            context,
                            'שגיאה',
                            'לא הגיוני שהוא הכניס יותר כדורים מכמות הכדורים אותה הרובוט ירה',
                          );
                        }
                        else {
                          widget.scoreResult(innerScore, outerScore, powerCellsShoot);
                          Navigator.of(context).pop();
                        }
                      },

                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}

typedef void Int2Callback(int result1, int result2);

class BottomScoreDialog extends StatefulWidget {
  final String message;
  final Int2Callback scoreResult;

  BottomScoreDialog({Key key, this.message, this.scoreResult}) : super(key: key);

  @override
  _BottomScoreDialogState createState() => _BottomScoreDialogState();
}

class _BottomScoreDialogState extends State<BottomScoreDialog> {

  int score = 0;
  int powerCellsShoot = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 350.0,
        child: AlertDialog(
          content: Container(
            child: Column(
              children: <Widget>[
                Text(
                  widget.message,
                  style: TextStyle(fontSize: 30.0, color: Colors.blue, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                Padding(padding: EdgeInsets.all(6.0),),
                powerCellsWidget(context, score, (scoreRequested) => setState(() => score = scoreRequested)),
                Padding(padding: EdgeInsets.all(10.0),),
                Row(
                  children: <Widget>[
                    Text('How much did he shoot?'),
                  ],
                ),
                Padding(padding: EdgeInsets.all(10.0),),
                powerCellsWidget(context, powerCellsShoot, (scoreRequested) => setState(() => powerCellsShoot = scoreRequested)),

              ],
            ),
          ),

          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'Close',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },

                ),
                FlatButton(
                  child: Text(
                    'Save',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    if (powerCellsShoot<score) {
                      alert(
                        context,
                        'שגיאה',
                        'לא הגיוני שהוא הכניס יותר כדורים מכמות הכדורים אותה הרובוט ירה',
                      );
                    } else {
                      widget.scoreResult(score, powerCellsShoot);
                      Navigator.of(context).pop();
                    }
                  },

                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget powerCellsWidget(BuildContext context, int score, IntCallback setScore) {
  double width = MediaQuery. of(context). size. width;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      powerCellWidget(score == 1 ? 0 : 1, setScore, score > 0, width),
      Padding(padding: EdgeInsets.all(5.0),),
      powerCellWidget(2, setScore, score >= 2, width),
      Padding(padding: EdgeInsets.all(5.0),),
      powerCellWidget(3, setScore, score >= 3, width),
      Padding(padding: EdgeInsets.all(5.0),),
      powerCellWidget(4, setScore, score >= 4, width),
      Padding(padding: EdgeInsets.all(5.0),),
      powerCellWidget(5, setScore, score >= 5, width),
    ],
  );
}

Widget powerCellWidget(int scoreToSet, IntCallback setScore, bool fullCellCondition, double width) {
  return GestureDetector(
    onTap: (() {
      setScore(scoreToSet);
    }),
    child: fullCellCondition
        ? Container(
            width: (width-200)/5,
            height: 40,
            child: Image.asset('assets/PowerCell.png'),
        )
        : Container(
            width: (width-175)/5,
            height: 40,
            child: Image.asset('assets/EmptyPowerCell.png'),
        )
  );
}

