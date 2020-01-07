import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ScoutingTeamView.dart';

class MatchSelect extends StatefulWidget {
  final String userId;
  final String tournament;

  MatchSelect({Key key, this.tournament, this.userId}) : super(key: key);

  @override
  MatchSelectState createState() => MatchSelectState();
}

class MatchSelectState extends State<MatchSelect> {
  TextEditingController _qualNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _matchController = TextEditingController();

  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'Enter Qual number:',
//              style: TextStyle(fontSize: 25),
//            ),
//            Padding(padding: EdgeInsets.all(10.0),),
//            Container(
//              width: 250,
//              child: TextField(
//                controller: _qualNumber,
//                textAlign: TextAlign.center,
//                decoration: InputDecoration(
//                    border: new OutlineInputBorder(
//                        borderSide: new BorderSide(color: Colors.teal)),
//                    hintStyle: TextStyle(fontSize: 20),
//                    hintText: 'Example: 42'
//                ),
//              ),
//            ),
//            Padding(padding: EdgeInsets.all(10.0),),
//            FlatButton(
//              color: Colors.blue,
//              onPressed: () {
//                if (canMoveToNExtPage()){
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => TeamSelect(qualNumber: _qualNumber.text,)),
//                  );
//                }
//              },
//              padding: EdgeInsets.all(20),
//              child: Text(
//                "Continue",
//                style: TextStyle(fontSize: 40, color: Colors.white),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }

  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
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
                  child: TextFormField(
                    controller: _matchController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter value';
                      }
                      if (!this.isNumeric(value)) {
                        return 'Please enter only digits';
                      }
                      double numericValue = double.parse(value);
                      if (numericValue < 0) {
                        return 'Value must be bigger then 0';
                      }
                      return null;
                    },
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
                    if (_formKey.currentState.validate()){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TeamView(qualNumber: _matchController.text, tournament: widget.tournament, userId: widget.userId,)),
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
        )
    );
  }


  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  bool canMoveToNExtPage(){
    if (_qualNumber.text==''){
      return false;
    }
    return true;
  }
}
