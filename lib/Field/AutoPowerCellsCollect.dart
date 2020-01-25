import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pit_scout/Model/GameDataModel.dart';
import 'package:pit_scout/Widgets/alert.dart';
import 'package:provider/provider.dart';

import '../addToScouterScore.dart';

typedef void BoolCallback(bool res);
typedef void Bool10Callback(bool climb1, bool climb2, bool climb3, bool climb4, bool climb5,
    bool trench1, bool trench2, bool trench3, bool trench4, bool trench5);


class AutoPowerCellsCollect extends StatefulWidget {
  Bool10Callback bool10callback;
  bool climb1BallCollected;
  bool climb2BallCollected;
  bool climb3BallCollected;
  bool climb4BallCollected;
  bool climb5BallCollected;
  bool trench1BallCollected;
  bool trench2BallCollected;
  bool trench3BallCollected;
  bool trench4BallCollected;
  bool trench5BallCollected;

  AutoPowerCellsCollect({Key key, this.bool10callback,
    this.climb1BallCollected, this.climb2BallCollected, this.climb3BallCollected, this.climb4BallCollected,
    this.climb5BallCollected, this.trench1BallCollected, this.trench2BallCollected, this.trench3BallCollected,
    this.trench4BallCollected, this.trench5BallCollected}) : super(key: key);

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
                          if (offset.dx > (118.0/411.0)*width && offset.dx<(137.0/411.0)*width && offset.dy>(46.0/411.0)*width && offset.dy < (64.0/411)*width){
                            addToScouterScore(15, Provider.of<GameDataModel>(context, listen: false).getUserId());
                            alert(
                                context,
                                'מצאת איסטר אג! #3',
                                'על איסטר אג זה קיבלת 15 נקודות! תזכור לא לספר לחברים שלך בכדי להיות במקום הראשון'
                            );
                          }
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
                      powerCellPosition((85/391), yPosition(imageHeight(width-20, 1134, 660), 135.0, 227.0), width, imageHeight(width-20, 1134, 660), widget.climb1BallCollected, (val) => setState(() => widget.climb1BallCollected = val)),
                      powerCellPosition((65/391), yPosition(imageHeight(width-20, 1134, 660), 160.0, 227.0), width, imageHeight(width-20, 1134, 660), widget.climb2BallCollected, (val) => setState(() => widget.climb2BallCollected = val)),
                      powerCellPosition((99/391), yPosition(imageHeight(width-20, 1134, 660), 179.0, 227.0), width, imageHeight(width-20, 1134, 660), widget.climb3BallCollected, (val) => setState(() => widget.climb3BallCollected = val)),
                      powerCellPosition((140/391), yPosition(imageHeight(width-20, 1134, 660), 186.0, 227.0), width, imageHeight(width-20, 1134, 660), widget.climb4BallCollected, (val) => setState(() => widget.climb4BallCollected = val)),
                      powerCellPosition((185/391), yPosition(imageHeight(width-20, 1134, 660), 192.0, 227.0), width, imageHeight(width-20, 1134, 660), widget.climb5BallCollected, (val) => setState(() => widget.climb5BallCollected = val)),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  Stack(
                    children: <Widget>[
                      powerCellPosition((290/391), yPosition(imageHeight(width-20, 1020, 712), 85.0, 227.0), width, imageHeight(width-20, 1020, 712), widget.trench1BallCollected, (val) => setState(() => widget.trench1BallCollected = val)),
                      powerCellPosition((250/391), yPosition(imageHeight(width-20, 1020, 712), 120.0, 227.0), width, imageHeight(width-20, 1020, 712), widget.trench2BallCollected, (val) => setState(() => widget.trench2BallCollected = val)),
                      powerCellPosition((210/391), yPosition(imageHeight(width-20, 1020, 712), 150.0, 227.0), width, imageHeight(width-20, 1020, 712), widget.trench3BallCollected, (val) => setState(() => widget.trench3BallCollected = val)),
                      powerCellPosition((120/391), yPosition(imageHeight(width-20, 1020, 712), 200.0, 227.0), width, imageHeight(width-20, 1020, 712), widget.trench4BallCollected, (val) => setState(() => widget.trench4BallCollected = val)),
                      powerCellPosition((150/391), yPosition(imageHeight(width-20, 1020, 712), 212.0, 227.0), width, imageHeight(width-20, 1020, 712), widget.trench5BallCollected, (val) => setState(() => widget.trench5BallCollected = val)),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  Container(
                    width: 200,
                    child: FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        widget.bool10callback(widget.climb1BallCollected, widget.climb2BallCollected, widget.climb3BallCollected,
                            widget.climb4BallCollected, widget.climb5BallCollected,
                            widget.trench1BallCollected, widget.trench2BallCollected, widget.trench3BallCollected, widget.trench4BallCollected, widget.trench5BallCollected);
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

