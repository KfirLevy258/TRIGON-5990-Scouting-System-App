import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:pit_scout/Scouting/ScoutingDataReview.dart';
import 'package:pit_scout/Widgets/selectionInput.dart';

class EndGame extends StatefulWidget {
  final String teamName;
  final String teamNumber;

  EndGame({Key key, @required this.teamName, this.teamNumber}) : super(key:key);

  @override
  _EndGameState createState() => _EndGameState();
}

class _EndGameState extends State<EndGame> {
  double _lowerValue = 0;
  String _climbStatus = 'לא נבחר';
  String _whyDidentSucceeded = 'לא נבחר';

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
              selectionInputWidget('סטטוס טיפוס', _climbStatus, ["טיפס בהצלחה", "ניסה ולא הצליח", "לא ניסה"], (val) => setState(() => _climbStatus = val)),
              Padding(padding: EdgeInsets.all(15.0),),
              _climbStatus == "טיפס בהצלחה"
                  ? climb(width, height)
                  : Container(),
              _climbStatus == "ניסה ולא הצליח"
                  ? Column(
                    children: <Widget>[
                      selectionInputWidget('?למה לא הצליח', _whyDidentSucceeded, ["טיפסו ונפלו", "כשל מכני", "אחר"], (val) => setState(() => _whyDidentSucceeded = val)),
                      Padding(padding: EdgeInsets.all(15.0),),
                    ],
                  )
                  : Container(),
              Container(
                width: 200,
                height: 100,
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ScoutingDataReview(teamName: widget.teamName,)),
                    );
                  },
                  child: Text(
                    'בדיקת נתונים',
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
          '?איפה טיפס',
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
                      this._lowerValue = lowerValue;
                      setState(() {});
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
