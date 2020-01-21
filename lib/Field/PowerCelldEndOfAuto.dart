import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void IntCallback(int result);

class EndOfAutoPowerCells extends StatefulWidget {
  final String message;
  final IntCallback scoreResult;

  EndOfAutoPowerCells({Key key, this.message, this.scoreResult}) : super(key: key);

  @override
  _EndOfAutoPowerCellsState createState() => _EndOfAutoPowerCellsState();
}

class _EndOfAutoPowerCellsState extends State<EndOfAutoPowerCells> {

  int amount = 0;

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
                  style: TextStyle(fontSize: 17.0, color: Colors.blue, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                Padding(padding: EdgeInsets.all(5.0),),
                powerCellsWidget(context, amount, (scoreRequested) => setState(() => amount = scoreRequested)),
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
                    widget.scoreResult(amount);
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
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      powerCellWidget(score == 1 ? 0 : 1, setScore, score > 0),
      Padding(padding: EdgeInsets.all(5.0),),
      powerCellWidget(2, setScore, score >= 2),
      Padding(padding: EdgeInsets.all(5.0),),
      powerCellWidget(3, setScore, score >= 3),
      Padding(padding: EdgeInsets.all(5.0),),
      powerCellWidget(4, setScore, score >= 4),
      Padding(padding: EdgeInsets.all(5.0),),
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