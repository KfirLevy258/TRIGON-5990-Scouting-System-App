import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_for_amit/Student.dart';
import 'package:flutter_app_for_amit/StudentPage.dart';

class StudentsSettings extends StatefulWidget {


  @override
  _StudentsSettingsState createState() => _StudentsSettingsState();
}

class _StudentsSettingsState extends State<StudentsSettings > {

  List<Student> studentsInClass = [];

  @override
  void initState() {
    getStudentsInClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ListView(
      children: <Widget>[
        studentsInClass.isEmpty
            ? Container(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(height/7),),
                  Text(
                    'loading',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 35),
                  ),
                ],
              ),
            )
            : Column(
              children: studentsListWidget()
            )
      ],
    );
  }

  getStudentsInClass() {
    Firestore.instance.collection('Students').getDocuments().then((val) {
      for (int i = 0; i < val.documents.length; i++){
        studentsInClass.add(new Student(
          val.documents[i].documentID,
          val.documents[i].data['days']['sunday'],
          val.documents[i].data['days']['monday'],
          val.documents[i].data['days']['tuesday'],
          val.documents[i].data['days']['wednesday'],
          val.documents[i].data['days']['thursday'],
        ));
      }
      setState(() {

      });
    });
  }

  List<Widget> studentsListWidget() {
    List<Widget> listToReturn = [];
    for (int i = 0 ; i < studentsInClass.length; i++){
      listToReturn.add(ListTile(
        title: Text(
          studentsInClass[i].name,
          textAlign: TextAlign.right,
        ),
        leading: Icon(
          Icons.arrow_back_ios
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentPage(student: studentsInClass[i],)),
          ).then((val){
            if(val is Student){
              studentsInClass[i] = val;
            }
          });},
      ));
    }
    return listToReturn;
  }
}
