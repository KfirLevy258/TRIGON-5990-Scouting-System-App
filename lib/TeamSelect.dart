import 'package:flutter/material.dart';
import 'TeamData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final List<String> teams = ["5990 - TRIGON", "1690 - Orbit"];

class TeamSelectPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TRIGON 5990 - Pit Scouting App"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('pitScouting').snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading...');
                default:
                  return ListView(
                    children: snapshot.data.documents
                    .map((DocumentSnapshot document) {
                      print(document);
                      return  ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TeamDataPage(nameOfTeam: document['team_name'],)),
                          );
                        },
                        title: Text(document['team_name']),
                        leading: Icon(Icons.build, color: document['saved'] ? Colors.blue : Colors.red),
                      );

//                      return CustomCard(
//                        team_number: document['team_number'],
//                        team_name: document['team_name']
//                      );
                    }).toList(),
                  );
              }
            },
          ),
        ),
      ),

//      body: ListView(
//          children: listData(context, teams)
//      ),
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
              MaterialPageRoute(builder: (context) => TeamDataPage(nameOfTeam: list[i],)),
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

