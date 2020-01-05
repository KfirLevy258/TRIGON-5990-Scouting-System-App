import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageStuff extends StatefulWidget {
  final tournament;
  final teamNumber;

  ImageStuff({Key key, this.tournament, this.teamNumber}) : super(key: key);

  @override
  _ImageStuffState createState() => _ImageStuffState();
}

class _ImageStuffState extends State<ImageStuff> {
  String url;
  File imageFile;

  @override
  Widget build(BuildContext context) {
    getImageURL();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
//          displayRobotImage(Image.network(url)),
          displayRobotImage(imageFile),
        ],
      ),
    );
  }

  Widget displayRobotImage(File file) {
    return  GestureDetector(
      onTap: () {
        cameraDialog(context);
      },
      child: ClipOval(
        child: Container(
          color: Colors.blue,
          height: 120.0,
          width: 120.0,
          child: file != null
              ? Image.file(file)
              : ifImageNotLoad(),
        ),
      ),
    );
  }

  Widget ifImageNotLoad() {
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
    FirebaseStorage.instance.ref().child('robots_pictures').child(widget.tournament).child(widget.teamNumber + '.jpg').getDownloadURL().then((res) {
      setState(() {
        url = res;
      });
    });
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
    uploadFile(imageFile);
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

  Future uploadFile(File file) async {

    StorageReference storageReference = FirebaseStorage.instance.ref().child('robots_pictures/ISRD1/' + widget.teamNumber + '.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;
    print('File Uploaded');
  }
}
