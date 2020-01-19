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
    print('width ' + width.toString());
    print('height '+ height.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'בחירת מיקום איסוף כדורים',
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Image.asset(
                        'assets/ClimbCollect.png',
                        fit: BoxFit.fitWidth,
                      ),
                      onTapDown: ((details) {
                        final Offset offset = details.localPosition;
                        print(offset);
                      }),
                    ),
                  ],
                ),
              ),
//          powerCellPosition((85.7/411), (142/(660/2.759)), width),
              powerCellPosition((83/411), (yPosition(height, 140.0, 683.0))/imageHeight(width), width),

            ],
          ),
        ],
      ),
    );
  }
}

double imageHeight(double width) {
  double ratio = 1134.0/width;
  double imageHeight = 660.0/ratio;
  print("image height " + imageHeight.toString());
  return imageHeight;
}

double yPosition(double newHeight, double originalY, originalHeight){
  double appBarHeight = 57.0;
  double counter = (originalY-appBarHeight)*(newHeight-appBarHeight);
  print('counter ' + counter.toString());
  double denominator = originalHeight-appBarHeight;
  print('denominator ' + denominator.toString());
  double newY = (counter/denominator) + appBarHeight;
  print('new y ' + newY.toString());
  return newY;

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
