import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pit_scout/MatchToJson.dart';
import 'package:pit_scout/SuperScouting/SuperGame.dart';
import 'package:pit_scout/Widgets/openquestion.dart';
class TeamsInMatch extends StatefulWidget{

  final int qualNumber;
  final String alliance;
  final String district;
  final String userId;

  TeamsInMatch({Key key, @required this.qualNumber, this.alliance, this.district, this.userId}) : super(key: key);

  @override
  TeamsInMatchState createState() => TeamsInMatchState();
}

setOrientation() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class TeamsInMatchState extends State<TeamsInMatch>{

  Future<Match> match;
  List<String> alliance = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    fetchMatch().then((res) async {
      if (widget.alliance=='Red'){
        setState(() {
          alliance = res.redAlliance;
        });
      } else {
        setState(() {
          alliance = res.blueAlliance;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery. of(context). size. height;
    return Scaffold(
        appBar: AppBar(
        title: Text("Qual " +  widget.qualNumber.toString() + " " + widget.alliance + " alliance", textAlign: TextAlign.center),
    ),
    body: ListView(
      children: <Widget>[
        Center(
          child:
          alliance.isEmpty
              ? Container(
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(height/7),),
                      Text(
                        'Loading...',
                        style: TextStyle(fontSize: 30.0),
                      ),
                      Padding(padding: EdgeInsets.all(15.0),),
                      dataOverride(context),
                    ],
                  ),
                )
              : Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(height/20),),
                  Text(
                    "Qual " + widget.qualNumber.toString() + " - " + widget.alliance + ' alliance',
                    style: TextStyle(fontSize: 30),
                  ),
                  Padding(padding: EdgeInsets.all(10.0),),
                  teamText(alliance[0]),
                  Padding(padding: EdgeInsets.all(10.0),),
                  teamText(alliance[1]),
                  Padding(padding: EdgeInsets.all(10.0),),
                  teamText(alliance[2]),
                  Padding(padding: EdgeInsets.all(15.0),),
                  Container(
                    width: 200,
                    height: 100,
                    child: FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SuperGame(teamsInAlliance: alliance, qualNumber: widget.qualNumber, district: widget.district, userId: widget.userId,)),
                        ).then((_) {
                          setOrientation();
                        });
                      },
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "המשך",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(15.0),),
                  dataOverride(context),
                ],
            ),
          ),
      ],
    ),
    );
  }

  Widget teamText(String label) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 25.0,),
    );
  }

  Future<String> returnDistrictKey() async {
    return Firestore.instance.collection("tournaments").document(widget.district).get().then((val) {
      return  val.data['event_key'];
    });
  }


  Future<Match> fetchMatch() async {
    String districtKey = await returnDistrictKey();
    String httpRequest = "https://www.thebluealliance.com/api/v3/match/" + districtKey + "_qm" + widget.qualNumber.toString() +  "/simple";
    print(httpRequest);
    final response = await http.get(httpRequest, headers: {'X-TBA-Auth-Key':'ptM95D6SCcHO95D97GLFStGb4cWyxtBKNOI9FX5QmBirDnjebphZAEpPcwXNr4vH'});
    if (response.statusCode==200){
      return Match.fromJson(json.decode(response.body), widget.district);
    } else {
      throw Exception('Failed to load match');
    }
  }

  Widget dataOverride(BuildContext context) {
    return Container(
      width: 200,
      height: 75,
      child: FlatButton(
        color: Colors.blue,
        onPressed: () {
          overrideDialog(context);
        },
        child: Text(
          'מעקף',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> overrideDialog(BuildContext context) {
    TextEditingController _firstTeam = new TextEditingController();
    TextEditingController _secondTeam = new TextEditingController();
    TextEditingController _thirdTeam = new TextEditingController();

    return showDialog<void>(
        context: context,
        builder: (BuildContext context){
          double width = MediaQuery. of(context). size. width;

          return AlertDialog(
            title: Text(
              'מעקף - הכנסת מידע חדש',
              style: TextStyle(fontSize: 25.0, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: 300,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      openQuestions('מספר קבוצה', _firstTeam, false, width),
                      Padding(padding: EdgeInsets.all(10.0),),
                      openQuestions('מספר הקבוצה', _secondTeam, false, width),
                      Padding(padding: EdgeInsets.all(10.0),),
                      openQuestions('מספר הקבוצה', _thirdTeam, false, width),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('ביטול'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('שמור'),
                onPressed: () {
                  if (_formKey.currentState.validate()){
                    setState(() {
                      this.alliance.add(_firstTeam.text);
                      this.alliance.add(_secondTeam.text);
                      this.alliance.add(_thirdTeam.text);
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