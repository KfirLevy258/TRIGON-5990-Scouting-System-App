import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AutoPowerCellsCollect extends StatefulWidget {
  @override
  _AutoPowerCellsCollectState createState() => _AutoPowerCellsCollectState();
}

class _AutoPowerCellsCollectState extends State<AutoPowerCellsCollect> {

  setOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void initState() {
    setOrientation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'בחירת מיקום איסוף כדורים',
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: height/3,
                  child: GestureDetector(
                    child: Image.asset(
                      'assets/ClimbCollect.png',
                      fit: BoxFit.fitWidth,
                    ),
                    onTapDown: ((details) {
                      final Offset offset = details.localPosition;
                      print(offset);
                    }),
                  ),
                ),
              ],
            ),
          ),
          powerCellPosition((85.7/411), (142/(660/2.759)), width),
        ],
      ),
    );
  }
}

Widget powerCellPosition(double x, double y, double width){
  print(y);
  print(x);
  final double dx = x * 2 - 1;
  final double dy = y * 2 - 1;

  return Container(
    height: 200,
    width: 400.0,
    child: Align(
      alignment: Alignment(dx, dy),
      child: Container(
        width: width/15,
        child: GestureDetector(
          child: Image.asset(
            'assets/EmptyPowerCell.png',
          ),
          onTapDown: ((val) {
            print(val);
          })
        ),
      ),
    ),
  );
}
