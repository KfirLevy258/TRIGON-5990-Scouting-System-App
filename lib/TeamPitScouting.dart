import 'package:flutter/material.dart';

class TeamPitScouting extends StatelessWidget {
  final String nameOfTeam;
  TeamPitScouting({Key key, @required this.nameOfTeam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameOfTeam),
      ),
      body: PitScoutingPage()
      );
  }
}

class PitScoutingPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        row("Robot Weight", "Pounds"),
        row("Robot Width", "Inches"),
        row("Robot Length", "Inches"),
        row("DT Motors", "Amount"),

      ],
    );
  }

  Widget row(String text, String kind){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
        child: TextField(
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 50, right: 50, top: 20),
            labelText: text,
            labelStyle: TextStyle(color: Colors.blue, fontSize: 20),
            hintText: kind,
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}