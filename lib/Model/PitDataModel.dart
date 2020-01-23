import 'package:pit_scout/Model/PitData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

class PitDataModel extends ChangeNotifier {

  PitData pitScoutingData = new PitData();
  bool saved;
  String teamName;
  String tournament;
  String teamNumber;

  void teamSelected(bool _saved, String _teamName, String _tournament, String _teamNumber) {
    this.pitScoutingData = new PitData();

    this.saved = _saved;
    this.teamName = _teamName;
    this.tournament = _tournament;
    this.teamNumber = _teamNumber;
    if (saved) {
      loadPitScoutingData();
    }
  }


  void loadPitScoutingData() {
    Firestore.instance.collection('tournaments').document(this.tournament).collection('teams').document(this.teamNumber).get().then((val){
      if (val.documentID.length > 0) {
        pitScoutingData.powerCellAmount = val.data['Pit_scouting']['Basic ability']['Power cells when start the game'];
        pitScoutingData.canStartFromAnyPosition = val.data['Pit_scouting']['Basic ability']['Can start from any position'];
        pitScoutingData.canScore = val.data['Pit_scouting']['Due game']['Can work with power cells'];
        pitScoutingData.canRotateTheRoulette = val.data['Pit_scouting']['Due game']['Can rotate the roulette '];
        pitScoutingData.canStopTheRoulette = val.data['Pit_scouting']['Due game']['Can stop the wheel'];
        pitScoutingData.canClimb = val.data['Pit_scouting']['End game']['Can climb'];
        if (pitScoutingData.canClimb){
          pitScoutingData.heightOfTheClimb = val.data['Pit_scouting']['End game']['Climb hight'];
          pitScoutingData.robotMaxClimb = val.data['Pit_scouting']['End game']['Max hight climb'].toString();
          pitScoutingData.robotMinClimb = val.data['Pit_scouting']['End game']['Min hight climb'].toString();
        } else {
          pitScoutingData.heightOfTheClimb = 'לא נבחר';
          pitScoutingData.robotMaxClimb = "סנטימטרים";
          pitScoutingData.robotMinClimb = "סנטימטרים";
        }

        pitScoutingData.dtMotorType = val.data['Pit_scouting']['Chassis Overall Strength']['DT Motor type'];
        pitScoutingData.wheelDiameter = val.data['Pit_scouting']['Chassis Overall Strength']['Wheel Diameter'];
        pitScoutingData.conversionRatio = val.data['Pit_scouting']['Chassis Overall Strength']['Conversion Ratio'];


        pitScoutingData.robotLengthData = val.data['Pit_scouting']['Robot basic data']['Robot Length'].toString();
        pitScoutingData.robotWeightData = val.data['Pit_scouting']['Robot basic data']['Robot Weight'].toString();
        pitScoutingData.robotWidthData = val.data['Pit_scouting']['Robot basic data']['Robot Width'].toString();
        pitScoutingData.dtMotorsData = val.data['Pit_scouting']['Robot basic data']['DT Motors'].toString();
      }
      notifyListeners();
    });
  }
  
  void savePitData(PitData pitData, String tournament, String teamNumber) {
    Firestore.instance.collection("tournaments").document(tournament)
        .collection('teams').document(teamNumber.toString()).updateData({
      'pit_scouting_saved': true,
      'Pit_scouting' :{
        'Chassis Overall Strength': {
          'Conversion Ratio': pitData.conversionRatio,
          'DT Motor type': pitData.dtMotorType,
          'Wheel Diameter': pitData.wheelDiameter
        },
        'Robot basic data': {
          'Robot Weight': pitData.robotWeightData,
          'Robot Width': pitData.robotWidthData,
          'Robot Length': pitData.robotLengthData,
          'DT Motors': pitData.dtMotorsData,
        },
        'Basic ability': {
          'Power cells when start the game': pitData.powerCellAmount,
          'Can start from any position': pitData.canStartFromAnyPosition,
        },
        'Due game': {
          'Can work with power cells': pitData.canScore,
          'Can rotate the roulette ': pitData.canRotateTheRoulette,
          'Can stop the roulette': pitData.canStopTheRoulette,
        },
        'End game': {
          'Can climb': pitData.canClimb,
          'Climb hight': pitData.heightOfTheClimb,
          'Min hight climb': pitData.robotMinClimb,
          'Max hight climb': pitData.robotMaxClimb,
        }
      },
    });
  }
}