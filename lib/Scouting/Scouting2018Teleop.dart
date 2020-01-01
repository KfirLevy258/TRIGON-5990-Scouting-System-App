import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ScoutingDataReview.dart';

class Teleop2018 extends StatefulWidget{
  final String teamName;

  Teleop2018({Key key, @required this.teamName}) : super(key:key);

  @override
  Teleop2018State createState() => Teleop2018State(teamName);
}

class Teleop2018State extends State<Teleop2018>{

  String teamName;

  Teleop2018State(String teamName){
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
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DataReview(teamName: teamName)),
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