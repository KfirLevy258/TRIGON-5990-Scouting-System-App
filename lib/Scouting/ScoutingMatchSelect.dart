import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ScoutingTeamSelect.dart';

class MatchSelect extends StatefulWidget {

  final String tournament;

  MatchSelect({Key key, this.tournament}) : super(key: key);

  @override
  MatchSelectState createState() => MatchSelectState(tournament);
}

class MatchSelectState extends State<MatchSelect> {
  TextEditingController _qualNumber = TextEditingController();
  String tournament;

  MatchSelectState(String tournament){
    this.tournament = tournament;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter Qual number:',
              style: TextStyle(fontSize: 25),
            ),
            Padding(padding: EdgeInsets.all(10.0),),
            Container(
              width: 250,
              child: TextField(
                controller: _qualNumber,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                    hintStyle: TextStyle(fontSize: 20),
                    hintText: 'Example: 42'
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0),),
            FlatButton(
              color: Colors.blue,
              onPressed: () {
                if (canMoveToNExtPage()){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TeamSelect(qualNumber: _qualNumber.text,)),
                  );
                }
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

  bool canMoveToNExtPage(){
    if (_qualNumber.text==''){
      return false;
    }
    return true;
  }
}
