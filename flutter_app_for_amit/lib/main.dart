import 'package:flutter/material.dart';
import 'package:flutter_app_for_amit/StudentsSettings.dart';

import 'DailyList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'King Kfir',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex=0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'רשימת שמות יב׳2',
          textAlign: TextAlign.center,
        ),
      ),
      body: bodyWidgetSelect(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex: currentIndex, // new
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('רשימת שמות יומית'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('הגדרות של תלמידים')
          )
        ],
      ),
    );
  }

  Widget bodyWidgetSelect(index) {
    switch (index) {
      case 0: return DailyList();
      case 1: return StudentsSettings();
      default: return Container();
    }
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
