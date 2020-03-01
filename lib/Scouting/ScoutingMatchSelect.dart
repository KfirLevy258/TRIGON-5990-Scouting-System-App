import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Model/GameDataModel.dart';
import 'package:pit_scout/Widgets/alert.dart';
import 'package:pit_scout/Widgets/selectionInput.dart';
import 'package:provider/provider.dart';

import 'ScoutingTeamView.dart';

class ScoutingMatchSelect extends StatefulWidget {
  final String userId;
  final String tournament;

  ScoutingMatchSelect({Key key, this.tournament, this.userId}) : super(key: key);

  @override
  ScoutingMatchSelectState createState() => ScoutingMatchSelectState();
}

class ScoutingMatchSelectState extends State<ScoutingMatchSelect> {
  TextEditingController _qualNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _matchController = TextEditingController();
  TextEditingController _qualController = TextEditingController();

  String _winningAlliance = 'לא נבחר';
  String _matchKind = 'לא נבחר';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery. of(context). size. height;
    double width = MediaQuery. of(context). size. width;
    return Form(
        key: _formKey,
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all((height/25)),),
                    Text(
                      'Enter Qual number:',
                      style: TextStyle(fontSize: 25),
                    ),
                    Padding(padding: EdgeInsets.all(10.0),),
                    Container(
                      width: width-150,
                      child: selectionInputWidget('סוג מקצה', _matchKind, ["דירוג", "רבע גמר", "חצי גמר", "גמר", "אימון"],
                              (val) { setState(() => _matchKind= val);}),
                    ),
                    Padding(padding: EdgeInsets.all(10.0),),
                    _matchKind == "רבע גמר" || _matchKind == "חצי גמר" || _matchKind == "גמר"
                      ? getOpenQuestion(_qualController, 'מספר מקצה')
                      : Container(),
                    getOpenQuestion(_matchController, 'מספר משחק'),
                    Container(
                      width: width-150,
                      child: selectionInputWidget('ברית מנצחת לדעתך', _winningAlliance, ["כחולה", "אדומה"],
                              (val) { setState(() => _winningAlliance= val);}),
                    ),
                    Padding(padding: EdgeInsets.all(10.0),),
                    FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        if (_formKey.currentState.validate() && _winningAlliance!='לא נבחר'){
                          String key = getKey();
                          print(key);
                          Provider.of<GameDataModel>(context, listen: false).setWinningAlliance(_winningAlliance);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ScoutingTeamView(qualNumber: _matchController.text, tournament: widget.tournament, userId: widget.userId, matchKey: getKey(),)),
                          );
                        } else {
                          alert(
                            context,
                            "שגיאה",
                            "לא מילאת את כל שדות החובה",
                          );
                        }
                      },
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Continue",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0),),

                  ],
                ),
              ),
            ],
          ),
        )
    );
  }


  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  bool canMoveToNExtPage(){
    if (_qualNumber.text==''){
      return false;
    }
    return true;
  }

  String getKey() {
    String key = '';
    if (_matchKind == "רבע גמר" || _matchKind == "חצי גמר" || _matchKind == "גמר") {
      switch (_matchKind){
        case "רבע גמר":
          {
            key += 'qf';
          } break;
        case "חצי גמר":
          {
            key += 'sf';
          } break;
        case "גמר":
          {
            key += 'f';
          } break;
      }
      key += _qualController.text + 'm' + _matchController.text;
    }
    else {
      switch (_matchKind){
        case "דירוג":
          {
            key += 'qm';
          } break;
        case "אימון":
          {
            key += 'pr';
          } break;
      }
      key += _matchController.text;
    }
    return key;
  }

  Widget getOpenQuestion(TextEditingController controller, String text) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 250,
            child: TextFormField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.numberWithOptions(),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter value';
                }
                if (!this.isNumeric(value)) {
                  return 'Please enter only digits';
                }
                double numericValue = double.parse(value);
                if (numericValue < 0) {
                  return 'Value must be bigger then 0';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintStyle: TextStyle(fontSize: 20),
                  hintText: text
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0),),
        ],
      ),
    );
  }
}
