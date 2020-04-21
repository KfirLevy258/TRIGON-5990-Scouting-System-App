import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Widgets/AllianceSelect.dart';
import 'package:pit_scout/Widgets/alert.dart';
import 'package:pit_scout/Widgets/openquestion.dart';
import 'package:pit_scout/Widgets/numericInput.dart';
import '../addToScouterScore.dart';
import 'ScoutingPreGameScreen.dart';
import 'package:flutter/services.dart';

class ScoutingTeamView extends StatefulWidget{
  final String qualNumber;
  final String tournament;
  final String userId;
  final String matchKey;

  ScoutingTeamView({Key key, @required this.qualNumber, this.tournament, this.userId, this.matchKey}) : super(key:key);

  @override
  Select createState() => Select();
}


class Select extends State<ScoutingTeamView> {
  String teamNumber = 'Number';
  String teamName = 'Name';
  String allianceColor = 'color';
  String url;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
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
            if (val.documents[i].documentID==widget.matchKey){
              this.teamNumber = val.documents[i].data['teamNumber'];
              this.allianceColor = val.documents[i].data['allianceColor'];
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
          teamNumber == 'Number'
              ? Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(20.0),),
                  Text(
                    'You dont need to do scouting at this match',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40),
                  ),
                  Padding(padding: EdgeInsets.all(20.0),),
                  dataOverride(context),

                ],
              )
              : Column(
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
                      dataOverride(context),
                      Padding(padding: EdgeInsets.all(15.0),),
                      Container(
                        width: 220,
                        height: 100,
                        child: FlatButton(
                          color: Colors.blue,
                          onPressed: () {
                            print(this.allianceColor);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  ScoutingPreGameScreen(teamName: teamName, teamNumber: teamNumber, tournament: widget.tournament,
                                    userId: widget.userId, qualNumber: widget.qualNumber, allianceColor: allianceColor, matchKey: widget.matchKey,)),
                            ).then((_) {
                              setOrientation();
                            });
                          },
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Continue",
                            style: TextStyle(fontSize: 40, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
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

  Widget dataOverride(BuildContext context) {
    return Container(
      width: 220,
      height: 75,
      child: FlatButton(
        color: Colors.blue,
        onPressed: () {
          overrideDialog(context);
        },
        child: Text(
          'Override',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
      ),
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
                ? RotatedBox(
                  quarterTurns: 5,
                  child: Image.network(url, fit: BoxFit.cover,),
                )
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

  Future<void> overrideDialog(BuildContext context) {
    TextEditingController _newTeamNumber = new TextEditingController();
    TextEditingController _newTeamName = new TextEditingController();
    String _allianceColor = this.allianceColor;
    return showDialog<void>(
        context: context,
        builder: (BuildContext context){
          double width = MediaQuery. of(context). size. width;

          return AlertDialog(
            title: Text(
              'Override - new data',
              style: TextStyle(fontSize: 25.0, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: 200,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      openQuestions('Team number', _newTeamNumber, false, width),
                      Padding(padding: EdgeInsets.all(10.0),),
                      allianceSelect((val) {
                        setState(() {
                          if (val=='Red'){
                            _allianceColor = 'red';
                          } else if (val=='Blue'){
                            _allianceColor = 'blue';
                          }
                        });
                      }),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('save'),
                onPressed: () {
                  if (_formKey.currentState.validate()){
                    setState(() {
                      this.teamNumber = _newTeamNumber.text;
                      this.teamName = _newTeamName.text;
                      this.allianceColor = _allianceColor;
                    });
                    Navigator.of(context).pop();
                  }
                },
              ),

            ],
          );
        }
    );
  }
}


