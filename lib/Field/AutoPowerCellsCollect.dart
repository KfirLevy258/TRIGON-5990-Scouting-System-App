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
//    setOrientation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100,
        height: 100,
        child: Image.asset('assets/Field.png'),
      ),
//      body: GestureDetector(
//        child: Image.asset('assets/Field.png'),
//        onTapDown: ((details) {
//          final Offset offset = details.localPosition;
//          print(offset);
//        }),
//      ),
    );
  }
}
