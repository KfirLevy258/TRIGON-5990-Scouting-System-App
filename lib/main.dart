import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'TeamPitScouting.dart';
final List<String> teams = ["5990 - TRIGON", "1690 - Orbit"];
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title = 'Kfir Levy';

    return MaterialApp(
      title: title,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TRIGON 5990 - Pit Scouting App"),
        ),
        body: ListView(
          children: listData(context, teams)
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
              MaterialPageRoute(builder: (context) => TeamPitScouting(nameOfTeam: list[i],)),
            );
          },
          title: Text(list[i]),
          leading: Icon(Icons.build, color: Colors.red),
        ),
      );
    }
    return listOfWidgets;
  }
}