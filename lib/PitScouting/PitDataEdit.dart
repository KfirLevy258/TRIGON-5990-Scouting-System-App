import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pit_scout/Image.dart';
import 'package:pit_scout/Widgets/alert.dart';
import 'package:pit_scout/Widgets/selectionInput.dart';
import 'package:pit_scout/Widgets/textHeader.dart';
import 'package:pit_scout/Widgets/numericInput.dart';
import 'package:pit_scout/Widgets/numericRatioInput.dart';
import 'package:pit_scout/Widgets/pageSection.dart';
import 'package:pit_scout/Widgets/booleanInput.dart';
import 'package:provider/provider.dart';
import 'package:pit_scout/Model/PitDataModel.dart';
import 'package:pit_scout/Model/PitData.dart';

import '../addToScouterScore.dart';

class PitDataEdit extends StatefulWidget {
  final String teamName;
  final String teamNumber;
  final String tournament;
  final bool saved;
  final PitData pitInitialData;
  final String userId;

  PitDataEdit({Key key, @required this.teamName, this.teamNumber, this.tournament, this.saved, this.pitInitialData, this.userId}) : super(key: key);

  @override
  _PitDataEditState createState() => _PitDataEditState();
}

typedef void StringCallback(String val);
typedef void BooleanCallback(bool val);
typedef void FileCallback(File file);

class _PitDataEditState extends State<PitDataEdit> {
  final _formKey = GlobalKey<FormState>();
  File imageFile;
  PitData localPitData = new PitData();


  bool isLocalChange = false;
  String _conversionRatioNominator = 'Numerator';
  String _conversionRatioDenominator = 'Denominator';

  TextEditingController _robotWeightController = new TextEditingController();
  TextEditingController _robotWidthController = new TextEditingController();
  TextEditingController _robotLengthController = new TextEditingController();
  TextEditingController _dtMotorsController = new TextEditingController();
  TextEditingController _conversionRatioCounterController = new TextEditingController();
  TextEditingController _conversionRatioDenominatorController = new TextEditingController();
  TextEditingController _robotMinClimbController = new TextEditingController();
  TextEditingController _robotMaxClimbController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!isLocalChange) {
      localPitData.copy(widget.pitInitialData);
      List<String> temp = localPitData.conversionRatio.split('/');
      if (temp.length > 1) {
        _conversionRatioNominator = temp[0];
        _conversionRatioDenominator = temp[1];
      }
    }
    isLocalChange = false;
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.teamNumber + " - " + widget.teamName),
          ),
          body: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(8.0),),
              ImageStuff(tournament: widget.tournament, teamNumber: widget.teamNumber, fileCallback: (file) { setState(() => imageFile = file); isLocalChange = true;} ,),
              textHeader(widget.teamName + ' ' + widget.teamNumber),
              separatorLineWidget(),
              basicRobotQuestions(),
              separatorLineWidget(),
              chassisOverallStrength(),
              separatorLineWidget(),
              basicAbilityQuestions(),
              separatorLineWidget(),
              gameAbilityQuestions(),
              separatorLineWidget(),
              endGameQuestions(),
              separatorLineWidget(),
              Padding(padding: EdgeInsets.all(10.0),),
              RaisedButton(
                color: Colors.blue,
                padding: EdgeInsets.all(8.0),
                onPressed: () {
                  print(_formKey);
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate() && allSelectionIsFill()) {
                    if (imageFile != null){
                      saveImage();
                    }
                    addToScouterScore(5, widget.userId);
                    saveToFireBase();
                    Navigator.pop(context);
                  }
                  else {
                    formInputErrorDialog(context);
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 40.0, color: Colors.white),
                ),
              ),
              Padding(padding: EdgeInsets.all(8.0),),
            ],
          )
      ),
    );
  }

  saveImage() {
    StorageReference storageReference = FirebaseStorage.instance.ref().child('robots_pictures').child(widget.tournament).child(widget.teamNumber);
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    uploadTask.onComplete
    .then((res) {
      print('File Uploaded');
    });
  }

  bool allSelectionIsFill(){
    if (localPitData.dtMotorType!='Not selected' && localPitData.wheelDiameter!='Not selected' && localPitData.powerCellAmount!='Not selected' && localPitData.canScore!='Not selected'){
      if (localPitData.canClimb){
        if (localPitData.heightOfTheClimb!='Not selected') return true;
        else return false;
      }
      else {
        return true;
      }
    }
    return false;
  }

  Widget basicRobotQuestions() {
    return pageSectionWidget("Basic ability questions", [
      numericInputWidget("Robot weight", localPitData.robotWeightData, _robotWeightController, 0, 56, false, widget.saved),
      numericInputWidget("Robot width", localPitData.robotWidthData, _robotWidthController, 0, 120, false, widget.saved),
      numericInputWidget("Robot length", localPitData.robotLengthData, _robotLengthController, 0, 120, false, widget.saved),
      numericInputWidget("DT Motors", localPitData.dtMotorsData, _dtMotorsController, 0, 10, true, widget.saved),
    ]);
  }

  Widget chassisOverallStrength() {
    return pageSectionWidget("Chassis questions",[
      selectionInputWidget('Wheel diameter', localPitData.wheelDiameter, ["3 Inch", "4 Inch", "5 Inch", "6 Inch", "7 Inch",  "8 Inch"],
              (val) { setState(() => localPitData.wheelDiameter = val); isLocalChange = true;}),
      numericRatioInputWidget("Conversion Ratio", _conversionRatioNominator, _conversionRatioDenominator, _conversionRatioCounterController, _conversionRatioDenominatorController, 0, 100000, false, widget.saved),
      selectionInputWidget('DT Motors types', localPitData.dtMotorType, ["Mini CIMs", "CIMs", "NEOs", "Falcons", "775", "Red-line " ,"Other"], (val) { setState(() => localPitData.dtMotorType = val); isLocalChange = true;}),
    ]);
  }

  Widget basicAbilityQuestions() {
    return pageSectionWidget("Pre game questions", [
      selectionInputWidget('Power Cells in the beginning of game',localPitData.powerCellAmount,
          ["Zero Power Cell", "One Power Cell", "Two Power Cell", "Three Power Cell"], (val) { setState(() => localPitData.powerCellAmount = val); isLocalChange = true;}),
      booleanInputWidget('Can start from any position', localPitData.canStartFromAnyPosition, (val)  {setState(() => localPitData.canStartFromAnyPosition = val); isLocalChange = true;}),
    ]);
  }

  Widget gameAbilityQuestions() {
    return pageSectionWidget("Game questions", [
      selectionInputWidget('Powe Cells option', localPitData.canScore, ["No option", "Bottom port", "Upper port"], (val) { setState(() => localPitData.canScore = val); isLocalChange = true;}),
      booleanInputWidget('Can spin the control panel', localPitData.canRotateTheRoulette, (val) { setState(() => localPitData.canRotateTheRoulette = val); isLocalChange = true;}),
      booleanInputWidget('Can stop the control panel', localPitData.canStopTheRoulette, (val) { setState(() => localPitData.canStopTheRoulette = val); isLocalChange = true;}),
    ]);
  }

  Widget endGameQuestions() {
    return pageSectionWidget("End Game questions",
        localPitData.canClimb==false ?
        [
          booleanInputWidget('Can climb', localPitData.canClimb, (val) { setState(() => localPitData.canClimb = val); isLocalChange = true;}),
        ] :
        [
          booleanInputWidget('Can climb', localPitData.canClimb, (val) => setState(() => localPitData.canClimb = val)),
          selectionInputWidget('Climb height', localPitData.heightOfTheClimb, ["Min (1.2 meter)", "Middle (1.6 meter)", "Max (2 meter)"], (val) { setState(() => localPitData.heightOfTheClimb = val); isLocalChange = true;}),
          numericInputWidget("Min Climb height", localPitData.robotMinClimb, _robotMinClimbController, 110,  210, false, widget.saved),
          numericInputWidget("Max Climb height", localPitData.robotMaxClimb, _robotMaxClimbController, 110,  210, false, widget.saved),
        ]
    );
  }

  saveToFireBase() {
    print(_robotWeightController.text);
    if(_robotWeightController.text !='' ) localPitData.robotWeightData = _robotWeightController.text;
    if(_robotWidthController.text !=''  ) localPitData.robotWidthData = _robotWidthController.text;
    if(_robotLengthController.text !='' ) localPitData.robotLengthData = _robotLengthController.text;
    if(_dtMotorsController.text !='' ) localPitData.dtMotorsData = _dtMotorsController.text;

    if (localPitData.canClimb == true) {
      if (_robotMinClimbController.text !='') localPitData.robotMinClimb = _robotMinClimbController.text;
      if(_robotMaxClimbController.text !='' ) localPitData.robotMaxClimb = _robotMaxClimbController.text;

    } else {
      localPitData.heightOfTheClimb = null;
      localPitData.robotMinClimb = null;
      localPitData.robotMaxClimb = null;
    }

    localPitData.conversionRatio = conversionRatio(_conversionRatioCounterController, _conversionRatioDenominatorController);

    Provider.of<PitDataModel>(context, listen: false).savePitData(localPitData, widget.tournament, widget.teamNumber);

  }

  String conversionRatio(TextEditingController nominatorController, TextEditingController deNominatorController) {
    String nominator;
    String denominator;
    if (nominatorController.text=='')
      nominator = _conversionRatioNominator;
    else
      nominator = nominatorController.text;
    if (deNominatorController.text=='')
      denominator = _conversionRatioDenominator;
    else
      denominator = deNominatorController.text;
    return (nominator + '/' + denominator);
  }

  Widget separatorLineWidget(){
    return Container(
      height: 2, width: 0.5, color: Colors.grey,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
      child: Padding(padding: EdgeInsets.all(10.0),),
    );
  }

  Future<void> formInputErrorDialog(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(
              'שגיאה',
              style: TextStyle(fontSize: 25.0, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            content: const Text(
              'לא מילאת חלק משדות החובה. תוודא שמילאת את כל השאלות הפתוחות ואת כל שאלות הבחירה',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

}