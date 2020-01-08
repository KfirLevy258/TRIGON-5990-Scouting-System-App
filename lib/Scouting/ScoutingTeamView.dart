import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'ScoutingPreGameScreen.dart';
import 'package:flutter/services.dart';

class TeamView extends StatefulWidget{
  final String qualNumber;
  final String tournament;
  final String userId;

  TeamView({Key key, @required this.qualNumber, this.tournament, this.userId}) : super(key:key);

  @override
  Select createState() => Select();
}

class Select extends State<TeamView> {
  String teamNumber = 'Number';
  String teamName = 'Name';
  String url;

  @override
  void initState() {
    setOrientation();
    getTeamData();
    super.initState();
  }

  setOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  getTeamData() {
    Firestore.instance.collection('users').document(widget.userId).collection('tournaments')
        .document(widget.tournament).collection('gamesToScout').getDocuments().then((val) {
          for(int i=0; i<val.documents.length; i++){
            if (val.documents[i].documentID==widget.qualNumber){
              this.teamNumber = val.documents[i].data['teamNumber'];
              getImageURL();
              Firestore.instance.collection('tournaments').document(widget.tournament).collection('teams').document(teamNumber).get().then((res) {
                setState(() {
                  this.teamName = res.data['team_name'];
                });
              });
            }
          }
      });
    }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Qual " + widget.qualNumber.toString(),
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(15.0),),
          Column(
            children: <Widget>[
              Text(
                teamNumber + ' - ' + teamName,
                style: TextStyle(fontSize: 30.0,),
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.all(15.0),),
              robotImage(),
              Padding(padding: EdgeInsets.all(15.0),),
              FlatButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        PreGameScreen(teamName: teamName, teamNumber: teamNumber, tournament: widget.tournament,
                          userId: widget.userId, qualNumber: widget.qualNumber,)),
                  ).then((val) {
                    setOrientation();
                  });
                },
                padding: EdgeInsets.all(20),
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  getImageURL ()
  {
    FirebaseStorage.instance.ref().child('robots_pictures').child(widget.tournament).child(teamNumber).getDownloadURL()
    .then((res) {
      setState(() {
        url = res;
      });
    }).catchError((err) {
      print(err);
      url = null;
      }
    );
  }

  Widget robotImage() {
    return Center(
      child: GestureDetector(
        child: ClipOval(
          child: Container(
            color: Colors.blue,
            height: 250.0,
            width: 250.0,
            child:url != null
                ? Image.network(url, fit: BoxFit.cover,)
                : Container(
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(23.0),),
                    Text(
                      "No\nImage",
                      style: TextStyle(fontSize: 60, color: Colors.white),
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
}
