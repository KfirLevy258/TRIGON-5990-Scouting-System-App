import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pit_scout/Widgets/alert.dart';
import 'package:provider/provider.dart';

import '../addToScouterScore.dart';

class ShotFrom extends StatefulWidget {
  final String userId;

  const ShotFrom({Key key, this.userId}) : super(key: key);

  @override
  _ShotFromState createState() => _ShotFromState();
}

class _ShotFromState extends State<ShotFrom> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(height);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shot from',
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: (height-80),
              child: GestureDetector(
                child: Image.asset(
                  'assets/Field.png',
                  fit: BoxFit.fitWidth,
                ),
                onTapDown: ((details) {
                  final Offset offset = details.localPosition;
                  Navigator.pop(context, offset);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
