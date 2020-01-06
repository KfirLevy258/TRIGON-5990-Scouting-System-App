import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'PitTeamDataInput.dart';

class TeamSelectPage extends StatelessWidget{
  final String tournament;

  TeamSelectPage({Key key, this.tournament}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          MaterialPageRoute(builder: (context) => TeamDataPage(teamName: document['team_name'], teamNumber: document.documentID, tournament: tournament, saved: document['pit_scouting_saved'],)),
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

