import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ScoutingTeleop.dart';

class AutonomyPeriod extends StatefulWidget{
  final String teamName;
  final String tournament;
  final String teamNumber;
  AutonomyPeriod({Key key, @required this.teamName, this.tournament, this.teamNumber}) : super(key:key);

  @override
  AutonomyPeriodState createState() => AutonomyPeriodState();
}

class AutonomyPeriodState extends State<AutonomyPeriod>{
  String url;

  @override
  void initState() {
    getImageURL();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Autonomy Period: " + widget.teamName,
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                url==null
                  ? Container()
                  : Image.network(
                    url,

                ),
                Padding(padding: EdgeInsets.all(10.0),),
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Teleop2018(teamName: widget.teamName,)),
                    );
                  },
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Teleop",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getImageURL () {

    FirebaseStorage.instance.ref().child('field_parts')
        .child('rocket.jpeg').getDownloadURL().then((res) {
      setState(() {
        url = res;
      });
    }).catchError((err) {
      url = null;
    }
    );
  }
}