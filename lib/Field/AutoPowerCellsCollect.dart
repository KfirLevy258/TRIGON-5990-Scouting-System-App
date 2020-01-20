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

  bool climb1 = false;
  bool climb2 = false;
  bool climb3 = false;
  bool climb4 = false;
  bool climb5 = false;

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
              powerCellPosition((83/391), ((yPosition(imageHeight(width-20), 135.0, imageHeight(391)))/197), width, climb1, (val) => setState(() => climb1 = val)),
              powerCellPosition((63/391), ((yPosition(imageHeight(width-20), 160.0, imageHeight(391)))/197), width, climb2, (val) => setState(() => climb2 = val)),
              powerCellPosition((99/391), ((yPosition(imageHeight(width-20), 179.0, imageHeight(391)))/197), width, climb3, (val) => setState(() => climb3 = val)),
              powerCellPosition((140/391), ((yPosition(imageHeight(width-20), 186.0, imageHeight(391)))/197), width, climb4, (val) => setState(() => climb4 = val)),
              powerCellPosition((182/391), ((yPosition(imageHeight(width-20), 192.0, imageHeight(391)))/197), width, climb5, (val) => setState(() => climb5 = val)),
            ],
          ),
        ],
      ),
    );
  }

  Widget powerCellPosition(double x, double y, double width, bool isCollected, BoolCallback callback){
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
  double newY = (originalY/originalImageHeight)*newImageHeight;
  return newY;
}

