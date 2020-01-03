import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestPage extends StatefulWidget {
  final tournament;

  TestPage({Key key, this.tournament}) : super(key: key);
  
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String testText = 'aaa';
  String url;

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('tournaments').document('ISRD1').collection('teams').document('1574').get()
    .then((res) {
      setState(() {
        testText = res.data['team_name'];
      });
      print(res.data);
    });

//    FirebaseStorage.instance.ref().child('robots_pictures/ISRD1/1574.jpg').getDownloadURL()

    FirebaseStorage.instance.ref().child('robots_pictures').child(widget.tournament).child('1574.jpg').getDownloadURL()
    .then((res) {
      setState(() {
        url = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: url != null ? Image.network(url) : Text('no image'),
    );
  }
}
