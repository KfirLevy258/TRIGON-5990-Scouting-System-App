import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Widgets/booleanInput.dart';

typedef void BoolCallback(bool rotate, bool stop);

class TrenchDialog extends StatefulWidget {
  final String message;
  final BoolCallback boolResult;
  final bool rotate;
  final bool stop;

  TrenchDialog({Key key, this.message, this.boolResult, this.rotate, this.stop}) : super(key: key);

  @override
  _TrenchDialogState createState() => _TrenchDialogState();
}

class _TrenchDialogState extends State<TrenchDialog> {

  bool rotate;
  bool stop;

  @override
  void initState() {
    rotate = widget.rotate;
    stop = widget.stop;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 400,
        child: SingleChildScrollView(
          child: AlertDialog(
            content: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    widget.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Colors.blue, fontStyle: FontStyle.italic),
                  ),
                  Padding(padding: EdgeInsets.all(15.0),),
                  booleanInputWidget('סובב את הגלגל', rotate, (val) => setState(() => rotate=val)),
                  Padding(padding: EdgeInsets.all(10.0),),
                  booleanInputWidget('עצר את הגלגל', stop, (val) => setState(() => stop=val)),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'Close',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },

                  ),
                  FlatButton(
                    child: Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      widget.boolResult(rotate, stop);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
