

import 'package:pit_scout/Model/GameData.dart';
import 'package:flutter/material.dart';

class GameDataModel extends ChangeNotifier {
  final GameData gameData = new GameData();

  void setGameData(String _qualNumber, String _tournament, String _userId, String _teamNumber, String _teamName) {
    this.gameData.qualNumber = _qualNumber;
    this.gameData.tournament = _tournament;
    this.gameData.userId = _userId;
    this.gameData.teamNumber = _teamNumber;
    this.gameData.teamName = _teamName;
  }

  void setPreGameData(String _startingPosition) {
    this.gameData.startingPosition = _startingPosition;
    print(this.gameData.startingPosition);
  }

  void setAutoGameData(int _innerScore, int _outerScore, int _bottomScore, int _autoPowerCellsOnRobotEndOfAuto,
      bool _climb1BallCollected, bool _climb2BallCollected, bool _climb3BallCollected, bool _climb4BallCollected,
      bool _climb5BallCollected, bool _trench1BallCollected, bool _trench2BallCollected, bool _trench3BallCollected,
      bool _trench4BallCollected, bool _trench5BallCollected) {
    this.gameData.autoInnerScore = _innerScore;
    this.gameData.autoOuterScore = _outerScore;
    this.gameData.autoBottomScore = _bottomScore;
    this.gameData.autoPowerCellsOnRobotEndOfAuto = _autoPowerCellsOnRobotEndOfAuto;
    this.gameData.climb1BallCollected = _climb1BallCollected;
    this.gameData.climb2BallCollected = _climb2BallCollected;
    this.gameData.climb3BallCollected = _climb3BallCollected;
    this.gameData.climb4BallCollected = _climb4BallCollected;
    this.gameData.climb5BallCollected = _climb5BallCollected;
    this.gameData.trench1BallCollected = _trench1BallCollected;
    this.gameData.trench2BallCollected = _trench2BallCollected;
    this.gameData.trench3BallCollected = _trench3BallCollected;
    this.gameData.trench4BallCollected = _trench4BallCollected;
    this.gameData.trench5BallCollected = _trench5BallCollected;
    print(this.gameData.autoOuterScore);
  }

  void setTeleopGameData(int _innerScore, int _outerScore, int _bottomScore, bool _trenchRotate,
      bool _trenchStop, List<String> shotFrom) {
    this.gameData.teleopInnerScore = _innerScore;
    this.gameData.teleopOuterScore = _outerScore;
    this.gameData.teleopBottomScore = _bottomScore;
    this.gameData.trenchRotate = _trenchRotate;
    this.gameData.trenchStop = _trenchStop;
    this.gameData.shotFrom = shotFrom;
    print(this.gameData.teleopOuterScore);
  }

  void setEndGameData(String _climbStatus, String _climbLocation, String _whyDidntClimb) {
    this.gameData.climbStatus = _climbStatus;
    this.gameData.climbLocation = _climbLocation;
    this.gameData.whyDidntClimb = _whyDidntClimb;
    print(this.gameData.climbStatus);
  }

  void saveGameData(GameData dataToSave) {
    // save gameData to firebase
  }
}