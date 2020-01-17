import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void IntCallback(int data);

class SuperGame extends StatefulWidget {
  @override
  final List<String> teamsInAlliance;
  final int qualNumber;

  SuperGame({Key key, @required this.teamsInAlliance, this.qualNumber}) : super(key: key);

  _SuperGameState createState() => _SuperGameState();
}

setOrientation() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
}

class _SuperGameState extends State<SuperGame> {

  int speed = 0;
  int ability = 0;

  @override
  void initState() {
    setOrientation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.qualNumber.toString()),
      ),
      body: Center(
        child: allAllianceTeams(width, widget.teamsInAlliance),
      ),
    );
  }

  Widget singleTeam(double width, String number){
    return Column(
      children: <Widget>[
        Text(
          number,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 35),
        ),
        Padding(padding: EdgeInsets.all(5),),

        plusAndMinusButtons(speed, 'מהירות', width, 0, 5, ((val) {
          setState(() {
            this.speed = val;
          });
        })),
        Padding(padding: EdgeInsets.all(5),),
        plusAndMinusButtons(ability, 'יכולת', width, 0, 5, ((val) {
          setState(() {
            this.ability = val;
          });
        }))
      ],
    );
  }

  Widget allAllianceTeams(double width, List<String> list){
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(5),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            singleTeam(width, list[0]),
            Padding(padding: EdgeInsets.all(20),),
            singleTeam(width, list[1]),
            Padding(padding: EdgeInsets.all(20),),
            singleTeam(width, list[2]),
          ],
        ),
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
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              'אנא דרג את הקבוצה בסולם של ' + minVal.toString() + ' עד ' + maxVal.toString(),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.all(4.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: width/15,
                  child: FlatButton(
                    child: Text(
                      '-',
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
                  width: width/15,
                  child: FlatButton(
                    child: Text(
                      '+',
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

