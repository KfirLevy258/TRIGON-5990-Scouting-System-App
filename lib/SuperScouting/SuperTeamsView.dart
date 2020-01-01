import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pit_scout/MatchToJson.dart';
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

  TeamsInMatchState(int qualNumber, String alliance, String district){
    this.alliance = alliance;
    this.qualNumber = qualNumber;
    this.district = district;
    fetchMatch()
    .then((res) {
      dynamic blue1 = res.blueAllianceKeys[0].toString().substring(3);
      dynamic blue2 = res.blueAllianceKeys[1].toString().substring(3);
      dynamic blue3 = res.blueAllianceKeys[2];
      dynamic blue1Name;
      print(district);
      print(blue1);
      Firestore.instance.collection('tournaments').document(district).collection('teams').document(blue2).get().then((res1) {
        print(res1.data);
      });
      print(res.blueAllianceKeys);
    });
//    match = fetchMatch();
//    print('data ' + match.toString());
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
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => TeamsInMatch(qualNumber: int.parse(_matchController.text), alliance: alliance)),
//              );
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

  Future<String> returnDistrictKey() async {
    return Firestore.instance.collection("tournaments").document(this.district).get().then((val) {
      return  val.data['event_key'];

    });

  }

  Future<Match> fetchMatch() async {
    String districtKey = await returnDistrictKey();
    String httpRequest = "https://www.thebluealliance.com/api/v3/match/" + districtKey + "_qm" + qualNumber.toString() +  "/simple";
    print(httpRequest);
    final response = await http.get(httpRequest, headers: {'X-TBA-Auth-Key':'ptM95D6SCcHO95D97GLFStGb4cWyxtBKNOI9FX5QmBirDnjebphZAEpPcwXNr4vH'});
    if (response.statusCode==200){
      return Match.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load match');
    }
  }
}