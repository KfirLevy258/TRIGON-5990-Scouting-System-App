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
            child: GestureDetector(
              child: Image.asset(
                'assets/Field.png',
                fit: BoxFit.fitWidth,
              ),
              onTapDown: ((details) {
                final Offset offset = details.localPosition;
              print(width);
              print(height);
                print(offset);
              }),
            ),
          ),
//          Center(
//              child: Column(
//                children: <Widget>[
//                  Image.asset(
//                      'assets/EmptyPowerCell.png'
//                  ),
//                  Positioned(
//                    left: (69.0/411)*width,
//                    top: (350.0/683)*height,
//                    child: Container(
//                      width: (36.0/411)*width,
//                      height: (30.0/683)*height,
//                    ),
//                  ),
//                ],
//              ),
////              Positioned(
////                left: (69.0/411)*width,
////                top: (315.0/683)*height,
////                child: Container(
////                  width: (36.0/411)*width,
////                  height: (30.0/683)*height,
////                  child: Image.asset(
////                      'assets/EmptyPowerCell.png'
////                  ),
////                ),
////              ),
//          ),
        ],
      ),
    );
  }
}
