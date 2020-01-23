import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pit_scout/Image.dart';
import 'package:pit_scout/Widgets/selectionInput.dart';
import 'package:pit_scout/Widgets/textHeader.dart';
import 'package:pit_scout/Widgets/numericInput.dart';
import 'package:pit_scout/Widgets/numericRatioInput.dart';
import 'package:pit_scout/Widgets/pageSection.dart';
import 'package:pit_scout/Widgets/booleanInput.dart';
import 'package:provider/provider.dart';
import 'package:pit_scout/Model/PitDataModel.dart';
import 'package:pit_scout/Model/PitData.dart';

class PitDataEdit extends StatefulWidget {
  final String teamName;
  final String teamNumber;
  final String tournament;
  final bool saved;
  final PitData pitInitialData;

  PitDataEdit({Key key, @required this.teamName, this.teamNumber, this.tournament, this.saved, this.pitInitialData}) : super(key: key);

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
  String _conversionRatioNominator = 'מונה';
  String _conversionRatioDenominator = 'מכנה';

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
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate() && allSelectionIsFill()) {
                    if (imageFile != null){
                      saveImage();
                    }
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
    if (localPitData.dtMotorType!='לא נבחר' && localPitData.wheelDiameter!='לא נבחר' && localPitData.powerCellAmount!='לא נבחר' && localPitData.canScore!='לא נבחר'){
      if (localPitData.canClimb){
        if (localPitData.heightOfTheClimb!='לא נבחר') return true;
        else return false;
      }
      else {
        return true;
      }
    }
    return false;
  }

  Widget basicRobotQuestions() {
    return pageSectionWidget("שאלות בסיסיות על הרובוט", [
      numericInputWidget("משקל הרובוט", localPitData.robotWeightData, _robotWeightController, 0, 56, false, widget.saved),
      numericInputWidget("רוחב הרובוט", localPitData.robotWidthData, _robotWidthController, 0, 120, false, widget.saved),
      numericInputWidget("אורך הרובוט", localPitData.robotLengthData, _robotLengthController, 0, 120, false, widget.saved),
      numericInputWidget("כמות המנועים בהנעה", localPitData.dtMotorsData, _dtMotorsController, 0, 10, true, widget.saved),
    ]);
  }

  Widget chassisOverallStrength() {
    return pageSectionWidget("חישוב כוח מרכב",[
      selectionInputWidget('קוטר גלגל', localPitData.wheelDiameter, ["3 Inch", "4 Inch", "5 Inch", "6 Inch", "7 Inch",  "8 Inch"],
              (val) { setState(() => localPitData.wheelDiameter = val); isLocalChange = true;}),
      numericRatioInputWidget("יחס המרה", _conversionRatioNominator, _conversionRatioDenominator, _conversionRatioCounterController, _conversionRatioDenominatorController, 1, 100000, false, widget.saved),
      selectionInputWidget('סוגי מנועים', localPitData.dtMotorType, ["מיני סימים", "סימים", "נאו", "פאלקונים", "775", "רד-לינים" ,"אחר"], (val) { setState(() => localPitData.dtMotorType = val); isLocalChange = true;}),
    ]);
  }

  Widget basicAbilityQuestions() {
    return pageSectionWidget("שאלות יכולת בסיסית", [
      selectionInputWidget('כמה כדורים מכיל בתחילת משחק',localPitData.powerCellAmount,
          ["לא מכיל כדורים", "כדור אחד", "שני כדורים", "שלושה כדורים"], (val) { setState(() => localPitData.powerCellAmount = val); isLocalChange = true;}),
      booleanInputWidget('יכול להתחיל מכל עמדה', localPitData.canStartFromAnyPosition, (val)  {setState(() => localPitData.canStartFromAnyPosition = val); isLocalChange = true;}),
    ]);
  }

  Widget gameAbilityQuestions() {
    return pageSectionWidget("שאלות על המשחק", [
      selectionInputWidget('יכול להתעסק עם כדורים', localPitData.canScore, ["בכלל לא", "לנמוך", "לגבוה"], (val) { setState(() => localPitData.canScore = val); isLocalChange = true;}),
      booleanInputWidget('יכול לסובב את הגלגל', localPitData.canRotateTheRoulette, (val) { setState(() => localPitData.canRotateTheRoulette = val); isLocalChange = true;}),
      booleanInputWidget('יכול לעצור את הגלגל', localPitData.canStopTheRoulette, (val) { setState(() => localPitData.canStopTheRoulette = val); isLocalChange = true;}),
    ]);
  }

  Widget endGameQuestions() {
    return pageSectionWidget("שאלות על סוף המשחק",
        localPitData.canClimb==false ?
        [
          booleanInputWidget('יכול לטפס', localPitData.canClimb, (val) { setState(() => localPitData.canClimb = val); isLocalChange = true;}),
        ] :
        [
          booleanInputWidget('יכול לטפס', localPitData.canClimb, (val) => setState(() => localPitData.canClimb = val)),
          selectionInputWidget('גובה טיפוס', localPitData.heightOfTheClimb, ["לנמוך (1.2 מטר)", "בינוני (1.6 מטר)", "לגבוה (2 מטר)"], (val) { setState(() => localPitData.heightOfTheClimb = val); isLocalChange = true;}),
          numericInputWidget("גבוה טיפוס מינמלי", localPitData.robotMinClimb, _robotMinClimbController, 110,  210, false, widget.saved),
          numericInputWidget("גבוה טיפוס מקסימלי", localPitData.robotMaxClimb, _robotMaxClimbController, 110,  210, false, widget.saved),
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