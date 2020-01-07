import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/PitScouting/PitTeamDataInput.dart';
import 'package:pit_scout/Scouting/ScoutingPreGameScreen.dart';
import 'package:pit_scout/Scouting/ScoutingTeamView.dart';

class SchedulePage extends StatefulWidget {
  final String tournament;
  final String userId;

  SchedulePage({Key key, this.tournament, this.userId}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String userName;
  String url;
  List<Widget> pitsToScout;
  List<Widget> gamesToScout;

  @override
  void initState() {
     getUserName();
     getImageURL();
     getPitsToScout();
     getGamesToScout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            scouterNameWidget(),
            Text(
              userName == null
                  ? "Scouter Name"
                  : userName,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.all(8.0),),
            createLineWidget(),
            Padding(padding: EdgeInsets.all(4.0),),
            pitsToScoutList(":הפיטים שלי", pitsToScout),
            Padding(padding: EdgeInsets.all(8.0),),
            createLineWidget(),
            Padding(padding: EdgeInsets.all(4.0),),
            pitsToScoutList(":המשחקים שלי", gamesToScout),
          ],
        ),
      ),
    );
  }

  Widget scouterNameWidget(){
    return Center(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10.0),),
          scouterImage(),
          Padding(padding: EdgeInsets.all(8.0),),
        ],
      ),
    );
  }

  getUserName() {
    Firestore.instance.collection('users').document(widget.userId).get()
        .then((res) {
      setState(() {
        userName = res.data['name'];
      });
    });
  }

  getPitsToScout() {
    pitsToScout = [];
    Firestore.instance.collection('users').document(widget.userId).collection('tournaments').document(widget.tournament).collection('pitsToScout').getDocuments().then((val) {
      for (int i=0; i<val.documents.length; i++){
        String teamName;
        bool saved;
        Firestore.instance.collection('tournaments').document(widget.tournament).collection('teams').document(val.documents[i].documentID).get().then((res) {
          teamName = res.data['team_name'];
          saved = res.data['pit_scouting_saved'];
          if (saved == false) {
            setState(() {
              pitsToScout.add(ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TeamDataPage(teamName: teamName, teamNumber: val.documents[i].documentID, tournament: widget.tournament, saved: saved,)),
                  );
                },
                title: Text(
                  val.documents[i].documentID + ' - ' + teamName,
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ));

            });
          }
          if (pitsToScout.isEmpty){
            pitsToScout.add(Text(
              "Good Job!\nYou finishd all your pits work!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ));
          }
        });
      }
    });
  }

  getGamesToScout() {
    gamesToScout = [];
    Firestore.instance.collection('users').document(widget.userId).collection('tournaments').document(widget.tournament).collection('gamesToScout').getDocuments().then((val) {
      for (int i=0; i<val.documents.length; i++){
        String teamNumber = val.documents[i].data['teamNumber'];
        String matchNumber = val.documents[i].documentID;
        String teamName;
        Firestore.instance.collection('tournaments').document(widget.tournament).collection('teams').document(teamNumber).get().then((res) {
          teamName = res.data['team_name'];
          setState(() {
            gamesToScout.add(ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamView(tournament: widget.tournament, userId: widget.userId, qualNumber: val.documents[i].documentID,)),
                );
              },
              title: Text(
                "Qual " + matchNumber + " - " + teamNumber + ' ' + teamName,
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ));
            if (gamesToScout.isEmpty){
              gamesToScout.add(Text(
                "Good Job!\nYou finishd all your games work!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ));
            }
          });
        });
      }
    });
  }

  Widget pitsToScoutList(String label, List<Widget> list) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic, color: Colors.blue),
        ),
        Padding(padding: EdgeInsets.all(4.0),),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: list,
        ),
      ],
    );
  }

  Widget createLineWidget(){
    return Container(
      height: 2,
      width: 1000,
      color: Colors.grey,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Padding(padding: EdgeInsets.all(10.0),),
    );
  }

  Widget scouterImage() {
    return Center(
      child: GestureDetector(
        child: ClipOval(
          child: Container(
            color: Colors.blue,
            height: 120.0,
            width: 120.0,
            child:url != null
                ? Image.network(url, fit: BoxFit.cover,)
                : Container(
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(10.0),),
                      Text(
                        "No\nImage",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ),
    );
  }

  getImageURL () {
    FirebaseStorage.instance.ref().child('users').child(
        widget.userId + '.jpeg').getDownloadURL()
        .then((res) {
        setState(() {
          url = res;
        });
    }).catchError((err) {
      url = null;
    });
  }
}

