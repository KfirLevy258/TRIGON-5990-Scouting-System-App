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
        pitScoutingData.powerCellAmount = val.data['pit_data']['basic_ability']['power_cells_at_start'];
        pitScoutingData.canStartFromAnyPosition = val.data['pit_data']['basic_ability']['start_from_everywhere'];
        pitScoutingData.canScore = val.data['pit_data']['game']['power_cells'];
        pitScoutingData.canRotateTheRoulette = val.data['pit_data']['game']['rotate_roulette'];
        pitScoutingData.canStopTheRoulette = val.data['pit_data']['game']['stop_roulette'];
        pitScoutingData.canClimb = val.data['pit_data']['end_game']['can_climb'];
        if (pitScoutingData.canClimb){
          pitScoutingData.heightOfTheClimb = val.data['pit_data']['end_game']['climb_hight'];
          pitScoutingData.robotMaxClimb = val.data['pit_data']['end_game']['max_climb'].toString();
          pitScoutingData.robotMinClimb = val.data['pit_data']['end_game']['min_climb'].toString();
        } else {
          pitScoutingData.heightOfTheClimb = 'לא נבחר';
          pitScoutingData.robotMaxClimb = "סנטימטרים";
          pitScoutingData.robotMinClimb = "סנטימטרים";
        }

        pitScoutingData.dtMotorType = val.data['pit_data']['chassis_overall_strength']['dt_motor_type'];
        pitScoutingData.wheelDiameter = val.data['pit_data']['chassis_overall_strength']['wheel_diameter'];
        pitScoutingData.conversionRatio = val.data['pit_data']['chassis_overall_strength']['conversion_ratio'];


        pitScoutingData.robotLengthData = val.data['pit_data']['robot_basic_data']['robot_length'].toString();
        pitScoutingData.robotWeightData = val.data['pit_data']['robot_basic_data']['robot_weight'].toString();
        pitScoutingData.robotWidthData = val.data['pit_data']['robot_basic_data']['robot_width'].toString();
        pitScoutingData.dtMotorsData = val.data['pit_data']['robot_basic_data']['dt_motors'].toString();
      }
      notifyListeners();
    });
  }
  
  void savePitData(PitData pitData, String tournament, String teamNumber) {
    Firestore.instance.collection("tournaments").document(tournament)
        .collection('teams').document(teamNumber.toString()).updateData({
      'pit_scouting_saved': true,
      'pit_data' :{
        'chassis_overall_strength': {
          'conversion_ratio': pitData.conversionRatio,
          'dt_motor_type': pitData.dtMotorType,
          'wheel_diameter': pitData.wheelDiameter
        },
        'robot_basic_data': {
          'robot_weight': pitData.robotWeightData,
          'robot_width': pitData.robotWidthData,
          'robot_length': pitData.robotLengthData,
          'dt_motors': pitData.dtMotorsData,
        },
        'basic_ability': {
          'power_cells_at_start': pitData.powerCellAmount,
          'start_from_everywhere': pitData.canStartFromAnyPosition,
        },
        'game': {
          'power_cells': pitData.canScore,
          'rotate_roulette': pitData.canRotateTheRoulette,
          'stop_roulette': pitData.canStopTheRoulette,
        },
        'end_game': {
          'can_climb': pitData.canClimb,
          'climb_hight': pitData.heightOfTheClimb,
          'min_climb': pitData.robotMinClimb,
          'max_climb': pitData.robotMaxClimb,
        }
      },
    });
  }
}