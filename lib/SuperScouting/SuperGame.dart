import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuperGame extends StatefulWidget {
  @override
  final List<String> teamsInAlliance;

  SuperGame({Key key, @required this.teamsInAlliance}) : super(key: key);

  _SuperGameState createState() => _SuperGameState(teamsInAlliance);
}

class _SuperGameState extends State<SuperGame> {

  List<String> teamsInAlliance;
  int speed = 0;

  _SuperGameState(List<String> teamsInAlliance){
    this.teamsInAlliance = teamsInAlliance;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            plusAndMinusButtons(speed, 'Speed')
          ],
        ),
      ),
    );
  }

  Widget plusAndMinusButtons(int init, String label){
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: TextStyle(fontSize: 25.0),
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
                    init = init - 1;
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
                    init = init + 1;
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

