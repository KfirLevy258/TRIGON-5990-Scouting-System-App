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

class PitScoutingPage extends StatefulWidget{
  final String title;
  PitScoutingPage({Key key, this.title}) : super(key: key);

  @override
  TeamPage createState() => TeamPage();

}

class TeamPage extends State<PitScoutingPage> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        textFieldCreator("Robot Weight", "Pounds"),
        textFieldCreator("Robot Width", "Inches"),
        textFieldCreator("Robot Length", "Inches"),
        textFieldCreator("DT Motors", "Amount"),
      ],
    );
  }

  Widget toggleButtonsCreator(){
    // TO DO :
    // make some kind of Toggle Buttons function that get an array
  }

  Widget textFieldCreator(String text, String kind){
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