import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AutoPowerCellsCollect extends StatefulWidget {
  @override
  _AutoPowerCellsCollectState createState() => _AutoPowerCellsCollectState();
}

class _AutoPowerCellsCollectState extends State<AutoPowerCellsCollect> {

  setOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  }

  @override
  void initState() {
    setOrientation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'בחירת מיקום איסוף כדורים',
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: GestureDetector(
          child: Image.asset(
            'assets/Field.png',
            fit: BoxFit.fitWidth,
          ),
          onTapDown: ((details) {
            final Offset offset = details.localPosition;
            print(offset);
          }),
        ),
      ),
    );
  }
}
