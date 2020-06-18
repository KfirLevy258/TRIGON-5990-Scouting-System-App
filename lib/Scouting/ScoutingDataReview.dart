import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pit_scout/Field/AutoPowerCellsCollect.dart';
import 'package:pit_scout/Model/GameData.dart';
import 'package:pit_scout/Widgets/alert.dart';
import 'package:pit_scout/Widgets/booleanInput.dart';
import 'package:pit_scout/Widgets/pageSection.dart';
import 'package:pit_scout/Widgets/plusminus.dart';
import 'package:pit_scout/Widgets/selectionInput.dart';
import 'package:pit_scout/addToScouterScore.dart';
import 'package:provider/provider.dart';
import 'package:pit_scout/Model/GameDataModel.dart';

class ScoutingDataReview extends StatefulWidget{
  final GameData gameData;

  ScoutingDataReview({Key key, this.gameData}) : super(key:key);

  @override
  ScoutingDataReviewState createState() => ScoutingDataReviewState();
}

class ScoutingDataReviewState extends State<ScoutingDataReview>{

  GameData localGameData = new GameData();
  bool isLocalChange = false;
  double width;
  String _winningAlliance = 'Not selected';
  bool climbRP = false;
  bool ballsRP = false;
  bool ifClimbLocationIs301 = false;

  @override
  void initState()  {
    setOrientation();
    localGameData.copy(widget.gameData);
    super.initState();
  }

  setOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    this.width  = width;
    if (!isLocalChange) {
      localGameData.copy(widget.gameData);
    }
    isLocalChange = false;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Data Review: " + widget.gameData.teamNumber + ' - ' + widget.gameData.teamName,
            textAlign: TextAlign.center,
          ),
        ),
        body: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  preGameData(),
                  autoGameData(),
                  teleopGameData(),
                  endGameData(),
                  winningAlliance(),
                  Padding(padding: EdgeInsets.all(15),),
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (_winningAlliance=='Not selected'){
                        alert(
                          context,
                          "Error",
                          "You must put in a winning alliance",);
                      } else {
                        print(this.ballsRP);
                        if (_winningAlliance=='blue'){
                          Provider.of<GameDataModel>(context, listen: false).setWinningAlliance('blue', this.climbRP, this.ballsRP);
                          localGameData.winningAlliance='blue';
                          localGameData.ballsRP = this.ballsRP;
                          localGameData.climbRP = this.climbRP;
                        } else {
                          Provider.of<GameDataModel>(context, listen: false).setWinningAlliance('red', this.climbRP, this.ballsRP);
                          localGameData.winningAlliance='red';
                          localGameData.ballsRP = this.ballsRP;
                          localGameData.climbRP = this.climbRP;
                        }
                        print(localGameData.climb5BallCollected);
                        Provider.of<GameDataModel>(context, listen: false).saveGameData(localGameData);
                        int sumToAd = 10;
                        if (_winningAlliance==this.localGameData.winningAlliance){
                          sumToAd = sumToAd + 15;
                        }
                        addToScouterScore(sumToAd, localGameData.userId);
//                        Provider.of<GameDataModel>(context, listen: false).resetGameData();
//                        Navigator.pop(context);
//                        Navigator.pop(context);
//                        Navigator.pop(context);
//                        Navigator.pop(context);
//                        Navigator.pop(context);
//                        Navigator.pop(context);
                      }
                    },
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(15),),
                ],
              ),
            )
          ],
        )
    );
  }

  Widget preGameData(){
    return pageSectionWidget('Pre game',
      [
        selectionInputWidget('Starting positon', this.localGameData.startingPosition, ["Left", "Center", "Right"],
            ((val) {
              setState(() {
                this.localGameData.startingPosition = val;
                isLocalChange = true;
              });
            }),
        )
      ]
    );
  }

  Widget winningAlliance(){
    return pageSectionWidget('Winners',
        [
          booleanInputWidget("Climb RP", this.climbRP, ((val) {
            setState(() {
              this.climbRP
              = val;
            });
          })),
          booleanInputWidget("Power Cells RP", this.ballsRP, ((val) {
            setState(() {
              this.ballsRP = val;
            });
          })),
          selectionInputWidget('Winners', _winningAlliance,
              ["blue", "red", "tie"], (val) { setState(() => _winningAlliance = val); isLocalChange=true;}),
        ]
    );
  }

  Widget autoGameData(){
    return pageSectionWidget('Auto game',
        [
          plusMinus(this.localGameData.autoInnerScore, 'Inner', ((value) {
            setState(() {
              print(value);
              this.localGameData.autoInnerScore = value;
            }); isLocalChange=true;
          })),
          plusMinus(this.localGameData.autoOuterScore, 'Outer', ((value) {
            setState(() {
              print(value);
              this.localGameData.autoOuterScore = value;
            }); isLocalChange=true;
          })),
          plusMinus(this.localGameData.autoBottomScore, 'Bottom', ((value) {
            setState(() {
              print(value);
              this.localGameData.autoBottomScore = value;
            }); isLocalChange=true;
          })),
          Container(
            width: width-40,
            height: 60,
            child: FlatButton(
              color: Colors.blue,
              onPressed: () {
                print(this.localGameData.trenchSteal2BallCollected);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AutoPowerCellsCollect(bool12callback: ((climb1, climb2, climb3, climb4, climb5,
                      trench1, trench2, trench3, trench4, trench5, steal1, steal2) {
                    setState(() {
                      this.localGameData.climb1BallCollected = climb1;
                      this.localGameData.climb2BallCollected = climb2;
                      this.localGameData.climb3BallCollected = climb3;
                      this.localGameData.climb4BallCollected = climb4;
                      this.localGameData.climb5BallCollected = climb5;
                      this.localGameData.trench1BallCollected = trench1;
                      this.localGameData.trench2BallCollected = trench2;
                      this.localGameData.trench3BallCollected = trench3;
                      this.localGameData.trench4BallCollected = trench4;
                      this.localGameData.trench5BallCollected = trench5;
                      this.localGameData.trenchSteal2BallCollected = steal1;
                      this.localGameData.trenchSteal2BallCollected = steal2;
                    });
                    isLocalChange=true;
                  }),
                    climb1BallCollected: this.localGameData.climb1BallCollected,
                    climb2BallCollected: this.localGameData.climb2BallCollected,
                    climb3BallCollected: this.localGameData.climb3BallCollected,
                    climb4BallCollected: this.localGameData.climb4BallCollected,
                    climb5BallCollected: this.localGameData.climb5BallCollected,
                    trench1BallCollected: this.localGameData.trench1BallCollected,
                    trench2BallCollected: this.localGameData.trench2BallCollected,
                    trench3BallCollected: this.localGameData.trench3BallCollected,
                    trench4BallCollected: this.localGameData.trench4BallCollected,
                    trench5BallCollected: this.localGameData.trench5BallCollected,
                    trenchSteal1BallCollected: this.localGameData.trenchSteal1BallCollected,
                     trenchSteal2BallCollected: this.localGameData.trenchSteal2BallCollected,
                  )),
                ).then((_) {
                  setOrientation();
                });
              },
              child: Text(
                'Auto collect',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
          ),
        ]
    );
  }

  Widget teleopGameData(){
    return pageSectionWidget('Teleop game',
        [
          plusMinus(this.localGameData.teleopInnerScore, 'Inner', ((value) {
            setState(() {
              print(value);
              this.localGameData.teleopInnerScore = value;
            }); isLocalChange=true;
          })),
          plusMinus(this.localGameData.teleopOuterScore, 'Outer', ((value) {
            setState(() {
              print(value);
              this.localGameData.teleopOuterScore = value;
            }); isLocalChange=true;
          })),
          plusMinus(this.localGameData.teleopBottomScore, 'Bottom', ((value) {
            setState(() {
              print(value);
              this.localGameData.teleopBottomScore = value;
            }); isLocalChange=true;
          })),
          booleanInputWidget('Spin control panel', this.localGameData.trenchRotate, (val)  {setState(() => this.localGameData.trenchRotate = val); isLocalChange = true;}),
          booleanInputWidget('Stop control panel', this.localGameData.trenchStop, (val)  {setState(() => this.localGameData.trenchStop = val); isLocalChange = true;}),
        ]
    );
  }

  Widget endGameData(){
    return pageSectionWidget('End game',
        [
          selectionInputWidget('Climb status', this.localGameData.climbStatus,
              ["Climbed successfully", "Tried", "Parked", "Dident tried"], (val) { setState(() => this.localGameData.climbStatus = val); isLocalChange = true;}),
          this.localGameData.climbStatus == 'Climbed successfully'
            ? plusMinus(this.localGameData.climbLocation, 'Climb location', ((val) { setState(() => this.localGameData.climbLocation = (val)); isLocalChange = true;}))
            : this.localGameData.climbStatus == 'Tried'
              ? selectionInputWidget('Why didnt climb?', this.localGameData.whyDidntClimb,  ["Fell", "Mechanical failure", "Time is upן" ,"Other"], ((val) { setState(() {
                this.localGameData.whyDidntClimb = val;
                isLocalChange = true;
              });}))
              : Container(),
        ]
    );
  }

}