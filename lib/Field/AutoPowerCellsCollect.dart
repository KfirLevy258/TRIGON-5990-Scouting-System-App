import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pit_scout/Model/GameDataModel.dart';
import 'package:pit_scout/Widgets/alert.dart';
import 'package:provider/provider.dart';

import '../addToScouterScore.dart';

typedef void BoolCallback(bool res);
typedef void Bool12Callback(bool climb1, bool climb2, bool climb3, bool climb4, bool climb5,
    bool trench1, bool trench2, bool trench3, bool trench4, bool trench5, bool steal1, bool steal2);


class AutoPowerCellsCollect extends StatefulWidget {
  Bool12Callback bool12callback;
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
  bool trenchSteal1BallCollected;
  bool trenchSteal2BallCollected;

  AutoPowerCellsCollect({Key key, this.bool12callback,
    this.climb1BallCollected, this.climb2BallCollected, this.climb3BallCollected, this.climb4BallCollected,
    this.climb5BallCollected, this.trench1BallCollected, this.trench2BallCollected, this.trench3BallCollected,
    this.trench4BallCollected, this.trench5BallCollected, this.trenchSteal1BallCollected, this.trenchSteal2BallCollected}) : super(key: key);

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
          'Power Cells collect',
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
                          'assets/PowerCellsCollect.png',
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
                      powerCellPosition((150/391), yPosition(imageHeight(width-20, 416, 426), 12.0, 227.0), width, imageHeight(width-20, 416, 426), widget.trench1BallCollected, (val) => setState(() => widget.trench1BallCollected = val)),
                      powerCellPosition((200/391), yPosition(imageHeight(width-20, 416, 426), 12.0, 227.0), width, imageHeight(width-20, 416, 426), widget.trench2BallCollected, (val) => setState(() => widget.trench2BallCollected = val)),
                      powerCellPosition((250/391), yPosition(imageHeight(width-20, 416, 426), 12.0, 227.0), width, imageHeight(width-20, 416, 426), widget.trench3BallCollected, (val) => setState(() => widget.trench3BallCollected = val)),
                      powerCellPosition((350/391), yPosition(imageHeight(width-20, 416, 426), 20.0, 227.0), width, imageHeight(width-20, 416, 426), widget.trench5BallCollected, (val) => setState(() => widget.trench5BallCollected = val)),
                      powerCellPosition((350/391), yPosition(imageHeight(width-20, 416, 426), 0.0, 227.0), width, imageHeight(width-20, 416, 426), widget.trench4BallCollected, (val) => setState(() => widget.trench4BallCollected = val)),

                      powerCellPosition((175/391), yPosition(imageHeight(width-20, 416, 426), 72.0, 227.0), width, imageHeight(width-20, 416, 426), widget.climb1BallCollected, (val) => setState(() => widget.climb1BallCollected = val)),
                      powerCellPosition((145/391), yPosition(imageHeight(width-20, 416, 426), 80.0, 227.0), width, imageHeight(width-20, 416, 426), widget.climb2BallCollected, (val) => setState(() => widget.climb2BallCollected = val)),
                      powerCellPosition((135/391), yPosition(imageHeight(width-20, 416, 426), 100.0, 227.0), width, imageHeight(width-20, 416, 426), widget.climb3BallCollected, (val) => setState(() => widget.climb3BallCollected = val)),
                      powerCellPosition((145/391), yPosition(imageHeight(width-20, 416, 426), 120.0, 227.0), width, imageHeight(width-20, 416, 426), widget.climb4BallCollected, (val) => setState(() => widget.climb4BallCollected = val)),
                      powerCellPosition((160/391), yPosition(imageHeight(width-20, 416, 426), 140.0, 227.0), width, imageHeight(width-20, 416, 426), widget.climb5BallCollected, (val) => setState(() => widget.climb5BallCollected = val)),

                      powerCellPosition((155/391), yPosition(imageHeight(width-20, 416, 426), 205.0, 227.0), width, imageHeight(width-20, 416, 426), widget.trenchSteal1BallCollected, (val) => setState(() => widget.trenchSteal1BallCollected = val)),
                      powerCellPosition((155/391), yPosition(imageHeight(width-20, 416, 426), 225.0, 227.0), width, imageHeight(width-20, 416, 426), widget.trenchSteal2BallCollected, (val) => setState(() => widget.trenchSteal2BallCollected = val)),

                    ],
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  Container(
                    width: 200,
                    child: FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        widget.bool12callback(widget.climb1BallCollected, widget.climb2BallCollected, widget.climb3BallCollected,
                            widget.climb4BallCollected, widget.climb5BallCollected,
                            widget.trench1BallCollected, widget.trench2BallCollected, widget.trench3BallCollected, widget.trench4BallCollected, widget.trench5BallCollected,
                            widget.trenchSteal1BallCollected, widget.trenchSteal2BallCollected
                        );
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Save',
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

