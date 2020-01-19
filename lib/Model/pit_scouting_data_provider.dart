import 'package:pit_scout/Model/pit_scouting_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';

class PitScoutingDataProvider extends ChangeNotifier {

  final PitScoutingData pitScoutingData = new PitScoutingData();
  final bool saved;
  final String teamName;
  final String tournament;
  final String teamNumber;
  
  PitScoutingDataProvider(this.saved, this.teamName, this.tournament, this.teamNumber) {
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
        String conversionRatioData = val.data['Pit_scouting']['Chassis Overall Strength']['Conversion Ratio'];
        List<String> temp = conversionRatioData.split('/');
        pitScoutingData.conversionRatioDataCounter = temp[0];
        pitScoutingData.conversionRatioDataDenominator = temp[1];
        pitScoutingData.robotLengthData = val.data['Pit_scouting']['Robot basic data']['Robot Length'].toString();
        pitScoutingData.robotWeightData = val.data['Pit_scouting']['Robot basic data']['Robot Weight'].toString();
        pitScoutingData.robotWidthData = val.data['Pit_scouting']['Robot basic data']['Robot Width'].toString();
        pitScoutingData.dtMotorsData = val.data['Pit_scouting']['Robot basic data']['DT Motors'].toString();
      }
      notifyListeners();
    });
  }
}