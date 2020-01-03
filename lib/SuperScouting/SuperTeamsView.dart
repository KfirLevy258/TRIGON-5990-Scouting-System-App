import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pit_scout/MatchToJson.dart';
import 'package:pit_scout/SuperScouting/SuperGame.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class TeamsInMatch extends StatefulWidget{

  final int qualNumber;
  final String alliance;
  final String district;

  TeamsInMatch({Key key, @required this.qualNumber, this.alliance, this.district}) : super(key: key);

  @override
  TeamsInMatchState createState() => TeamsInMatchState(qualNumber, alliance, district);
}

class TeamsInMatchState extends State<TeamsInMatch>{

  String district;
  int qualNumber;
  String alliance;
  Future<Match> match;
  List<String> blueAlliance = [];
  List<String> redAlliance = [];

  TeamsInMatchState(int qualNumber, String alliance, String district){
    this.alliance = alliance;
    this.qualNumber = qualNumber;
    this.district = district;
    fetchMatch().then((res) async {
      print(res.redAlliance);
      print(res.blueAlliance);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Qual " +  qualNumber.toString() + " " + alliance + " alliance", textAlign: TextAlign.center),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            qualNumber.toString() + " - " + alliance,
            ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuperGame(teamsInAlliance: alliance=='red' ? redAlliance : blueAlliance,)),
              );
            },
            padding: EdgeInsets.all(20),
            child: Text(
              "Continue",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          ],
        ),
      ),
    );
  }

//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Super Teams View"),
//      ),
//      body: Center(
//        child: Container(
//          padding: EdgeInsets.all(10.0),
//          child: StreamBuilder<QuerySnapshot>(
//            stream: Firestore.instance.collection('tournaments').document(district).collection('teams').snapshots(),
//            builder: (BuildContext context,
//                AsyncSnapshot<QuerySnapshot> snapshot) {
//              if (snapshot.hasError)
//                return Text('Error: ${snapshot.error}');
//              switch (snapshot.connectionState) {
//                case ConnectionState.waiting:
//                  return Text('Loading...');
//                default:
//                  return ListView(
//                    children: snapshot.data.documents
//                        .map((DocumentSnapshot document) {
//                      return  ListTile(
//                        title: Text(
//                          document.documentID + " - " + document['team_name'],
//                          textAlign: TextAlign.center,
////                          style: TextStyle(),
//                        ),
//                      );
//                    }).toList(),
//                  );
//              }
//            },
//          ),
//        ),
//      ),
//    );
//  }

  Future<String> returnDistrictKey() async {
    return Firestore.instance.collection("tournaments").document(this.district).get().then((val) {
      return  val.data['event_key'];

    });

  }

  Future<String> getTeamName(String teamNumber) async{
    return Firestore.instance.collection('tournaments').document(district).collection('teams').document(teamNumber).get().then((val) {
      return val.data['team_name'];
    });
  }

  Future<Widget> teamsView(String color) async{
    if (color=='red')
      return await allianceByColor(redAlliance);
    if (color=='blue')
      return await allianceByColor(blueAlliance);
    return null;
  }

  Future<Widget> allianceByColor(List<String> alliance) async{
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: await textForTeams(alliance)
    );
  }

  Future<List<Widget>> textForTeams(List<String> alliance) async{
    List<Widget> text = [];
    for (int i=0; i<alliance.length; i++){
      text.add(Text(
        alliance[i] = ' - ' + await getTeamName(alliance[i]),
        style: TextStyle(fontSize: 20),
      ));
    }
    return text;
  }

  Future<Match> fetchMatch() async {
    String districtKey = await returnDistrictKey();
    String httpRequest = "https://www.thebluealliance.com/api/v3/match/" + districtKey + "_qm" + qualNumber.toString() +  "/simple";
    print(httpRequest);
    final response = await http.get(httpRequest, headers: {'X-TBA-Auth-Key':'ptM95D6SCcHO95D97GLFStGb4cWyxtBKNOI9FX5QmBirDnjebphZAEpPcwXNr4vH'});
    if (response.statusCode==200){
      return Match.fromJson(json.decode(response.body), district);
    } else {
      throw Exception('Failed to load match');
    }
  }
}