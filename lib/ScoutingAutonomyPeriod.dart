import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Scouting2018Teleop.dart';
import 'Scouting2019Teleop.dart';

class AutonomyPeriod extends StatefulWidget{
  final String teamName;

  AutonomyPeriod({Key key, @required this.teamName}) : super(key:key);

  @override
  AutonomyPeriodState createState() => AutonomyPeriodState(teamName);
}

class AutonomyPeriodState extends State<AutonomyPeriod>{
  TextEditingController _year = TextEditingController();
  String teamName;

  AutonomyPeriodState(String teamName){
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
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    if (_year.text=='2019'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Teleop2019(teamName: teamName,)),
                      );
                    }
                    if (_year.text=='2018'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Teleop2018(teamName: teamName,)),
                      );
                    }
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