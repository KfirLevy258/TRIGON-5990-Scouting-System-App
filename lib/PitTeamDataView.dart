import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class TeamDataPageView extends StatefulWidget {
  final String teamName;
  final String teamNumber;
  final String districtName;

  TeamDataPageView({Key key, @required this.teamName, this.teamNumber, this.districtName}) : super(key: key);

  @override
  _TeamDataPageViewState createState() => _TeamDataPageViewState(teamName, districtName, teamNumber);
}

typedef void StringCallback(String val);
typedef void BooleanCallback(bool val);

class _TeamDataPageViewState extends State<TeamDataPageView> {
  final _formKey = GlobalKey<FormState>();
  File imageFile;

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

  int _robotWeightData = 0;
  int _robotWidthData = 0;
  int _robotLengthData = 0;
  int _dtMotorsData = 0;

  String teamName;
  String districtName;
  String teamNumber;

  _TeamDataPageViewState(String name, String districtName, String teamNumber){
    this.teamName = name;
    this.districtName = districtName;
    this.teamNumber = teamNumber;
    Firestore.instance.collection('tournaments').document(this.districtName).collection('teams').document(this.teamNumber).get().then((val){
      if (val.documentID.length > 0) {
        setState(() {
          _robotWeightData = val.data['Robot Weight'];
          _robotWidthData = val.data['Robot Width'];
          _robotLengthData = val.data['Robot Length'];
          _dtMotorsData = val.data['DT Motors'];
          _dtMotorType = val.data['DT Motor type'];
          _wheelType = val.data['Wheel Type'];
          _driveTrain = val.data['Drive Train'];
          _programmingLanguage = val.data['Programming Language'];
          _isPanelSpeclist = val.data['is Panel Speclist'];
          _hasCamera = val.data['Has Camera'];
          _canStart2ndLevel = val.data['Can start 2nd Level'];
        });
      }
    });
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
              createLineWidget(),
              Padding(padding: EdgeInsets.all(15.0),),
              quantitativeQuestionsWidget(),
              Padding(padding: EdgeInsets.all(15.0),),
              createLineWidget(),
              Padding(padding: EdgeInsets.all(15.0),),
              selectionQuestionsWidget(),
              Padding(padding: EdgeInsets.all(15),),
              createLineWidget(),
              Padding(padding: EdgeInsets.all(15.0),),
              booleanQuestionsWidget(),
              Padding(padding: EdgeInsets.all(15.0),),
              createLineWidget(),
              Padding(padding: EdgeInsets.all(15.0),),
              RaisedButton(
                color: Colors.blue,
                padding: EdgeInsets.all(8.0),
                onPressed: () {
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
    if (_programmingLanguage!=null && _dtMotorType!=null && _wheelType!=null && _driveTrain!=null){
      return true;
    }
    return false;
  }

  Widget quantitativeQuestionsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Quantative Questions",
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
          ),
          Padding(padding: EdgeInsets.all(15.0),),
          numericInput("Robot Weight", "Pounds", _robotWeightController, 0, 10, _robotWeightData),
          Padding(padding: EdgeInsets.all(4.0),),
          numericInput("Robot Width", "Inches", _robotWidthController, 0, 20, _robotWidthData),
          Padding(padding: EdgeInsets.all(4.0),),
          numericInput("Robot Length", "Inches", _robotLengthController, 0, 30, _robotLengthData),
          Padding(padding: EdgeInsets.all(4.0),),
          numericInput("DT Motors", "Amount", _dtMotorsController, 0, 40, _dtMotorsData),
        ],
      ),
    );
  }

  Widget selectionQuestionsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Selection Questions",
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
          ),
          Padding(padding: EdgeInsets.all(15.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 220,
                child: selectionInput("Programming Language", ["JAVA", "C++", "LABVIEW" , "OTHER"], (val) => setState(() => _programmingLanguage = val)),
              ),
              selectionInputRowBuild(_programmingLanguage)
            ],
          ),
          Padding(padding: EdgeInsets.all(4.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 220,
                child: selectionInput("DT Motor Type", ["MINI CIMS", "CIMS", "NEOS", "OTHER"], (val) => setState(() => _dtMotorType = val)),
              ),
              selectionInputRowBuild(_dtMotorType)
            ],
          ),
          Padding(padding: EdgeInsets.all(4.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 220,
                child: selectionInput("Wheel Type", ["TRACTION", "COLSON", "PNEUMATIC", "OMNI", "OTHER"], (val) => setState(() => _wheelType = val)),
              ),
              selectionInputRowBuild(_wheelType)
            ],
          ),
          Padding(padding: EdgeInsets.all(4.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 220,
                child: selectionInput("Drive Train", ["TANK", "SWERVE", "MECANUM" , "OTHER"], (val) => setState(() => _driveTrain = val)),
              ),
              selectionInputRowBuild(_driveTrain)
            ],
          ),
        ],
      ),
    );
  }

  Widget booleanQuestionsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Yes and No Questions",
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
          ),
          Padding(padding: EdgeInsets.all(15.0),),
          booleanInput('Can start 2nd Level', _canStart2ndLevel, (val) => setState(() => _canStart2ndLevel = val)),
          Padding(padding: EdgeInsets.all(4.0),),
          booleanInput('is Panel Speclist', _isPanelSpeclist, (val) => setState(() => _isPanelSpeclist = val)),
          Padding(padding: EdgeInsets.all(4.0),),
          booleanInput('has Camera', _hasCamera, (val) => setState(() => _hasCamera = val)),
        ],
      ),
    );
  }

  Widget selectionInputRowBuild(String selectedValue){
    return Container(
        child: selectedValue != null
            ? Container(
          width: 100,
          child: Text(
            selectedValue,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.blue),
          ),
        )
            : Container(
          width: 100,
          child: Text(
            "Nothing Selected",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.red),
          ),
        )
    );
  }

  Widget numericInput(String label, String measurementUnits, TextEditingController controller, int minVal, int maxVal, int firebaseInit) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            Container(
              width: 210,
              child: TextFormField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: firebaseInit.toString(),
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty==false) {
                    if (!this.isNumeric(value)) {
                      return 'Please enter only digits';
                    }
                    int numericValue = int.parse(value);
                    if (numericValue < minVal || numericValue > maxVal) {
                      return 'Value must be between ' + minVal.toString() + ' and ' + maxVal.toString();
                    }
                  }
                  return null;
                },
              ),
            ),
            Padding(padding: EdgeInsets.all(4.0),),
          ],
        )
    );
  }

  Widget selectionInput(String label, List<String> options, StringCallback callback) {

    return DropdownButton(
      hint: Text(
        label,
        textAlign: TextAlign.center,
      ),
      onChanged: (newValue) {
        callback(newValue);
      },
      items: options.map((option) {
        return DropdownMenuItem(
          child: new Text(
            option,
            textAlign: TextAlign.center,
          ),
          value: option,
        );
      }).toList(),
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
        'Robot Weight': _robotWeightController.text=='' ? _robotWeightData : int.parse(_robotWeightController.text),
        'Robot Width': _robotWidthController.text=='' ? _robotWidthData : int.parse(_robotWidthController.text),
        'Robot Length': _robotLengthController.text=='' ? _robotLengthData : int.parse(_robotLengthController.text),
        'DT Motors': _dtMotorsController.text=='' ? _dtMotorsData : int.parse(_dtMotorsController.text),
        'DT Motor type': _dtMotorType,
        'Wheel Type': _wheelType,
        'Drive Train': _driveTrain,
        'Programming Language': _programmingLanguage,
        'is Panel Speclist': _isPanelSpeclist,
        'Has Camera': _hasCamera,
        'Can start 2nd Level': _canStart2ndLevel
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

  Future uploadPictureToFireBase(BuildContext context) async{

  }

}
