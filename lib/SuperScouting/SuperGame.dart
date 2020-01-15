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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.qualNumber.toString()),
      ),
      body: Center(
        child: allAllianceTeams(),
      ),
    );
  }

  Widget singleTeam(){
    return Column(
      children: <Widget>[
        plusAndMinusButtons(speed, 'Speed', 0, 5, ((val) {
          setState(() {
            this.speed = val;
          });
        })),
        plusAndMinusButtons(ability, 'Ability', 0, 5, ((val) {
          setState(() {
            this.ability = val;
          });
        }))
      ],
    );
  }

  Widget allAllianceTeams(){
    return Row(
      children: <Widget>[
        singleTeam(),
        singleTeam(),
        singleTeam(),
      ],
    );
  }

  Widget plusAndMinusButtons(int init, String label, int minVal, int maxVal, IntCallback callback){
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              'אנא דרג את הקבוצה בסולם של ' + minVal.toString() + ' עד ' + maxVal.toString()
            ),
            Padding(padding: EdgeInsets.all(4.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
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
                Padding(padding: EdgeInsets.all(8.0),),
                Text(
                  init.toString(),
                  style: TextStyle(fontSize: 30.0),
                ),
                Padding(padding: EdgeInsets.all(8.0),),
                FlatButton(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

