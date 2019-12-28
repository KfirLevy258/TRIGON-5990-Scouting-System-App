import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeamsInMatch extends StatefulWidget{

  final int qualNumber;
  final String alliance;

  TeamsInMatch({Key key, @required this.qualNumber, this.alliance}) : super(key: key);

  @override
  TeamsInMatchState createState() => TeamsInMatchState(qualNumber, alliance);
}

class TeamsInMatchState extends State<TeamsInMatch>{

  String district = 'ISRD1';
  int qualNumber;
  String alliance;

  TeamsInMatchState(int qualNumber, String alliance){
    this.alliance = alliance;
    this.qualNumber = qualNumber;
    print (fetchPost());
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
          //to do:
          // show teams in match
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

  String returnDistrictKey(){
    if(district=='ISRD1')
//      return '2020isde1';
      return '2019isde1';
    if (district=='ISRD3');
//      return '2020isde3';
      return '2019isde3';

  }

  Future<http.Response> fetchPost() {
    String httpRequest = "https://www.thebluealliance.com/api/v3/match/" + returnDistrictKey() + "_qm" + qualNumber.toString() +  "/simple";
    print(httpRequest);
    return http.get(httpRequest, headers: {'X-TBA-Auth-Key':'ptM95D6SCcHO95D97GLFStGb4cWyxtBKNOI9FX5QmBirDnjebphZAEpPcwXNr4vH'});
  }
}