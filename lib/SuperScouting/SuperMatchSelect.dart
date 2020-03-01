import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pit_scout/Widgets/selectionInput.dart';
import '../Widgets/AllianceSelect.dart';
import 'SuperTeamsView.dart';

class SuperMatchSelect extends StatefulWidget{

  final String tournament;
  final String userId;

  SuperMatchSelect({Key key, @required this.tournament, this.userId}) : super(key: key);

  @override
  SuperMatchSelectState createState() => SuperMatchSelectState(tournament);
}

class SuperMatchSelectState extends State<SuperMatchSelect>{

  String tournament;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _matchController = TextEditingController();
  TextEditingController _qualController = TextEditingController();
  String alliance = 'לא נבחר';
  String _matchKind = 'לא נבחר';


  SuperMatchSelectState(String tournament){
    this.tournament = tournament;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery. of(context). size. height;
    double width = MediaQuery. of(context). size. width;

    return Form(
      key: _formKey,
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all((height/25)),),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                  Padding(padding: EdgeInsets.all(10.0),),
                  getOpenQuestion(_matchController, 'מספר משחק'),
                  allianceSelect((val) {
                    setState(() {
                      this.alliance = val;
                    });
                  }),
                  Text(
                    'הברית שנבחרה: ' + alliance.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: alliance=='הברית האדומה'
                          ? Colors.red
                          : alliance=='הברית הכחולה'
                            ? Colors.blue
                            : Colors.black
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5.0),),
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (_formKey.currentState.validate() && alliance!=null){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TeamsInMatch(
                            qualNumber: int.parse(_matchController.text),
                            alliance: alliance=='הברית האדומה'
                              ? 'Red'
                              : 'Blue',
                             district: tournament, matchKey: getKey(),)),
                        );
                      }
                    },
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Continue",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
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

}



