import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool saved = false;

//Widget powerPort(BuildContext context) {
//  return Container(
//    child: GestureDetector(
//      child: Image.asset('assets/PowerPort.png'),
//      onTapDown: ((details)  {
//        final Offset offset = details.localPosition;
//        if (offset.dx > 40 && offset.dx < 170 && offset.dy > 45 && offset.dy < 160) upTargetDialog(context, 'Up Port');
//        if (offset.dx > 25 && offset.dx < 180 && offset.dy > 310 && offset.dy < 390) bottomTargetDialog(context, 'Bottom Port');
//      }),
//    ),
//  );
//}

Widget rowInUpTarget(String label, String imagePath){
  return Row(
    children: <Widget>[
      Container(
        width: 70,
        child: Image.asset(imagePath),
      ),
      Text(
        label,
        textAlign: TextAlign.center,
      ),
      Padding(padding: EdgeInsets.all(10.0),),
      Row(
        children: amountOfPowerCells(5),
      ),
    ],
  );
}

List<Widget> amountOfPowerCells(int amount) {
  List<Widget> toReturn = [];
  for (int i=0; i<amount; i++){
    toReturn.add(powerCell());
    toReturn.add(Padding(padding: EdgeInsets.all(4.0,)));
  }
  return toReturn;
}

Widget powerCell(){
  return  GestureDetector(
    onTap: () {
      saved=!saved;
    },
    child: ClipOval(
        child: Container(
          width: 30,
          height: 30,
          color: Colors.yellow,
//          child:Icon(Icons.check),
        )
    ),
  );
}

//bottomTargetDialog(context, String message) {
//  showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          content: Container(
//            child: Column(
//              children: <Widget>[
//                Text(
//                  message,
//                  style: TextStyle(fontSize: 20.0, color: Colors.blue, fontStyle: FontStyle.italic),
//                  textAlign: TextAlign.center,
//                ),
//                powerCell(),
//              ],
//            ),
//          ),
//
//          actions: <Widget>[
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                FlatButton(
//                  color: Colors.redAccent,
//                  child: Text(
//                    'Close',
//                    textAlign: TextAlign.center,
//                  ),
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//
//                ),
//                FlatButton(
//                  child: Text(
//                    'Save',
//                    textAlign: TextAlign.center,
//                  ),
//                  color: Colors.green,
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//
//                ),
//              ],
//            )
//          ],
//        );
//      }
//  );
//}

upTargetDialog(context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            child: Column(
              children: <Widget>[
                Text(
                  message,
                  style: TextStyle(fontSize: 20.0, color: Colors.blue, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                rowInUpTarget('Inner\nPort', 'assets/Inner.png'),
                rowInUpTarget('Outer\nPort', 'assets/Outer.png'),
              ],
            ),
          ),

          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.redAccent,
                  child: Text(
                    'Close',
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },

                ),
                FlatButton(
                  child: Text(
                    'Save',
                    textAlign: TextAlign.center,
                  ),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },

                ),
              ],
            )
          ],
        );
      }
  );
}