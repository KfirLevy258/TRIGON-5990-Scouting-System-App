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
  bool climb2BallCollected = false;
  bool climb3BallCollected = false;
  bool climb4BallCollected = false;
  bool climb5BallCollected = false;
  bool trench1BallCollected = false;
  bool trench2BallCollected = false;
  bool trench3BallCollected = false;
  bool trench4BallCollected = false;
  bool trench5BallCollected = false;

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
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      powerCellPosition((85/391), yPosition(imageHeight(width-20, 1134, 660), 135.0, 227.0), width, imageHeight(width-20, 1134, 660), climb1BallCollected, (val) => setState(() => climb1BallCollected = val)),
                      powerCellPosition((65/391), yPosition(imageHeight(width-20, 1134, 660), 160.0, 227.0), width, imageHeight(width-20, 1134, 660), climb2BallCollected, (val) => setState(() => climb2BallCollected = val)),
                      powerCellPosition((99/391), yPosition(imageHeight(width-20, 1134, 660), 179.0, 227.0), width, imageHeight(width-20, 1134, 660), climb3BallCollected, (val) => setState(() => climb3BallCollected = val)),
                      powerCellPosition((140/391), yPosition(imageHeight(width-20, 1134, 660), 186.0, 227.0), width, imageHeight(width-20, 1134, 660), climb4BallCollected, (val) => setState(() => climb4BallCollected = val)),
                      powerCellPosition((185/391), yPosition(imageHeight(width-20, 1134, 660), 192.0, 227.0), width, imageHeight(width-20, 1134, 660), climb5BallCollected, (val) => setState(() => climb5BallCollected = val)),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  Stack(
                    children: <Widget>[
                      powerCellPosition((290/391), yPosition(imageHeight(width-20, 1020, 712), 85.0, 227.0), width, imageHeight(width-20, 1020, 712), trench1BallCollected, (val) => setState(() => trench1BallCollected = val)),
                      powerCellPosition((250/391), yPosition(imageHeight(width-20, 1020, 712), 120.0, 227.0), width, imageHeight(width-20, 1020, 712), trench2BallCollected, (val) => setState(() => trench2BallCollected = val)),
                      powerCellPosition((210/391), yPosition(imageHeight(width-20, 1020, 712), 150.0, 227.0), width, imageHeight(width-20, 1020, 712), trench3BallCollected, (val) => setState(() => trench3BallCollected = val)),
                      powerCellPosition((120/391), yPosition(imageHeight(width-20, 1020, 712), 200.0, 227.0), width, imageHeight(width-20, 1020, 712), trench4BallCollected, (val) => setState(() => trench4BallCollected = val)),
                      powerCellPosition((150/391), yPosition(imageHeight(width-20, 1020, 712), 212.0, 227.0), width, imageHeight(width-20, 1020, 712), trench5BallCollected, (val) => setState(() => trench5BallCollected = val)),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  Container(
                    width: 200,
                    child: FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'סיים',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget powerCellPosition(double x, double y, double width, double height, bool isCollected, BoolCallback callback){
    final double dx = x * 2 - 1;
    final double dy = y * 2 - 1;
    return Container(
      height: height,
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

double imageHeight(double width, double originalWidth, double originalHeight) {
  double ratio = originalWidth/width;
  double imageHeight = originalHeight/ratio;
  return imageHeight;
}

double yPosition(double newImageHeight, double originalY, originalImageHeight){
  double newY = (originalY/originalImageHeight);
  return newY;
}

