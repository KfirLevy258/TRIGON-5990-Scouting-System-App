import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/MainMenu.dart';

class DataReview extends StatefulWidget{
  final String teamName;

  DataReview({Key key, @required this.teamName}) : super(key:key);

  @override
  DataReviewState createState() => DataReviewState(teamName);
}

class DataReviewState extends State<DataReview>{
  String teamName;

  DataReviewState(String teamName){
    this.teamName = teamName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Data Review: " + this.teamName,
            textAlign: TextAlign.center,
          ),
        ),
        body: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(15.0),),
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainMenu(currentIndex: 1,)),
                      );
                    },
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}