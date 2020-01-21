import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> alert(BuildContext context, String label, String message) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(
            label,
            style: TextStyle(fontSize: 25.0, color: Colors.blue),
            textAlign: TextAlign.center,
          ),
          content: Text(
            message,
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
  );
}