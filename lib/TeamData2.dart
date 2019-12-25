import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TeamData2Page extends StatefulWidget {
  final String teamName;
  final String teamNumber;
  final String districtName;

  TeamData2Page({Key key, @required this.teamName, this.teamNumber, this.districtName}) : super(key: key);

  @override
  _TeamData2PageState createState() => _TeamData2PageState(teamName, districtName, teamNumber);
}

typedef void StringCallback(String val);
typedef void BooleanCallback(bool val);

class _TeamData2PageState extends State<TeamData2Page> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _robotWeightController = new TextEditingController();
  TextEditingController _robotWidthController = new TextEditingController();
  TextEditingController _robotLengthController = new TextEditingController();
  TextEditingController _dtMotorsController = new TextEditingController();

  String _dtMotorType;
  String _wheelType;
  String _driveTrain;
  String _programmingLanguage;

  bool _isPanelSpeclist = false;
  bool _hasCamera = false;
  bool _canStart2ndLevel = false;

  String teamName;
  String districtName;
  String teamNumber;

  _TeamData2PageState(String name, String districtName, String teamNumber){
    this.teamName = name;
    this.districtName = districtName;
    this.teamNumber = teamNumber;
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.teamName),
        ),
        body: ListView(
          children: <Widget>[
            numericInput("Robot Weight", "Pounds", _robotWeightController, 0, 10),
            numericInput("Robot Width", "Inches", _robotWidthController, 0, 20),
            numericInput("Robot Length", "Inches", _robotLengthController, 0, 30),
            numericInput("DT Motors", "Amount", _dtMotorsController, 0, 40),
            Row(
              children: <Widget>[
                selectionInput("DT Motor Type", ["MINI CIMS", "CIMS", "NEOS", "OTHER"], (val) => setState(() => _dtMotorType = val)),
                _dtMotorType != null ? Text(_dtMotorType) : Container()
              ],
            ),
            Row(
              children: <Widget>[
                selectionInput("Wheel Type", ["TRACTION", "COLSON", "PNEUMATIC", "OMNI", "OTHER"], (val) => setState(() => _wheelType = val)),
                _wheelType != null ? Text(_wheelType) : Container()
              ],
            ),
            Row(
              children: <Widget>[
                selectionInput("Drive Train", ["TANK", "SWERVE", "MECANUM" , "OTHER"], (val) => setState(() => _driveTrain = val)),
                _driveTrain != null ? Text(_driveTrain) : Container()
              ],
            ),
            Row(
              children: <Widget>[
                selectionInput("Programming Language", ["JAVA", "C++", "LABVIEW" , "OTHER"], (val) => setState(() => _programmingLanguage = val)),
                _programmingLanguage != null ? Text(_programmingLanguage) : Container()
              ],
            ),
            booleanInput('is Panel Speclist', _isPanelSpeclist, (val) => setState(() => _isPanelSpeclist = val)),
            booleanInput('has Camera', _hasCamera, (val) => setState(() => _hasCamera = val)),
            booleanInput('Can start 2nd Level', _canStart2ndLevel, (val) => setState(() => _canStart2ndLevel = val)),
            RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  saveToFireBase();
                }
              },
              child: Text('Submit'),
            )

      ],
        )
      ),
    );
  }

  Widget numericInput(String label, String measurementUnits, TextEditingController controller, int minVal, int maxVal) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: measurementUnits,
          labelText: label
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'please enter value';
        }
        if (!this.isNumeric(value)) {
          return 'please enter only digits';
        }
        int numericValue = int.parse(value);
        if (numericValue < minVal || numericValue > maxVal) {
          return 'value must be between ' + minVal.toString() + ' and ' + maxVal.toString();
        }
        return null;
      },
    );
  }


  Widget selectionInput(String label, List<String> options, StringCallback callback) {

    return DropdownButton(
      hint: Text(label),
//      value: _selectedOption,
      onChanged: (newValue) {
        callback(newValue);
//        setState(() {
//          _selectedOption = newValue;
//        });
      },
      items: options.map((option) {
        return DropdownMenuItem(
          child: new Text(option),
          value: option,
        );
      }).toList(),
    );
  }

  Widget booleanInput(String label, bool initValue, BooleanCallback callback) {
    return ListTile(
      title: Text(label),
      trailing: CupertinoSwitch(
        value: initValue,
        onChanged: (bool value) {
          callback(value);
        },
      ),

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
      'Robot Weight': int.parse(_robotWeightController.text),
      'Robot Width': int.parse(_robotWidthController.text),
      'Robot Length': int.parse(_robotLengthController.text),
      'DT Motors': int.parse(_dtMotorsController.text),
      'DT Motor type': _dtMotorType,
      'Wheel Type': _wheelType,
      'Drive Train': _driveTrain,
      'Programming Language': _programmingLanguage,
      'is Panel Speclist': _isPanelSpeclist,
      'Has Camera': _hasCamera,
      'Can start 2nd Level': _canStart2ndLevel
    });
  }

}
