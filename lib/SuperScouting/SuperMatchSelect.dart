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
  String alliance = 'Not selected';
  String _matchKind = 'Not selected';


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
                    'Enter Match data:',
                    style: TextStyle(fontSize: 25),
                  ),
                  Padding(padding: EdgeInsets.all(10.0),),
                  Container(
                    width: width-120,
                    child: selectionInputWidget('Match kind', _matchKind, ["Qual", "Quarter-finals", "Semifinals", "Finals", "Practice"],
                            (val) { setState(() => _matchKind= val);}),
                  ),
                  Padding(padding: EdgeInsets.all(10.0),),
                  _matchKind == "Quarter-finals" || _matchKind == "Semifinals" || _matchKind == "Finals"
                      ? getOpenQuestion(_qualController, 'Heat number')
                      : Container(),
                  Padding(padding: EdgeInsets.all(10.0),),
                  getOpenQuestion(_matchController, 'Match number'),
                  allianceSelect((val) {
                    setState(() {
                      this.alliance = val;
                    });
                  }),
                  Text(
                    'Alliance: ' + alliance.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: alliance=='Red'
                          ? Colors.red
                          : alliance=='Blue'
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
                            alliance: alliance=='Red'
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
    if (_matchKind == "Quarter-finals" || _matchKind == "Semifinals" || _matchKind == "Finals") {
      switch (_matchKind){
        case "Quarter-finals":
          {
            key += 'qf';
          } break;
        case "Semifinals":
          {
            key += 'sf';
          } break;
        case "Finals":
          {
            key += 'f';
          } break;
      }
      key += _qualController.text + 'm' + _matchController.text;
    }
    else {
      switch (_matchKind){
        case "Qual":
          {
            key += 'qm';
          } break;
        case "Practice":
          {
            key += 'pr';
          } break;
      }
      key += _matchController.text;
    }
    return key;
  }

}



