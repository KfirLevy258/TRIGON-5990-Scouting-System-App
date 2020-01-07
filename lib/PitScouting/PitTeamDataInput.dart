import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pit_scout/Image.dart';
import 'package:pit_scout/Widgets/selectionInput.dart';
import 'package:pit_scout/Widgets/textHeader.dart';
import 'package:pit_scout/Widgets/numericInput.dart';

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
              Padding(padding: EdgeInsets.all(8.0),),
              createLineWidget(),
              Padding(padding: EdgeInsets.all(15.0),),
              basicQuestionsAboutTheRobot(),
              Padding(padding: EdgeInsets.all(15.0),),
              createLineWidget(),
              Padding(padding: EdgeInsets.all(15.0),),
              chassisOverallStrength(),
              Padding(padding: EdgeInsets.all(15.0),),
              createLineWidget(),
              Padding(padding: EdgeInsets.all(15.0),),
              basicAbilityQuestions(),
              Padding(padding: EdgeInsets.all(15.0),),
              createLineWidget(),
              Padding(padding: EdgeInsets.all(15.0),),
              gameAbilityQuestions(),
              Padding(padding: EdgeInsets.all(15.0),),
              createLineWidget(),
              Padding(padding: EdgeInsets.all(15.0),),
              endGameQuestions(),
              Padding(padding: EdgeInsets.all(15.0),),
              createLineWidget(),
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
                    whyCantSendData(context);
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

  Widget basicQuestionsAboutTheRobot() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "שאלות בסיסיות על הרובוט",
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
          ),
          Padding(padding: EdgeInsets.all(15.0),),
          numericInputWidget("משקל הרובוט", _robotWeightData, _robotWeightController, 0, 56, false, saved),
          Padding(padding: EdgeInsets.all(4.0),),
          numericInputWidget("רוחב הרובוט", _robotWidthData, _robotWidthController, 0, 20, false, saved),
          Padding(padding: EdgeInsets.all(4.0),),
          numericInputWidget("אורך הרובוט", _robotLengthData, _robotLengthController, 0, 30, false, saved),
          Padding(padding: EdgeInsets.all(4.0),),
          numericInputWidget("כמות המנועים בהנעה", _dtMotorsData, _dtMotorsController, 4, 8, true, saved),
        ],
      ),
    );
  }

  Widget chassisOverallStrength() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "חישוב כוח מרכב",
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
          ),
          Padding(padding: EdgeInsets.all(8.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                child: selectionInputWidget(_wheelDiameter, ["3 Inch", "4 Inch", "5 Inch", "6 Inch", "7 Inch",  "8 Inch"], (val) => setState(() => _wheelDiameter = val)),
              ),
              Padding(padding: EdgeInsets.all(4.0),),
              Container(
                width: 150,
                child: Text(
                  'קוטר גלגל',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
//              selectionInputRowBuild(_wheelDiameter),
            ],
          ),
          Padding(padding: EdgeInsets.all(4.0),),
          ratioNumericInput("יחס המרה", _conversionRatioDataCounter, _conversionRatioDataDenominator, _conversionRatioCounter, _conversionRatioDenominator, 1, 100000, false),
          Padding(padding: EdgeInsets.all(4.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                child: selectionInputWidget(_dtMotorType, ["מיני סימים", "סימים", "נאו", "אחר"], (val) => setState(() => _dtMotorType = val)),
              ),
              Padding(padding: EdgeInsets.all(4.0),),
              Container(
                width: 150,
                child: Text(
                  'סוגי מנועים',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  Widget endGameQuestions() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "שאלות על סוף המשחק",
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
          ),
          Padding(padding: EdgeInsets.all(8.0),),
          booleanInput('יכול לטפס', _canClimb, (val) => setState(() => _canClimb = val)),
          _canClimb==true
            ? Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(4.0),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: selectionInputWidget(_heightOfTheClimb, ["לנמוך (1.2)", "בינוני (1.6)", "לגבוה (2)"], (val) => setState(() => _heightOfTheClimb = val)),
                    ),
                    Padding(padding: EdgeInsets.all(4.0),),
                    Container(
                      width: 150,
                      child: Text(
                        'גובה טיפוס',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(4.0),),
                numericInputWidget("גבוה טיפוס מינמלי", _robotMinClimb, _robotMinClimbController, 110,  210, false, saved),
                Padding(padding: EdgeInsets.all(4.0),),
                numericInputWidget("גבוה טיפוס מקסימלי", _robotMaxClimb, _robotMaxClimbController, 110,  210, false, saved),
              ],
            )
          : Container(),
          Padding(padding: EdgeInsets.all(8.0),),
        ],
      ),
    );
  }

  Widget gameAbilityQuestions() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "שאלות על המשחק",
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
          ),
          Padding(padding: EdgeInsets.all(8.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                child: selectionInputWidget(_canScore, ["בכלל לא", "לנמוך", "לגבוה"], (val) => setState(() => _canScore = val)),
              ),
              Padding(padding: EdgeInsets.all(4.0),),
              Container(
                width: 150,
                child: Text(
                  'יכול להתעסק עם כדורים',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(8.0),),
          booleanInput('יכול לסובב את הגלגל', _canRotateTheRoulette, (val) => setState(() => _canRotateTheRoulette = val)),
          Padding(padding: EdgeInsets.all(8.0),),
          booleanInput('יכול לעצור את הגלגל', _canStopTheRoulette, (val) => setState(() => _canStopTheRoulette = val)),
          Padding(padding: EdgeInsets.all(4.0),),
        ],
      ),
    );
  }

  Widget basicAbilityQuestions() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "שאלות יכולת בסיסית",
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
          ),
          Padding(padding: EdgeInsets.all(8.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                child: selectionInputWidget(_powerCellAmount, ["לא מכיל כדורים", "כדור אחד", "שני כדורים", "שלושה כדורים"], (val) => setState(() => _powerCellAmount = val)),
              ),
              Padding(padding: EdgeInsets.all(4.0),),
              Container(
                width: 150,
                child: Text(
                  'כמה כדורים מכיל בתחילת משחק',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(8.0),),
          booleanInput('יכול להתחיל מכל עמדה', _canStartFromAnyPosition, (val) => setState(() => _canStartFromAnyPosition = val)),
          Padding(padding: EdgeInsets.all(4.0),),
        ],
      ),
    );
  }

  Widget selectionInputRowBuild(String selectedValue){
    return Container(
        child: selectedValue != null
            ? Container(
          width: 150,
          child: Text(
            selectedValue,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        )
            : Container(
          width: 150,
          child: Text(
            "Nothing Selected",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.red),
          ),
        )
    );
  }


  Widget ratioNumericInput(String label, String measurementUnitsCounter, String measurementUnitsDenominator, TextEditingController countController, TextEditingController denominatorController, int minVal, int maxVal, bool isInt) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(4.0),),
            Container(
              width: 90,
              child: TextFormField(
                  controller: countController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: measurementUnitsCounter,
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)
                    ),
                  ),
                  validator: (value) {
                    if (!saved) {
                      if (value.isEmpty)
                        return 'Please enter value';
                        if (!this.isNumeric(value))
                          return 'Please enter only digits';
                        dynamic numericValue = double.parse(value);;
                        List<String> split = numericValue.toString().split('.');
                        if (isInt && split[1]!='0')
                          return 'Value must be int';
                        if (numericValue < minVal || numericValue > maxVal)
                          return 'Value between ' + minVal.toString() + ' and ' + maxVal.toString();
                    } else {
                      if (value!=''){
                        if (!this.isNumeric(value))
                          return 'Please enter only digits';
                        dynamic numericValue = double.parse(value);;
                        List<String> split = numericValue.toString().split('.');
                        if (isInt && split[1]!='0')
                          return 'Value must be int';
                        if (numericValue < minVal || numericValue > maxVal)
                          return 'Value between ' + minVal.toString() + ' and ' + maxVal.toString();
                      }
                    }
                    return null;
                  }
              ),
            ),
            Container(
              width: 20,
              child: Text(
                ' / ',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              width: 90,
              child: TextFormField(
                  controller: denominatorController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: measurementUnitsDenominator,
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)
                    ),
                  ),
                  validator: (value) {
                    if (!saved) {
                      if (value.isEmpty)
                        return 'Please enter value';
                      if (!this.isNumeric(value))
                        return 'Please enter only digits';
                      dynamic numericValue = double.parse(value);;
                      List<String> split = numericValue.toString().split('.');
                      if (isInt && split[1]!='0')
                        return 'Value must be int';
                      if (numericValue < minVal || numericValue > maxVal)
                        return 'Value between ' + minVal.toString() + ' and ' + maxVal.toString();
                    } else {
                      if (value!=''){
                        if (!this.isNumeric(value))
                          return 'Please enter only digits';
                        dynamic numericValue = double.parse(value);;
                        List<String> split = numericValue.toString().split('.');
                        if (isInt && split[1]!='0')
                          return 'Value must be int';
                        if (numericValue < minVal || numericValue > maxVal)
                          return 'Value between ' + minVal.toString() + ' and ' + maxVal.toString();
                      }
                    }
                    return null;
                  }
              ),
            ),
            Padding(padding: EdgeInsets.all(4.0),),
            Container(
              width: 150,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
            Padding(padding: EdgeInsets.all(4.0),),
          ],
        )
    );
  }

  Widget booleanInput(String label, bool initValue, BooleanCallback callback) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 180,
          child: CupertinoSwitch(
            value: initValue,
            onChanged: (bool value) {
              callback(value);
            },
          ),
        ),
        Padding(padding: EdgeInsets.all(20.0),),
        Container(
          width: 120,
          child:  Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ),
        Padding(padding: EdgeInsets.only(right: 10),),
      ],
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
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

  Widget createLineWidget(){
    return Container(
      height: 2, width: 0.5, color: Colors.grey,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Padding(padding: EdgeInsets.all(10.0),),
    );
  }

  Future<void> whyCantSendData(BuildContext context) {
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