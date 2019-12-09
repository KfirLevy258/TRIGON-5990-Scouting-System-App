import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class TeamDataPage extends StatelessWidget {
  final String team_name;
  TeamDataPage({Key key, @required this.team_name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(team_name, textAlign: TextAlign.center,),
      ),
      body: PitScoutingPage()
      );
  }
}

class PitScoutingPage extends StatefulWidget{
  final String title;
  PitScoutingPage({Key key, this.title}) : super(key: key);

  String getTeamName(){
    return this.title;
  }

  @override
  TeamPage createState() => TeamPage();

}

class TeamPage extends State<PitScoutingPage> {
  File imageFile;


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

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Make a choice"),
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        takeImage(context),
        textFieldCreator("Robot Weight", "Pounds"),
        textFieldCreator("Robot Width", "Inches"),
        textFieldCreator("Robot Length", "Inches"),
        textFieldCreator("DT Motors", "Amount"),
      ],
    );
  }

  Widget toggleButtonsCreator(){
    // TO DO :
    // make some kind of Toggle Buttons function that get an array
  }

  Widget textFieldCreator(String text, String kind){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: TextField(
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 50, right: 50, top: 20),
              labelText: text,
              labelStyle: TextStyle(color: Colors.blue, fontSize: 20),
              hintText: kind,
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
