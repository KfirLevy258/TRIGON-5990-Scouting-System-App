import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ScoutingDataReview.dart';

class Teleop2019 extends StatefulWidget{
  final String teamName;

  Teleop2019({Key key, @required this.teamName}) : super(key:key);

  @override
  Teleop2019State createState() => Teleop2019State(teamName);
}

class Teleop2019State extends State<Teleop2019>{

  String teamName;

  Teleop2019State(String teamName){
    this.teamName = teamName;
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> screens = [
      defaultScreen("Defence"),
      defaultScreen("Attack"),

    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Teleop: " + this.teamName,
            textAlign: TextAlign.center,
          ),
          bottom: new TabBar(
            labelStyle: TextStyle(fontSize: 17),
            tabs: <Widget> [
              Tab(
                text: "Defence",
              ),
              Tab(
                text: 'Attack',
              ),
            ]
          ),
        ),
        body: TabBarView(
            children: screens,
        ),
      ),
    );
  }

  Widget defaultScreen(String text){
    return ListView(
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
                  "Finish \n " + text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}