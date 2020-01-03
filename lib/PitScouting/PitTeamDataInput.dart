import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class TeamDataPage extends StatefulWidget {
  final String teamName;
  final String teamNumber;
  final String districtName;
  final bool saved;

  TeamDataPage({Key key, @required this.teamName, this.teamNumber, this.districtName, this.saved}) : super(key: key);

  @override
  _TeamDataPageState createState() => _TeamDataPageState(teamName, districtName, teamNumber, saved);
}

typedef void StringCallback(String val);
typedef void BooleanCallback(bool val);

class _TeamDataPageState extends State<TeamDataPage> {
  final _formKey = GlobalKey<FormState>();
  File imageFile;

  TextEditingController _robotWeightController = new TextEditingController();
  TextEditingController _robotWidthController = new TextEditingController();
  TextEditingController _robotLengthController = new TextEditingController();
  TextEditingController _dtMotorsController = new TextEditingController();
  TextEditingController _conversionRatio = new TextEditingController();

  String _dtMotorType = 'Nothing Selected';
//  String _wheelType;
//  String _driveTrain;
//  String _programmingLanguage;
  String _wheelDiameter = 'Nothing Selected';

//  bool _isPanelSpeclist = false;
//  bool _hasCamera = false;
//  bool _canStart2ndLevel = false;

  String _robotWeightData = "Kilogram";
  String _robotWidthData = "Centimeter";
  String _robotLengthData = "Centimeter";
  String _dtMotorsData = "Amount";
  String _conversionRatioData = "Y/X";

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
//            _conversionRatioData = val.data[""]
//            _robotWeightData = val.data['Robot Weight'].toString();
//            _robotWidthData = val.data['Robot Width'].toString();
//            _robotLengthData = val.data['Robot Length'].toString();
//            _dtMotorsData = val.data['DT Motors'].toString();
//            _dtMotorType = val.data['DT Motor type'];
//            _wheelType = val.data['Wheel Type'];
//            _driveTrain = val.data['Drive Train'];
//            _programmingLanguage = val.data['Programming Language'];
//            _isPanelSpeclist = val.data['is Panel Speclist'];
//            _hasCamera = val.data['Has Camera'];
//            _canStart2ndLevel = val.data['Can start 2nd Level'];
            _dtMotorType = val.data['Pit_scouting']['Chassis Overall Strength']['DT Motor type'];
            _wheelDiameter = val.data['Pit_scouting']['Chassis Overall Strength']['Wheel Diameter'];
            _conversionRatioData = val.data['Pit_scouting']['Chassis Overall Strength']['Conversion Ratio'];
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
              takeImage(context),
              teamNameLabel(),
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
              RaisedButton(
                color: Colors.blue,
                padding: EdgeInsets.all(8.0),
                onPressed: () {
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate() && allSelectionIsFill()) {
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

  bool allSelectionIsFill(){
    if (_dtMotorType!='Nothing Selected' && _wheelDiameter!='Nothing Selected'){
      return true;
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
          numericInput("משקל הרובוט", _robotWeightData, _robotWeightController, 80, 125, false, false),
          Padding(padding: EdgeInsets.all(4.0),),
          numericInput("רוחב הרובוט", _robotWidthData, _robotWidthController, 0, 20, false, false),
          Padding(padding: EdgeInsets.all(4.0),),
          numericInput("אורך הרובוט", _robotLengthData, _robotLengthController, 0, 30, false, false),
          Padding(padding: EdgeInsets.all(4.0),),
          numericInput("כמות המנועים", _dtMotorsData, _dtMotorsController, 4, 8, false, true),
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
                child: selectionInput(_wheelDiameter, ["3 Inch", "4 Inch", "5 Inch", "6 Inch", "7 Inch",  "8 Inch"], (val) => setState(() => _wheelDiameter = val)),
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
          numericInput("יחס המרה", _conversionRatioData, _conversionRatio, 1, 100000, true, false),
          Padding(padding: EdgeInsets.all(4.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                child: selectionInput(_dtMotorType, ["מיני סימים", "סימים", "נאו", "אחר"], (val) => setState(() => _dtMotorType = val)),
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

//  Widget selectionQuestionsWidget() {
//    return Center(
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Text(
//            "Selection Questions",
//            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
//          ),
//          Padding(padding: EdgeInsets.all(15.0),),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                width: 220,
//                child: selectionInput("Programming Language", ["JAVA", "C++", "LABVIEW" , "OTHER"], (val) => setState(() => _programmingLanguage = val)),
//              ),
//              selectionInputRowBuild(_programmingLanguage)
//            ],
//          ),
//          Padding(padding: EdgeInsets.all(4.0),),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                width: 220,
//                child: selectionInput("DT Motor Type", ["MINI CIMS", "CIMS", "NEOS", "OTHER"], (val) => setState(() => _dtMotorType = val)),
//              ),
//              selectionInputRowBuild(_dtMotorType)
//            ],
//          ),
//          Padding(padding: EdgeInsets.all(4.0),),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                width: 220,
//                child: selectionInput("Wheel Type", ["TRACTION", "COLSON", "PNEUMATIC", "OMNI", "OTHER"], (val) => setState(() => _wheelType = val)),
//              ),
//              selectionInputRowBuild(_wheelType)
//            ],
//          ),
//          Padding(padding: EdgeInsets.all(4.0),),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                width: 220,
//                child: selectionInput("Drive Train", ["TANK", "SWERVE", "MECANUM" , "OTHER"], (val) => setState(() => _driveTrain = val)),
//              ),
//              selectionInputRowBuild(_driveTrain)
//            ],
//          ),
//        ],
//      ),
//    );
//  }

//  Widget booleanQuestionsWidget() {
//    return Center(
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Text(
//            "Yes and No Questions",
//            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
//          ),
//          Padding(padding: EdgeInsets.all(15.0),),
//          booleanInput('Can start 2nd Level', _canStart2ndLevel, (val) => setState(() => _canStart2ndLevel = val)),
//          Padding(padding: EdgeInsets.all(4.0),),
//          booleanInput('is Panel Speclist', _isPanelSpeclist, (val) => setState(() => _isPanelSpeclist = val)),
//          Padding(padding: EdgeInsets.all(4.0),),
//          booleanInput('has Camera', _hasCamera, (val) => setState(() => _hasCamera = val)),
//
//        ],
//      ),
//    );
//  }

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

  Widget numericInput(String label, String measurementUnits, TextEditingController controller, int minVal, int maxVal, bool isString, bool isInt) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(4.0),),
            Container(
              width: 200,
              child: TextFormField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  keyboardType: isString ? TextInputType.text : TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: measurementUnits,
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)
                    ),
                  ),
                  validator: (value) {
                    if (!saved) {
                      if (value.isEmpty)
                        return 'Please enter value';
                      if (!isString){
                        if (!this.isNumeric(value))
                          return 'Please enter only digits';
                        dynamic numericValue = double.parse(value);;
                        List<String> split = numericValue.toString().split('.');
                        if (isInt && split[1]!='0')
                          return 'Value must be int';
                        if (numericValue < minVal || numericValue > maxVal)
                          return 'Value between ' + minVal.toString() + ' and ' + maxVal.toString();
                      }
                    } else {
                      if (!isString && value!=''){
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

  Widget selectionInput(String label, List<String> options, StringCallback callback) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropdownButton(
          hint: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: label=='Nothing Selected' ? Colors.red : Colors.grey),
          ),
          onChanged: (newValue) {
            callback(newValue);
          },
          items: options.map((option) {
            return DropdownMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    option,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              value: option,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget booleanInput(String label, bool initValue, BooleanCallback callback) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 200,
          child:  Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          child: CupertinoSwitch(
            value: initValue,
            onChanged: (bool value) {
              callback(value);
            },
          ),
        ),
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
          'Conversion Ratio': _conversionRatio.text=='' ? _conversionRatioData : _conversionRatio.text,
          'DT Motor type': _dtMotorType,
          'Wheel Diameter': _wheelDiameter
        },
        'Robot basic data': {
          'Robot Weight': _robotWeightController.text=='' ? double.parse(_robotWeightData) : double.parse(_robotWeightController.text),
          'Robot Width': _robotWidthController.text=='' ? double.parse(_robotWidthData) : double.parse(_robotWidthController.text),
          'Robot Length': _robotLengthController.text=='' ? double.parse(_robotLengthData) : double.parse(_robotLengthController.text),
          'DT Motors': _dtMotorsController.text=='' ? double.parse(_dtMotorsData) : double.parse(_dtMotorsController.text),
        }
      },
//             'DT Motor type': _dtMotorType,
//          'Wheel Type': _wheelType,
//          'Drive Train': _driveTrain,
//          'Programming Language': _programmingLanguage,
//          'is Panel Speclist': _isPanelSpeclist,
//          'Has Camera': _hasCamera,
//          'Can start 2nd Level': _canStart2ndLevel,

    });
  }

  Widget createLineWidget(){
    return Container(
      height: 2, width: 0.5, color: Colors.grey,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Padding(padding: EdgeInsets.all(10.0),),
    );
  }

  Widget takeImage(BuildContext context) {
    return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                onTap: () {
                  cameraDialog(context);
                },
                child: ClipOval(
                  child: Container(
                    color: Colors.blue,
                    height: 120.0,
                    width: 120.0,
                    child: ifImageLoad(),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }


  Future<void> cameraDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Take a picture from:"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.image),
                      Text(" Gallary"),
                    ],
                  ),
                ),
                onTap: () {
                  openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.camera_alt),
                      Text(" Camera"),
                    ],
                  ),
                ),
                onTap: () {
                  openCamera(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }

  Widget ifImageLoad() {
    if (imageFile == null) {
      return Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(8.0),),
          Icon(
            Icons.camera_alt,
            size: 50,
            color: Colors.white,
          ),
          Text(
            "Add robot \n Picture",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(8.0),),
          Icon(
            Icons.cloud_upload,
            size: 50,
            color: Colors.white,
          ),
          Text(
            "Image \n Uploaded",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),

        ],
      );
    }
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

  openGallery(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  openCamera(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Widget teamNameLabel(){
    return Center(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10.0),),
          Text(
            teamName + " " + teamNumber, style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          Padding(padding: EdgeInsets.all(8.0),),
        ],
      ),
    );
  }
}