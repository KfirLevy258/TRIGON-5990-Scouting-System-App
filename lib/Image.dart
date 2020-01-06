import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pit_scout/PitScouting/PitTeamDataInput.dart';

class ImageStuff extends StatefulWidget {
  final tournament;
  final teamNumber;
  final FileCallback fileCallback;

  ImageStuff({Key key, this.tournament, this.teamNumber, this.fileCallback}) : super(key: key);

  @override
  _ImageStuffState createState() => _ImageStuffState();
}

class _ImageStuffState extends State<ImageStuff> {
  String url;
  File imageFile;

  @override
  void initState() {
    getImageURL();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          cameraDialog(context);
        },
        child: ClipOval(
          child: Container(
            color: Colors.blue,
            height: 120.0,
            width: 120.0,
            child: imageFile != null
                ? Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                )
                : url != null
                  ? Image.network(
                    url,
                    fit: BoxFit.cover,
                  )
                  : imageFileNotLoadedWidget(),
          ),
        ),
      ),
    );
  }

  Widget imageFileNotLoadedWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(8.0),),
          Icon(
            Icons.camera_alt,
            size: 50,
            color: Colors.white,
          ),
          Text(
            "Add robot \nPicture",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }

  getImageURL () {
    FirebaseStorage.instance.ref().child('robots_pictures').child(
        widget.tournament).child(widget.teamNumber).getDownloadURL()
        .then((res) {
          setState(() {
            url = res;
          });
        })
        .catchError((err) {
          url = null;
        });
  }

  openGallery(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){
      imageFile = picture;
    });
    widget.fileCallback(imageFile);
    Navigator.of(context).pop();
  }

  openCamera(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      imageFile = picture;
    });
    widget.fileCallback(imageFile);
    Navigator.of(context).pop();
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

}
