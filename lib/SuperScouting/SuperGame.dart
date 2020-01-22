import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Widgets/openquestion.dart';

typedef void IntCallback(int data);

class SuperGame extends StatefulWidget {

  final List<String> teamsInAlliance;
  final int qualNumber;
  final String district;

  SuperGame({Key key, @required this.teamsInAlliance, this.qualNumber, this.district}) : super(key: key);

  _SuperGameState createState() => _SuperGameState();
}

class _SuperGameState extends State<SuperGame> {

  TextEditingController _firstTeam = new TextEditingController();
  TextEditingController _secondTeam = new TextEditingController();
  TextEditingController _thirdTeam = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Qual ' + widget.qualNumber.toString()),
        ),
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5),),
            singleTeam(width, widget.teamsInAlliance[0], _firstTeam),
            Padding(padding: EdgeInsets.all(20),),
            singleTeam(width, widget.teamsInAlliance[1], _secondTeam),
            Padding(padding: EdgeInsets.all(20),),
            singleTeam(width, widget.teamsInAlliance[2], _thirdTeam),
            Padding(padding: EdgeInsets.all(15.0)),
            submitButton(context),
            Padding(padding: EdgeInsets.all(10.0)),
          ],
        ),
      ),
    );
  }

  Widget singleTeam(double width, String number, TextEditingController controller){
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10.0),),
        Text(
          number,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 35),
        ),
        Padding(padding: EdgeInsets.all(15.0),),
        openQuestions('הערה', controller, true, (width-40)),
      ],
    );
  }

  Widget submitButton(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      child: FlatButton(
        color: Colors.blue,
        onPressed: () {
          saveToFireBase(widget.teamsInAlliance[0], _firstTeam);
          saveToFireBase(widget.teamsInAlliance[1], _secondTeam);
          saveToFireBase(widget.teamsInAlliance[2], _thirdTeam);

          Navigator.pop(context);
          Navigator.pop(context);

        },
        child: Text(
          'סיים משחק',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }

  Widget plusAndMinusButtons(int init, String label, double width , int minVal, int maxVal, IntCallback callback){
    return Container(
      width: width/4,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              'אנא דרג את הקבוצה בסולם של ' + minVal.toString() + ' עד ' + maxVal.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.0),
            ),
            Padding(padding: EdgeInsets.all(4.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: width/17,
                  child: FlatButton(
                    child: Text(
                      '-',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.0),
                    ),
                    color: Colors.redAccent,
                    onPressed: () {
                      setState(() {
                        if (init-1>=minVal && init-1<=maxVal)
                          callback(init-1);
                      });
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.0),),
                Text(
                  init.toString(),
                  style: TextStyle(fontSize: 30.0),
                ),
                Padding(padding: EdgeInsets.all(8.0),),
                Container(
                  width: width/17,
                  child: FlatButton(
                    child: Text(
                      '+',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.0),
                    ),
                    color: Colors.lightGreen,
                    onPressed: () {
                      if (init+1>=minVal && init+1<=maxVal)
                        callback(init+1);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  saveToFireBase(String teamNumber, TextEditingController controller) {
    Firestore.instance.collection("tournaments").document(widget.district)
        .collection('teams').document(teamNumber).collection('Qual ' +
        widget.qualNumber.toString()).document('superScouting').setData({
      'message' : controller.text,
    });
  }
}

