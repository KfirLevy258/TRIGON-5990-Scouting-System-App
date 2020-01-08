import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ScoutingTeleop.dart';

class AutonomousPeriod extends StatefulWidget{
  final String teamName;

  AutonomousPeriod({Key key, @required this.teamName}) : super(key:key);

  @override
  AutonomousPeriodState createState() => AutonomousPeriodState(teamName);
}

class AutonomousPeriodState extends State<AutonomousPeriod>{
  TextEditingController _year = TextEditingController();
  String teamName;

  AutonomousPeriodState(String teamName){
    this.teamName = teamName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
          "Autonomy Period: " + this.teamName,
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(15),),
                Text(
                  'Enter Teleop year:',
                  style: TextStyle(fontSize: 25),
                ),
                Padding(padding: EdgeInsets.all(10.0),),
                Container(
                  width: 250,
                  child: TextField(
                    controller: _year,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintStyle: TextStyle(fontSize: 20),
                        hintText: 'Example: 2018'
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0),),
                GestureDetector(
                  child: Image.asset('assets/stadium.jpg'),
                  onTapDown: ((details)  {
                    final Offset offset = details.localPosition;
                    if (offset.dx > 25 && offset.dx < 79 && offset.dy > 180 && offset.dy < 283) _showDialog(context, 'left goal');
                    if (offset.dx > 573 && offset.dx < 626 && offset.dy > 180 && offset.dy < 283) _showDialog(context, 'right goal');
                  }),
                ),
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Teleop2018(teamName: teamName,)),
                    );
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

void _showDialog(context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  );
}