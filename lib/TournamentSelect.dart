import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'MainMenu.dart';
import 'authentication.dart';
import 'PitScouting/PitTeamSelect.dart';

class TournamentSelectPage extends StatelessWidget {

  TournamentSelectPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tournament Select", textAlign: TextAlign.center),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: this.logoutCallback,
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('tournaments').snapshots(),
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
                            MaterialPageRoute(builder: (context) => MainMenu(tournament: document.documentID,)),
                          );
                        },
                        title: Text(document.documentID),
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
