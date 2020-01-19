import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pit_scout/Widgets/openquestion.dart';

typedef void IntCallback(int data);

class SuperGame extends StatefulWidget {
  @override
  final List<String> teamsInAlliance;
  final int qualNumber;

  SuperGame({Key key, @required this.teamsInAlliance, this.qualNumber}) : super(key: key);

  _SuperGameState createState() => _SuperGameState();
}

class _SuperGameState extends State<SuperGame> {

  TextEditingController _firstTeam = new TextEditingController();
  TextEditingController _secondTeam = new TextEditingController();
  TextEditingController _thirdTeam = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Qual ' + widget.qualNumber.toString()),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Padding(padding: EdgeInsets.all(5),),
              singleTeam(width, widget.teamsInAlliance[0], _firstTeam),
              Padding(padding: EdgeInsets.all(20),),
              singleTeam(width, widget.teamsInAlliance[1], _secondTeam),
              Padding(padding: EdgeInsets.all(20),),
              singleTeam(width, widget.teamsInAlliance[2], _thirdTeam),
              Padding(padding: EdgeInsets.all(15.0)),
              ]
            )
          ),
        ],
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
}

