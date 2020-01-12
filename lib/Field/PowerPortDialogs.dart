import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void IntCallback(int result);
typedef void Int2Callback(int result1, int result2);

class UpperScoreDialog extends StatefulWidget {
  final String message;
  final Int2Callback scoreResult;

  UpperScoreDialog({Key key, this.message, this.scoreResult}) : super(key: key);

  @override
  _UpperScoreDialogState createState() => _UpperScoreDialogState();
}

class _UpperScoreDialogState extends State<UpperScoreDialog> {

  int innerScore = 0;
  int outerScore = 0;

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
                      widget.scoreResult(innerScore, outerScore);
                      Navigator.of(context).pop();
                    },

                  ),
                ],
              )
            ],
          ),
          height: 500.0,
        )
    );
  }
}

class BottomScoreDialog extends StatefulWidget {
  final String message;
  final IntCallback scoreResult;

  BottomScoreDialog({Key key, this.message, this.scoreResult}) : super(key: key);

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
                powerCellsWidget(context, score, (scoreRequested) => setState(() => score = scoreRequested)),
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
                    widget.scoreResult(score);
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

Widget powerCellsWidget(BuildContext context, int score, IntCallback setScore) {
  return Row(
    children: <Widget>[
      powerCellWidget(score == 1 ? 0 : 1, setScore, score > 0),
      powerCellWidget(2, setScore, score >= 2),
      powerCellWidget(3, setScore, score >= 3),
      powerCellWidget(4, setScore, score >= 4),
      powerCellWidget(5, setScore, score >= 5),
    ],
  );
}

Widget powerCellWidget(int scoreToSet, IntCallback setScore, bool fullCellCondition) {
  return GestureDetector(
    onTap: (() {
      setScore(scoreToSet);
    }),
    child: fullCellCondition
        ? Container(
          width: 40,
          height: 40,
          child: Image.asset('assets/PowerCell.png'),
        )
        : Container(
          width: 40,
          height: 40,
          child: Image.asset('assets/EmptyPowerCell.png'),
        )
  );
}