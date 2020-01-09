import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Field/PowerPort.dart';
import 'ScoutingTeleop.dart';

class AutonomousPeriod extends StatefulWidget{
  final String teamName;

  AutonomousPeriod({Key key, @required this.teamName}) : super(key:key);

  @override
  AutonomousPeriodState createState() => AutonomousPeriodState(teamName);
}

class AutonomousPeriodState extends State<AutonomousPeriod>{
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
                powerPort(context),
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
