import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pit_scout/MatchToJson.dart';
import 'package:pit_scout/SuperScouting/SuperGame.dart';
class TeamsInMatch extends StatefulWidget{

  final int qualNumber;
  final String alliance;
  final String district;

  TeamsInMatch({Key key, @required this.qualNumber, this.alliance, this.district}) : super(key: key);

  @override
  TeamsInMatchState createState() => TeamsInMatchState();
}

setOrientation() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class TeamsInMatchState extends State<TeamsInMatch>{

  Future<Match> match;
  List<String> alliance = [];

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
                    ],
                  ),
                )
              : Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(height/10),),
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
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SuperGame(teamsInAlliance: alliance, qualNumber: widget.qualNumber,)),
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
}