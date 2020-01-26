import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Model/GameDataModel.dart';
import 'package:pit_scout/PitScouting/PitDataConsume.dart';
import 'package:pit_scout/Scouting/ScoutingTeamView.dart';
import 'package:pit_scout/Widgets/alert.dart';
import 'package:pit_scout/Widgets/selectionInput.dart';
import 'package:provider/provider.dart';

import '../addToScouterScore.dart';

class SchedulePage extends StatefulWidget {
  final String tournament;
  final String userId;

  SchedulePage({Key key, this.tournament, this.userId}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String userName;
  int userScore;
  String url;
  List<Widget> pitsToScout;
  List<Widget> gamesToScout;


  @override
  void initState() {
    pitsToScout = [];
    gamesToScout = [];
    getUserData();
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
            Text(
              userScore == null
                  ? "Scouter Scor"
                  : "ניקוד: " + userScore.toString(),
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

  getUserData() {
    Firestore.instance.collection('users').document(widget.userId).get()
        .then((res) {
      setState(() {
        userName = res.data['name'];
        userScore = res.data['score'];

      });
    });
  }

  getPitsToScout() {
    Firestore.instance.collection('users').document(widget.userId).collection('tournaments').document(widget.tournament).collection('pitsToScout').getDocuments().then((val) {
      for (int i=0; i<val.documents.length; i++){
        String teamName ='';
        bool saved = false;
        Firestore.instance.collection('tournaments').document(widget.tournament).collection('teams').document(val.documents[i].documentID).get().then((res) {
          teamName = res.data['team_name'];
          saved = res.data['pit_scouting_saved'];
          if (saved == false) {
            setState(() {
              pitsToScout.add(ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PitDataConsume(teamName: teamName, teamNumber: val.documents[i].documentID, tournament: widget.tournament, saved: saved,)),
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
        });
      }
    });
  }

  getGamesToScout() {
    Firestore.instance.collection('users').document(widget.userId).collection('tournaments').document(widget.tournament).collection('gamesToScout').getDocuments().then((val) {
      for (int i=0; i<val.documents.length; i++){
        String teamNumber = val.documents[i].data['teamNumber'];
        String matchNumber = val.documents[i].documentID;
        bool saved = val.documents[i].data['saved'];
        String teamName = '';
        if (!saved){
          Firestore.instance.collection('tournaments').document(widget.tournament).collection('teams').document(teamNumber).get().then((res) {
            teamName = res.data['team_name'];
            setState(() {
              gamesToScout.add(ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScoutingTeamView(tournament: widget.tournament, userId: widget.userId, qualNumber: val.documents[i].documentID,)),
                  );
                },
                title: Text(
                  "Qual " + matchNumber + " - " + teamNumber + ' ' + teamName,
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ));
            });
          });
        }
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
            children: list.isEmpty
              ? <Widget>[
                  Text(
                    '!עבודה טובה\nסיימת את כל העבודה',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  )
                ]
              : list,
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
        onTap: () {
          addToScouterScore(15, widget.userId);
          alert(
              context,
              'מצאת איסטר אג! #7',
              'על איסטר אג זה קיבלת 15 נקודות! תזכור לא לספר לחברים שלך בכדי להיות במקום הראשון'
          );
        },
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

