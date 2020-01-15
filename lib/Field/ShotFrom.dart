import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShotFrom extends StatefulWidget {

  @override
  _ShotFromState createState() => _ShotFromState();
}

class _ShotFromState extends State<ShotFrom> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'בחירת מיקום יריית כדורים',
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: GestureDetector(
              child: Image.asset(
                'assets/Field.png',
                fit: BoxFit.fitWidth,
              ),
              onTapDown: ((details) {
                final Offset offset = details.localPosition;
                Navigator.pop(context, offset);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
