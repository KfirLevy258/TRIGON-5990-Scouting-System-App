import 'package:flutter/material.dart';
import 'ScoutingPreGameScreen.dart';

class TeamSelect extends StatefulWidget{
  final String qualNumber;

  TeamSelect({Key key, @required this.qualNumber}) : super(key:key);

  @override
  Select createState() => Select(qualNumber);
}

class Select extends State<TeamSelect> {
  String qualNumber;
  List<String> demoList = ["5990 - TRIGON", "1690 - Orbit"];

  Select(String number) {
    qualNumber = number;
  }

  @override
  Widget build(BuildContext context) {
    print(this.qualNumber);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Qual number: " + qualNumber.toString() + " - Team Select",
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children:listData(context, demoList)
      ),
    );
  }


  List<Widget> listData(context, List<String> list) {
    List<Widget> listOfWidgets = [];
    for (int i=0; i<list.length; i++){
      listOfWidgets.add(
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PreGameScreen(teamName: list[i],)),
            );
          },
          title: Text(
            list[i],
            style: TextStyle(fontSize: 20),
          ),
          leading: Icon(Icons.fingerprint),
        ),
      );
    }
    return listOfWidgets;
  }
}
