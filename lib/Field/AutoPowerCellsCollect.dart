import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AutoPowerCellsCollect extends StatefulWidget {
  @override
  _AutoPowerCellsCollectState createState() => _AutoPowerCellsCollectState();
}

typedef void BoolCallback(bool res);

class _AutoPowerCellsCollectState extends State<AutoPowerCellsCollect> {

  setOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  bool climb1BallCollected = false;
  bool climb2Ball1Collected = false;
  bool climb3Ball1Collected = false;
  bool climb4Ball1Collected = false;
  bool climb5Ball1Collected = false;

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

                    Container(
                      width: width-20,
                      child: GestureDetector(
                        child: Image.asset(
                          'assets/ClimbCollect.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10),),
                    Container(
                      width: width-20,
                      child: GestureDetector(
                        child: Image.asset(
                          'assets/TrenchCollect.png',
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
              powerCellPosition((73/391), yPosition(imageHeight(width-20), 135.0, 227.0), width, climb1BallCollected, (val) => setState(() => climb1BallCollected = val)),
              powerCellPosition((53/391), yPosition(imageHeight(width-20), 160.0, imageHeight(391)), width, climb2Ball1Collected, (val) => setState(() => climb2Ball1Collected = val)),
              powerCellPosition((99/391), yPosition(imageHeight(width-20), 179.0, imageHeight(391)), width, climb3Ball1Collected, (val) => setState(() => climb3Ball1Collected = val)),
              powerCellPosition((140/391), yPosition(imageHeight(width-20), 186.0, imageHeight(391)), width, climb4Ball1Collected, (val) => setState(() => climb4Ball1Collected = val)),
              powerCellPosition((182/391), yPosition(imageHeight(width-20), 192.0, imageHeight(391)), width, climb5Ball1Collected, (val) => setState(() => climb5Ball1Collected = val)),
            ],
          ),
        ],
      ),
    );
  }

  Widget powerCellPosition(double x, double y, double width, bool isCollected, BoolCallback callback){
    final double dx = x * 2 - 1;
    final double dy = y * 2 - 1;
    print(y);
    print(dy);
    return Container(
      height: imageHeight(width-20),
      width: width-20,
      child: Align(
        alignment: Alignment(dx, dy),
        child: Container(
          width: width/15,
          child: GestureDetector(
              child: isCollected
                  ? Image.asset(
                'assets/PowerCell.png',
              )
                  : Image.asset(
                'assets/EmptyPowerCell.png',
              ),
              onTapDown: ((_) {
                callback(!isCollected);
              })
          ),
        ),
      ),
    );
  }

}

double imageHeight(double width) {
  double ratio = 1134.0/width;
  double imageHeight = 660.0/ratio;
  return imageHeight;
}

double yPosition(double newImageHeight, double originalY, originalImageHeight){
  double newY = (originalY/originalImageHeight);
  return newY;
}

