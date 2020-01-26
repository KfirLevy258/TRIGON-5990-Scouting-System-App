import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_for_amit/Student.dart';

import 'booleanInput.dart';

class StudentPage extends StatefulWidget {
  final Student student;

  const StudentPage({Key key, this.student}) : super(key: key);

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {

  bool sundayComing;
  bool mondayComing;
  bool tuesdayComing;
  bool wednesdayComing;
  bool thursdayComing;

  @override
  void initState() {
    sundayComing = widget.student.sundayComing;
    mondayComing = widget.student.mondayComing;
    tuesdayComing = widget.student.tuesdayComing;
    wednesdayComing = widget.student.wednesdayComing;
    thursdayComing = widget.student.thursdayComing;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.student.name,
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(20.0),),
          Text(
            widget.student.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
          Padding(padding: EdgeInsets.all(20.0),),
          studentDays(),
          Container(
            width: width/10,
            height: height/9,
            child: FlatButton(
              color: Colors.blue,
              onPressed: () {
                saveToFirebase(widget.student.name, sundayComing, mondayComing, tuesdayComing, wednesdayComing, thursdayComing);
                Navigator.pop(context, new Student(widget.student.name, sundayComing, mondayComing, tuesdayComing, wednesdayComing, thursdayComing));
              },
              child: Text(
                'סיים ושמור',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0),),
        ],
      ),
    );
  }

  Widget studentDays(){
    return Column(
      children: <Widget>[
        booleanInputWidget(':הגעה ביום ראשון', sundayComing, ((val) {
            setState(() {
              sundayComing = val;
            });
          })),
        Padding(padding: EdgeInsets.all(7.0),),
        booleanInputWidget(':הגעה ביום שני', mondayComing, ((val) {
            setState(() {
              mondayComing = val;
            });
          })),
        Padding(padding: EdgeInsets.all(7.0),),
        booleanInputWidget(':הגעה ביום שלישי', tuesdayComing, ((val) {
            setState(() {
              tuesdayComing = val;
            });
          })),
        Padding(padding: EdgeInsets.all(7.0),),
        booleanInputWidget(':הגעה ביום רביעי', wednesdayComing, ((val) {
            setState(() {
              wednesdayComing = val;
            });
          })),
        Padding(padding: EdgeInsets.all(7.0),),
        booleanInputWidget(':הגעה ביום חמישי', thursdayComing, ((val) {
            setState(() {
              thursdayComing = val;
            });
          })),
        Padding(padding: EdgeInsets.all(15.0),),

        Padding(padding: EdgeInsets.all(15.0),),
      ],
    );
  }

  Widget separatorLineWidget(){
    return Container(
      height: 2, width: 0.5, color: Colors.grey,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
      child: Padding(padding: EdgeInsets.all(10.0),),
    );
  }
  
  saveToFirebase(String name, bool sundayComing, bool mondayComing, bool tuesdayComing, bool wednesdayComing, bool thursdayComing){
    Firestore.instance.collection('Students').document(name).setData({
      'days': {
        'sunday' : sundayComing,
        'monday' : mondayComing,
        'tuesday' : tuesdayComing,
        'wednesday' : wednesdayComing,
        'thursday' : thursdayComing,
      },
    });
  }

}
