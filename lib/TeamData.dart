import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class TeamDataPage extends StatefulWidget{
  String team_name;

  TeamDataPage({Key key, @required this.team_name}) : super(key: key);


  @override
  TeamPage createState() => TeamPage(team_name);

}

class TeamPage extends State<TeamDataPage> {
  File imageFile;
  String team_name;

  TeamPage(String name){
    team_name = name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(team_name, textAlign: TextAlign.center,),
      ),

      body: ListView(
        children: <Widget>[
          takeImage(context),
          Padding(padding: EdgeInsets.all(10.0),),
          Center(
            child: Column(
              children: <Widget>[
                Text(
                  team_name, style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.all(8.0),),
              ],
            ),
          ),
          createLine(),
          Center(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(8.0),),
                Text(
                  "Numbers Questions",
                  style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                ),
                Padding(padding: EdgeInsets.all(8.0),),
                textFieldCreator("Robot Weight", "Pounds"),
                Padding(padding: EdgeInsets.all(4.0),),
                textFieldCreator("Robot Width", "Inches"),
                Padding(padding: EdgeInsets.all(4.0),),
                textFieldCreator("Robot Length", "Inches"),
                Padding(padding: EdgeInsets.all(4.0),),
                textFieldCreator("DT Motors", "Amount"),
                Padding(padding: EdgeInsets.all(4.0),),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0),),
          createLine(),
          Padding(padding: EdgeInsets.all(10.0),),
          Center(
            child: Text(
              "'One Out Of' Questions",
              style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),

            ),
          ),
          Padding(padding: EdgeInsets.all(10.0),),
          oneOutOfQuestion(context, "DT Motor Type", ["MINI CIMS", "CIMS", "NEOS", "OTHER"]),
          Padding(padding: EdgeInsets.all(4.0),),
          oneOutOfQuestion(context, "Wheel Type", ["TRACTION", "COLSON", "PNEUMATIC", "OMNI", "OTHER"]),
          Padding(padding: EdgeInsets.all(4.0),),
          oneOutOfQuestion(context, "Drive Train", ["TANK", "SWERVE", "MECANUM" , "OTHER"]),
          Padding(padding: EdgeInsets.all(4.0),),
          oneOutOfQuestion(context, "Programming Language", ["JAVA", "C++", "LABVIEW" , "OTHER"]),
          Padding(padding: EdgeInsets.all(4.0),),

          Padding(padding: EdgeInsets.all(10.0),),
          createLine(),
          Padding(padding: EdgeInsets.all(10.0),),
          Center(
            child: Text(
              "Yes Or No Questions",
              style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0),),
          createSwitchQ("Is Panel Speclist"),
          Padding(padding: EdgeInsets.all(4.0),),
          createSwitchQ("Has Camera"),
          Padding(padding: EdgeInsets.all(4.0),),
          createSwitchQ("Can start 2 level"),
          Padding(padding: EdgeInsets.all(10.0),),
          createLine(),
          Padding(padding: EdgeInsets.all(15.0),),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Submit",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          Padding(padding: EdgeInsets.all(15.0),),

        ],
      )
      ,
    );
  }

  _openGallary(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }


  _openCamera(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Widget oneOutOfQuestion(BuildContext context, String text, List<String> list) {
    return Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                child: Text(
                  text,
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () {
                  _oneOutOfQuestion(context, list);
                },
                child: Text(
                  "Check",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ],
          ),
        )
    );
  }

  List<Widget> options(List<String> list){
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
          Navigator.of(context).pop();
        },
      ));
    }
    return listToReturn;
  }

  Future<void> _oneOutOfQuestion(BuildContext context, List<String> list){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Check one item from the list:"),
        content: SingleChildScrollView(
          child: ListBody(
            children: options(list),
          ),
        ),
      );
    });
  }

  Future<void> _showChoiceDialog(BuildContext context){
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
                  _openGallary(context);
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
                  _openCamera(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _ifImageLoad() {
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
                  _showChoiceDialog(context);
                },
                child: ClipOval(
                  child: Container(
                    color: Colors.blue,
                    height: 120.0,
                    width: 120.0,
                    child: _ifImageLoad(),
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
      margin: const EdgeInsets.only(left: 30.0, right: 30.0),);
  }

  Widget textFieldCreator(String text, String kind){
    final myController = TextEditingController();

    return Center(
      child: Row(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 8),),
          Container(
            width: 150,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
          Container(
            width: 170,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                hintText: kind,
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)
                ),
              ),
              controller: myController,
          ),
          ),
        ],
      ),
    );
  }

  Widget createSwitchQ(String text){
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
