import 'package:flutter/material.dart';
import 'TeamData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'TeamData2.dart';

class TeamSelectPage extends StatelessWidget{
  final String tournament;

  TeamSelectPage({Key key, this.tournament}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Team to Scout", textAlign: TextAlign.center),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('tournaments').document(tournament).collection('teams').snapshots(),
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
                      return  ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TeamData2Page(teamName: document['team_name'], teamNumber: document.documentID, districtName: tournament,)),
                          );
                        },
                        title: Text(document.documentID + " - " + document['team_name']),
                        leading: Icon(Icons.build,
                            color: document['pit_scouting_saved']
                            ? Colors.blue : Colors.red
                        ),
                      );
                    }).toList(),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

}

