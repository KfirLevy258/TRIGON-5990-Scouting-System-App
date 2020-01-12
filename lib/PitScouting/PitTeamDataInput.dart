import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class TeamDataPage extends StatefulWidget {
  final String teamName;
  final String teamNumber;
  final String tournament;
  final bool saved;

  TeamDataPage({Key key, @required this.teamName, this.teamNumber, this.tournament, this.saved}) : super(key: key);

  @override
  _TeamDataPageState createState() => _TeamDataPageState(teamName, tournament, teamNumber, saved);
}

typedef void StringCallback(String val);
typedef void BooleanCallback(bool val);
typedef void FileCallback(File file);

class _TeamDataPageState extends State<TeamDataPage> {
  final _formKey = GlobalKey<FormState>();
  File imageFile;

  TextEditingController _robotWeightController = new TextEditingController();
  TextEditingController _robotWidthController = new TextEditingController();
  TextEditingController _robotLengthController = new TextEditingController();
  TextEditingController _dtMotorsController = new TextEditingController();
  TextEditingController _conversionRatioCounter = new TextEditingController();
  TextEditingController _conversionRatioDenominator = new TextEditingController();
  TextEditingController _robotMinClimbController = new TextEditingController();
  TextEditingController _robotMaxClimbController = new TextEditingController();

  String _dtMotorType = 'לא נבחר';
  String _wheelDiameter = 'לא נבחר';
  String _powerCellAmount = 'לא נבחר';
  String _canScore = 'לא נבחר';
  String _heightOfTheClimb= 'לא נבחר';

  bool _canStartFromAnyPosition = false;
  bool _canRotateTheRoulette = false;
  bool _canStopTheRoulette = false;
  bool _canClimb = false;

  String _robotWeightData = "קילוגרמים";
  String _robotWidthData = "סנטימטרים";
  String _robotLengthData = "סנטימטרים";
  String _dtMotorsData = "כמות";
  String _conversionRatioDataCounter = "מונה";
  String _conversionRatioDataDenominator = "מכנה";
  String _robotMinClimb = "סנטימטרים";
  String _robotMaxClimb = "סנטימטרים";

  bool saved;
  String teamName;
  String districtName;
  String teamNumber;

  _TeamDataPageState(String name, String districtName, String teamNumber, bool saved){
    this.teamName = name;
    this.districtName = districtName;
    this.teamNumber = teamNumber;
    this.saved = saved;
    if (saved){
      Firestore.instance.collection('tournaments').document(this.districtName).collection('teams').document(this.teamNumber).get().then((val){
        if (val.documentID.length > 0) {
          setState(() {
            _powerCellAmount = val.data['Pit_scouting']['Basic ability']['Power cells when start the game'];
            _canStartFromAnyPosition = val.data['Pit_scouting']['Basic ability']['Can start from any position'];
            _canScore = val.data['Pit_scouting']['Due game']['Can work with power cells'];
            _canRotateTheRoulette = val.data['Pit_scouting']['Due game']['Can rotate the roulette '];
            _canStopTheRoulette = val.data['Pit_scouting']['Due game']['Can stop the wheel'];
            _canClimb = val.data['Pit_scouting']['End game']['Can climb'];
            _heightOfTheClimb = val.data['Pit_scouting']['End game']['Climb hight'];
            _robotMaxClimb = val.data['Pit_scouting']['End game']['Max hight climb'].toString();
            _robotMinClimb = val.data['Pit_scouting']['End game']['Min hight climb'].toString();
            _dtMotorType = val.data['Pit_scouting']['Chassis Overall Strength']['DT Motor type'];
            _wheelDiameter = val.data['Pit_scouting']['Chassis Overall Strength']['Wheel Diameter'];
            String conversionRatioData = val.data['Pit_scouting']['Chassis Overall Strength']['Conversion Ratio'];
            List<String> temp = conversionRatioData.split('/');
            _conversionRatioDataCounter = temp[0];
            _conversionRatioDataDenominator = temp[1];
            _robotLengthData = val.data['Pit_scouting']['Robot basic data']['Robot Length'].toString();
            _robotWeightData = val.data['Pit_scouting']['Robot basic data']['Robot Weight'].toString();
            _robotWidthData = val.data['Pit_scouting']['Robot basic data']['Robot Width'].toString();
            _dtMotorsData = val.data['Pit_scouting']['Robot basic data']['DT Motors'].toString();
          });
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: Text(this.teamNumber + " - " + this.teamName),
          ),
          body: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(8.0),),
              ImageStuff(tournament: widget.tournament, teamNumber: widget.teamNumber, fileCallback: (file) => setState(() => imageFile = file) ,),
              textHeader(teamName + ' ' + teamNumber),
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
              RaisedButton(
                color: Colors.blue,
                padding: EdgeInsets.all(8.0),
                onPressed: () {
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate() && allSelectionIsFill()) {
                    if (imageFile != null)
                      saveImage();
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
    if (_dtMotorType!='לא נבחר' && _wheelDiameter!='לא נבחר' && _powerCellAmount!='לא נבחר' && _canScore!='לא נבחר'){
      if (_canClimb){
        if (_heightOfTheClimb!='לא נבחר') return true;
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
      numericInputWidget("משקל הרובוט", _robotWeightData, _robotWeightController, 0, 56, false, saved),
      numericInputWidget("רוחב הרובוט", _robotWidthData, _robotWidthController, 0, 20, false, saved),
      numericInputWidget("אורך הרובוט", _robotLengthData, _robotLengthController, 0, 30, false, saved),
      numericInputWidget("כמות המנועים בהנעה", _dtMotorsData, _dtMotorsController, 4, 8, true, saved),
    ]);
  }

  Widget chassisOverallStrength() {
    return pageSectionWidget("חישוב כוח מרכב",[
      selectionInputWidget('קוטר גלגל', _wheelDiameter, ["3 Inch", "4 Inch", "5 Inch", "6 Inch", "7 Inch",  "8 Inch"],
              (val) => setState(() => _wheelDiameter = val)),
      numericRatioInputWidget("יחס המרה", _conversionRatioDataCounter, _conversionRatioDataDenominator, _conversionRatioCounter, _conversionRatioDenominator, 1, 100000, false, saved),
      selectionInputWidget('סוגי מנועים', _dtMotorType, ["מיני סימים", "סימים", "נאו", "אחר"], (val) => setState(() => _dtMotorType = val)),
    ]);
  }

  Widget basicAbilityQuestions() {
    return pageSectionWidget("שאלות יכולת בסיסית", [
      selectionInputWidget('כמה כדורים מכיל בתחילת משחק',_powerCellAmount,
          ["לא מכיל כדורים", "כדור אחד", "שני כדורים", "שלושה כדורים"], (val) => setState(() => _powerCellAmount = val)),
      booleanInputWidget('יכול להתחיל מכל עמדה', _canStartFromAnyPosition, (val) => setState(() => _canStartFromAnyPosition = val)),
    ]);
  }

  Widget gameAbilityQuestions() {
    return pageSectionWidget("שאלות על המשחק", [
      selectionInputWidget('יכול להתעסק עם כדורים', _canScore, ["בכלל לא", "לנמוך", "לגבוה"], (val) => setState(() => _canScore = val)),
      booleanInputWidget('יכול לסובב את הגלגל', _canRotateTheRoulette, (val) => setState(() => _canRotateTheRoulette = val)),
      booleanInputWidget('יכול לעצור את הגלגל', _canStopTheRoulette, (val) => setState(() => _canStopTheRoulette = val)),
    ]);
  }

  Widget endGameQuestions() {
    return pageSectionWidget("שאלות על סוף המשחק",
        _canClimb==false ?
        [
          booleanInputWidget('יכול לטפס', _canClimb, (val) => setState(() => _canClimb = val)),
        ] :
        [
          booleanInputWidget('יכול לטפס', _canClimb, (val) => setState(() => _canClimb = val)),
          selectionInputWidget('גובה טיפוס', _heightOfTheClimb, ["לנמוך (1.2 מטר)", "בינוני (1.6 מטר)", "לגבוה (2 מטר)"], (val) => setState(() => _heightOfTheClimb = val)),
          numericInputWidget("גבוה טיפוס מינמלי", _robotMinClimb, _robotMinClimbController, 110,  210, false, saved),
          numericInputWidget("גבוה טיפוס מקסימלי", _robotMaxClimb, _robotMaxClimbController, 110,  210, false, saved),
        ]
    );
  }

  saveToFireBase() {
    Firestore.instance.collection("tournaments").document(districtName)
        .collection('teams').document(teamNumber.toString()).updateData({
      'pit_scouting_saved': true,
      'Pit_scouting' :{
        'Chassis Overall Strength': {
          'Conversion Ratio': conversionRatio(_conversionRatioCounter, _conversionRatioDenominator),
          'DT Motor type': _dtMotorType,
          'Wheel Diameter': _wheelDiameter
        },
        'Robot basic data': {
          'Robot Weight': _robotWeightController.text=='' ? double.parse(_robotWeightData) : double.parse(_robotWeightController.text),
          'Robot Width': _robotWidthController.text=='' ? double.parse(_robotWidthData) : double.parse(_robotWidthController.text),
          'Robot Length': _robotLengthController.text=='' ? double.parse(_robotLengthData) : double.parse(_robotLengthController.text),
          'DT Motors': _dtMotorsController.text=='' ? int.parse(_dtMotorsData) : int.parse(_dtMotorsController.text),
        },
        'Basic ability': {
          'Power cells when start the game': _powerCellAmount,
          'Can start from any position': _canStartFromAnyPosition,
        },
        'Due game': {
          'Can work with power cells': _canScore,
          'Can rotate the roulette ': _canRotateTheRoulette,
          'Can stop the wheel': _canStopTheRoulette,
        },
        'End game': {
          'Can climb': _canClimb,
          'Climb hight': _canClimb==true ? _heightOfTheClimb : null,
          'Min hight climb': _canClimb==true
              ? _robotMinClimbController.text=='' ? double.parse(_robotMinClimb): double.parse(_robotMinClimbController.text)
              : null,
          'Max hight climb': _canClimb==true
              ? _robotMaxClimbController.text=='' ? double.parse(_robotMaxClimb): double.parse(_robotMaxClimbController.text)
              : null,
        }
      },
    });
  }

  String conversionRatio(TextEditingController countController, TextEditingController denominatorController) {
    String count;
    String denominator;
    if (countController.text=='')
      count = _conversionRatioDataCounter;
    else
      count = countController.text;
    if (denominatorController.text=='')
      denominator = _conversionRatioDataDenominator;
    else
      denominator = denominatorController.text;
    return (count + '/' + denominator);
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
              'Input Error',
              style: TextStyle(fontSize: 25.0, color: Colors.blue),
            ),
            content: const Text(
              'You must fill all required fields with correct values.',
              style: TextStyle(fontSize: 20.0),
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