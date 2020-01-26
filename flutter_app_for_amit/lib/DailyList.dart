import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_for_amit/Student.dart';

class DailyList extends StatefulWidget {
  @override
  _DailyListState createState() => _DailyListState();
}

class _DailyListState extends State<DailyList> {

  List<Student> studentsInClass = [];
  List<Student> dailyList = [];
  List<Student> notInTfila = [];
  DateTime date = DateTime.now();
  bool firstTime = true;

  @override
  void initState() {
    getStudentsInClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (studentsInClass.isNotEmpty && firstTime){
      getDailyList();
      firstTime = false;
    }
    return ListView(
      children: studentsListWidget(),
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
        print(studentsInClass.length);
        getDailyList();
      });
    });
  }

  getDailyList() {
    print(studentsInClass.length);
    for (int i = 0; i < studentsInClass.length; i++){
      bool dailyBool = getDayNumber(date.weekday-2, studentsInClass[i]);
      if (!dailyBool){
        dailyList.add(studentsInClass[i]);
      }
    }

  }

  bool getDayNumber(int day, Student student){
    switch (day){
      case 7:
        return student.sundayComing;
      case 1:
        return student.mondayComing;
      case 2:
        return student.tuesdayComing;
      case 3:
        return student.wednesdayComing;
      case 4:
        return student.thursdayComing;
    }
  }

  bool studentInList(Student student){
    print(dailyList.length);
    for (int i = 0; i< dailyList.length; i++){
      print(dailyList[i].name);
      if (notInTfila[i]==student){
        return true;
      }
    }
    return false;
  }

  List<Widget> studentsListWidget() {
    List<Widget> listToReturn = [];
    for (int i = 0 ; i < dailyList.length; i++){
      listToReturn.add(ListTile(
        title: Text(
          dailyList[i].name,
          textAlign: TextAlign.right,
        ),
        leading: Icon(
            Icons.check_box_outline_blank,
            color: Colors.blue,
          ),
//          : Icon(
//            Icons.check_box,
//            color: Colors.blue,
//          ),
        onTap: () {
          print(dailyList.length);
//          if (!studentInList(dailyList[i])){
//            notInTfila.remove(dailyList[i]);
//          } else {
//            notInTfila.add(dailyList[i]);
//          }
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => StudentPage(student: studentsInClass[i],)),
//          ).then((val){
//            if(val is Student){
//              studentsInClass[i] = val;
//            }
//          });
          },
      ));
    }
    return listToReturn;
  }
}
