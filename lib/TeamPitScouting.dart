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
      body: Center(
        child: Text(
          "This is the page for $nameOfTeam",
          textAlign: TextAlign.center,
          style: TextStyle(height: 5, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
