

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
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
  }

  void setTeleopGameData(int _innerScore, int _outerScore, int _bottomScore, bool _trenchRotate,
      bool _trenchStop, List<String> shotFrom) {
    this.gameData.teleopInnerScore = _innerScore;
    this.gameData.teleopOuterScore = _outerScore;
    this.gameData.teleopBottomScore = _bottomScore;
    this.gameData.trenchRotate = _trenchRotate;
    this.gameData.trenchStop = _trenchStop;
    this.gameData.shotFrom = shotFrom;
  }

  void setEndGameData(String _climbStatus, int _climbLocation, String _whyDidntClimb) {
    this.gameData.climbStatus = _climbStatus;
    this.gameData.climbLocation = _climbLocation;
    this.gameData.whyDidntClimb = _whyDidntClimb;
  }

  String getUserId(){
    return this.gameData.userId;
  }

//  void setStartingPosition

  void saveGameData(GameData dataToSave) {
    String scouterName;
    Firestore.instance.collection('users').document(dataToSave.userId).get().then((val) {
      scouterName = val.data['name'];
    });
    Firestore.instance.collection('tournaments').document(dataToSave.tournament).collection('teams')
        .document(dataToSave.teamNumber).collection('Qual ' +dataToSave.qualNumber).document('gameScouting')
        .setData({
      'Pre game' : {
        'starting position': dataToSave.startingPosition,
      },
      'Auto' : {
        'power cells in inner': dataToSave.autoInnerScore,
        'power cells in outer': dataToSave.autoOuterScore,
        'power cells in bottom': dataToSave.autoBottomScore,
        'power cells on robot end of auto': dataToSave.autoPowerCellsOnRobotEndOfAuto,
        'climb 1 power cell collect': dataToSave.climb1BallCollected,
        'climb 2 power cell collect': dataToSave.climb2BallCollected,
        'climb 3 power cell collect': dataToSave.climb3BallCollected,
        'climb 4 power cell collect': dataToSave.climb4BallCollected,
        'climb 5 power cell collect': dataToSave.climb5BallCollected,
        'trench 1 power cell collect': dataToSave.trench1BallCollected,
        'trench 2 power cell collect': dataToSave.trench2BallCollected,
        'trench 3 power cell collect': dataToSave.trench3BallCollected,
        'trench 4 power cell collect': dataToSave.trench4BallCollected,
        'trench 5 power cell collect': dataToSave.trench5BallCollected,
      },
      'Teleop' : {
        'power cells in inner': dataToSave.teleopInnerScore,
        'power cells in outer': dataToSave.teleopOuterScore,
        'power cells in bottom': dataToSave.teleopBottomScore,
        'rotate the trench': dataToSave.trenchRotate,
        'stop the trench': dataToSave.trenchStop,
      },
      'EndGame' : {
        'climb status': dataToSave.climbStatus,
        'climb location': dataToSave.climbLocation,
        'climb location': dataToSave.climbStatus=='טיפס בהצלחה'
            ? dataToSave.climbLocation
            : null,
        'why didnt climb': dataToSave.climbStatus=='ניסה ולא הצליח'
            ? dataToSave.whyDidntClimb
            : null,
      },
      'scouter name': scouterName,
    });
  }
}