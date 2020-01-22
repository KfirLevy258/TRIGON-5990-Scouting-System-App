

import 'package:pit_scout/Model/GameData.dart';
import 'package:flutter/material.dart';

class GameDataModel extends ChangeNotifier {
  final GameData gameData = new GameData();

  void setGameData(String _qualNumner, String _tournamrnt, String _userId, String _teamNumber, String _teamName) {
    // update gameData;
    this.gameData.qualNumber = _qualNumner;
    this.gameData.tournament = _tournamrnt;
    this.gameData.userId = _userId;
    this.gameData.teamNumber = _teamNumber;
    this.gameData.teamName = _teamName;

    print('new game data');
    print(_teamNumber);
  }

  void saveGameData(GameData dataToSave) {
    // save gameData to firebase
  }
}