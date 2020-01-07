import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SuperTeamsView.dart';

class SuperMatchSelect extends StatefulWidget{

  final String tournament;

  SuperMatchSelect({Key key, @required this.tournament}) : super(key: key);

  @override
  SuperMatchSelectState createState() => SuperMatchSelectState(tournament);
}

class SuperMatchSelectState extends State<SuperMatchSelect>{

  String tournament;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _matchController = TextEditingController();
  String alliance;

  SuperMatchSelectState(String tournament){
    this.tournament = tournament;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter Qual number:',
                style: TextStyle(fontSize: 25),
              ),
              Padding(padding: EdgeInsets.all(10.0),),
              Container(
                width: 250,
                child: TextFormField(
                  controller: _matchController,
                  textAlign: TextAlign.center,
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
                      hintText: 'Example: 42'
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0),),
              allianceSelect(),
              FlatButton(
                color: Colors.blue,
                onPressed: () {
                  if (_formKey.currentState.validate() && alliance!=null){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeamsInMatch(qualNumber: int.parse(_matchController.text), alliance: alliance, district: tournament,)),
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
      )
    );
  }

  Widget allianceSelect(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          color: Colors.blue,
          onPressed: (){
            alliance = "Blue";
          },
          child: Text(
            "Blue alliance",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white),

          ),
        ),
        FlatButton(
          color: Colors.red,
          onPressed: (){
            alliance = "Red";
          },
          child: Text(
            "Red alliance",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    );
  }



  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}