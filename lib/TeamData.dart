//import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamDataPage extends StatefulWidget{
  final String teamName;
  final String teamNumber;
  final String districtName;

  TeamDataPage({Key key, @required this.teamName, this.teamNumber, this.districtName}) : super(key: key);


  @override
  TeamPage createState() => TeamPage(teamName, districtName, teamNumber);

}

class TeamPage extends State<TeamDataPage> {
  File imageFile;
  String teamName;
  String districtName;
  String teamNumber;

  TeamPage(String name, String districtName, String teamNumber){
    this.teamName = name;
    this.districtName = districtName;
    this.teamNumber = teamNumber;
  }

  TextEditingController _robotWeightController = new TextEditingController();
  TextEditingController _robotWidthController = new TextEditingController();
  TextEditingController _robotLengthController = new TextEditingController();
  TextEditingController _dtMotorsController = new TextEditingController();
//  String _dtMotorType = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(teamName + " " + teamNumber, textAlign: TextAlign.center,),
      ),

      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          takeImage(context),
          printTeamName(),
          createLine(),
          quantitativeQuestionsWidget(),
          createLine(),
          Padding(padding: EdgeInsets.all(10.0),),
          selectionQuestion(),
          createLine(),
          Padding(padding: EdgeInsets.all(10.0),),
          yesOrNoQuestions(),
          submitButton(),
          Padding(padding: EdgeInsets.all(15.0),),
        ],
      )
      ,
    );
  }

  Widget submitButton(){
    String text = 'Submit';
    return FlatButton(
      color: Colors.blue,
      onPressed: () {
        submit();
        Navigator.of(context).pop();
      },
      padding: EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 40, color: Colors.white),
      ),
    );
  }

  Widget printTeamName(){
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

  Widget yesOrNoQuestions(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Yes Or No Questions",
          style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
        ),
        Padding(padding: EdgeInsets.all(10.0),),
        createSwitchQuestion("Is Panel Speclist"),
        Padding(padding: EdgeInsets.all(4.0),),
        createSwitchQuestion("Has Camera"),
        Padding(padding: EdgeInsets.all(4.0),),
        createSwitchQuestion("Can start 2 level"),
        Padding(padding: EdgeInsets.all(10.0),),
        createLine(),
      ],
    );
  }

  Widget selectionQuestion(){
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            "Selection Questions",
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),

          ),
          Padding(padding: EdgeInsets.all(10.0),),
          selectionQuestionCreator(context, "DT Motor Type", ["MINI CIMS", "CIMS", "NEOS", "OTHER"]),
          Padding(padding: EdgeInsets.all(4.0),),
          selectionQuestionCreator(context, "Wheel Type", ["TRACTION", "COLSON", "PNEUMATIC", "OMNI", "OTHER"]),
          Padding(padding: EdgeInsets.all(4.0),),
          selectionQuestionCreator(context, "Drive Train", ["TANK", "SWERVE", "MECANUM" , "OTHER"]),
          Padding(padding: EdgeInsets.all(4.0),),
          selectionQuestionCreator(context, "Programming Language", ["JAVA", "C++", "LABVIEW" , "OTHER"]),
          Padding(padding: EdgeInsets.all(10.0),),
        ],
      ),
    );
  }

  Widget quantitativeQuestionsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(8.0),),
          Text(
            "Quantative Questions",
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
          ),
          Padding(padding: EdgeInsets.all(8.0),),
          textFieldCreator("Robot Weight", "Pounds", _robotWeightController),
          Padding(padding: EdgeInsets.all(4.0),),
          textFieldCreator("Robot Width", "Inches", _robotWidthController),
          Padding(padding: EdgeInsets.all(4.0),),
          textFieldCreator("Robot Length", "Inches", _robotLengthController),
          Padding(padding: EdgeInsets.all(4.0),),
          textFieldCreator("DT Motors", "Amount", _dtMotorsController),
          Padding(padding: EdgeInsets.all(10.0),),
        ],
      ),
    );
  }

  submit() {
    Firestore.instance.collection("tournaments").document(districtName)
        .collection('teams').document(teamNumber.toString()).collection(
        'scoutingData').document('pitScouting').updateData({
          'saved': true,
          'Robot Weight': returnNumber(_robotWeightController),
          'Robot Width': returnNumber(_robotWidthController),
          'Robot Length': returnNumber(_robotLengthController),
          'DT Motors': returnNumber(_dtMotorsController),
      });
  }

  int returnNumber(TextEditingController controller){
    if (controller.text==""){
      return 0;
    }
    return int.parse(controller.text);
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

  Widget selectionQuestionCreator(BuildContext context, String label, List<String> list) {
    return Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                child: Text(
                  label,
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () {
                  selectionQuestionDialog(context, list);
                },
                child: Text(
                  "Check",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
              Padding(padding: EdgeInsets.all(4.0),),
            ],
          ),
        )
    );
  }

  List<Widget> optionsInDialog(List<String> list){
    List<Widget> listToReturn = [];
    for (int i =0; i<list.length; i++){
      listToReturn.add(OutlineButton(
        child: Text(
          list[i],
          style: TextStyle(fontSize: 15, color: Colors.blue),
        ),
        borderSide: BorderSide(color: Colors.lightBlue),
        shape: StadiumBorder(),
        onPressed: () {
          print(list[i]);
          Navigator.pop(context, list[i]);
        },
      ));
    }
    return listToReturn;
  }

  Future<void> selectionQuestionDialog(BuildContext context,  List<String> list){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Check one item from the list:"),
        content: SingleChildScrollView(
          child: ListBody(
            children: optionsInDialog(list),
          ),
        ),
      );
    });
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

  Widget createLine(){
    return Container(
      height: 2, width: 0.5, color: Colors.grey,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Padding(padding: EdgeInsets.all(10.0),),
    );
  }

  Widget textFieldCreator(String label, String measurementUnits, TextEditingController controller){
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),),
          Container(
            width: 150,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
          Container(
            width: 170,
            child: TextField(
              textAlign: TextAlign.center,
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                hintText: measurementUnits,
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createSwitchQuestion(String text){
    bool _switchChecked = false;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 200,
            child: Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
          ),
          CupertinoSwitch(
            value: _switchChecked,
            onChanged: (flag) {
              setState(() { // state change is to change the state value by setState
                _switchChecked = flag;
              });
              },
          ),
        ],
      ),
    );
  }
}
