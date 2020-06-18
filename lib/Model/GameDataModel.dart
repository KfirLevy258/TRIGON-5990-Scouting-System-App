

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pit_scout/Model/GameData.dart';
import 'package:flutter/material.dart';

import '../DataPackages.dart';
import '../RSAEncrypt.dart';

class GameDataModel extends ChangeNotifier {
  GameData gameData = new GameData();

  void setWinningAlliance(String _winningAlliance, bool _climbRP, bool _ballsRP){
    this.gameData.winningAlliance = _winningAlliance;
    this.gameData.climbRP = _climbRP;
    this.gameData.ballsRP = _ballsRP;
  }

  void setGameData(String _qualNumber, String _tournament, String _userId, String _teamNumber, String _teamName,
      String allianceColor, String _matchKey) {
    this.gameData.qualNumber = _qualNumber;
    this.gameData.matchKey = _matchKey;
    this.gameData.tournament = _tournament;
    this.gameData.userId = _userId;
    this.gameData.teamNumber = _teamNumber;
    this.gameData.teamName = _teamName;
    this.gameData.allianceColor = allianceColor;
  }

  void setPreGameData(String _startingPosition) {
    this.gameData.startingPosition = _startingPosition;
    print(this.gameData.startingPosition);
  }

  void setAutoGameData(int _innerScore, int _outerScore, int _bottomScore,
      int _upperShoot, int _bottomShoot, List<AutoUpperTargetData> _upperData,
      bool _climb1BallCollected, bool _climb2BallCollected, bool _climb3BallCollected, bool _climb4BallCollected,
      bool _climb5BallCollected, bool _trench1BallCollected, bool _trench2BallCollected, bool _trench3BallCollected,
      bool _trench4BallCollected, bool _trench5BallCollected, bool _trenchSteal1BallCollected, bool _trenchSteal2BallCollected,
      bool _autoLine) {
    this.gameData.autoInnerScore = _innerScore;
    this.gameData.autoOuterScore = _outerScore;
    this.gameData.autoBottomScore = _bottomScore;
    this.gameData.autoUpperShoot = _upperShoot;
    this.gameData.autoBottomShoot = _bottomShoot;
    this.gameData.autoUpperData = _upperData;
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
    this.gameData.trenchSteal1BallCollected = _trenchSteal1BallCollected;
    this.gameData.trenchSteal2BallCollected = _trenchSteal2BallCollected;
    this.gameData.autoLine = _autoLine;
  }

  void setTeleopGameData(int _innerScore, int _outerScore, int _bottomScore, bool _trenchRotate,
      bool _trenchStop, int _upperShoot, int _bottomShoot, List<TeleopUpperTargetData> _upperData,
      bool _didDefense, int _fouls, int preventedBalls) {
    this.gameData.teleopInnerScore = _innerScore;
    this.gameData.teleopOuterScore = _outerScore;
    this.gameData.teleopBottomScore = _bottomScore;
    this.gameData.trenchRotate = _trenchRotate;
    this.gameData.trenchStop = _trenchStop;
    this.gameData.teleopUpperShoot = _upperShoot;
    this.gameData.teleopBottomShoot = _bottomShoot;
    this.gameData.teleopUpperData = _upperData;
    this.gameData.preventedBalls = preventedBalls;
    this.gameData.fouls = _fouls;
    this.gameData.didDefense = _didDefense;
  }

  void setEndGameData(String _climbStatus, int _climbLocation, String _whyDidntClimb) {
    this.gameData.climbStatus = _climbStatus;
    this.gameData.climbLocation = _climbLocation;
    this.gameData.whyDidntClimb = _whyDidntClimb;
  }

  String getUserId(){
    return this.gameData.userId;
  }

  void resetGameData() {
    this.gameData = new GameData();
  }

  void saveGameData(GameData dataToSave) {
    objectEncrypt(dataToSave).then((encryptedData) {
      Firestore.instance.collection('tournaments').document(dataToSave.tournament).collection('teams')
          .document(dataToSave.teamNumber).collection('games').document(dataToSave.matchKey).get().then((val) {
        if (val.data==null){
          Firestore.instance.collection('tournaments').document(dataToSave.tournament).collection('teams')
              .document(dataToSave.teamNumber).collection('games').document(dataToSave.matchKey)
              .setData({
            'Game scouting': {
              'allianceColor' : encryptedData[0],
              'PreGame' : {
                'startingPosition': encryptedData[1],
              },
              'Auto' : {
                'innerScore': encryptedData[2],
                'outerScore': encryptedData[3],
                'bottomScore': encryptedData[6],
                'bottomShoot': encryptedData[7],
                'upperShoot': encryptedData[5],
                'climb1BallCollected': encryptedData[9],
                'climb2BallCollected': encryptedData[10],
                'climb3BallCollected': encryptedData[11],
                'climb4BallCollected': encryptedData[12],
                'climb5BallCollected': encryptedData[13],
                'trench1BallCollected': encryptedData[14],
                'trench2BallCollected': encryptedData[15],
                'trench3BallCollected': encryptedData[16],
                'trench4BallCollected': encryptedData[17],
                'trench5BallCollected': encryptedData[18],
                'trenchSteal1BallCollected': encryptedData[19],
                'trenchSteal2BallCollected': encryptedData[20],
                'autoLine': encryptedData[21],
                'upperData' : autoUpperTargetDataToData(encryptedData[38]),
              },
              'Teleop' : {
                'Sum' : {
                  'innerScore': encryptedData[22],
                  'outerScore': encryptedData[23],
                  'upperShoot' : encryptedData[24],
                  'bottomScore': encryptedData[25],
                  'bottomShoot' : encryptedData[26],
                  'trenchRotate': encryptedData[29],
                  'trenchStop': encryptedData[30],
                  'didDefense': encryptedData[31],
                  'fouls': encryptedData[27],
                  'preventedFouls': encryptedData[28],
                },
                'upperData' : teleopUpperTargetDataToData(encryptedData[37]),
              },
              'EndGame' : {
                'climbStatus': encryptedData[33],
                'climbLocation': encryptedData[34],
                'climbLocation': dataToSave.climbStatus=='Climbed successfully'
                    ? encryptedData[34]
                    : null,
                'whyDidntClimb': dataToSave.climbStatus=='Didnt tried'
                    ? encryptedData[35]
                    : null,
              },
              'climbRP': encryptedData[36],
              'ballsRP': encryptedData[32],
              'matchNumber': dataToSave.qualNumber,
//              'gameRP' :dataToSave.winningAlliance==dataToSave.allianceColor
//                  ? 2
//                  : dataToSave.winningAlliance=='תיקו'
//                  ? 1
//                  : 0
            },
          });
        } else {
          Firestore.instance.collection('tournaments').document(dataToSave.tournament).collection('teams')
              .document(dataToSave.teamNumber).collection('games').document(dataToSave.matchKey)
              .updateData({
            'Game scouting': {
              'allianceColor' : encryptedData[0],
              'PreGame' : {
                'startingPosition': encryptedData[1],
              },
              'Auto' : {
                'innerScore': encryptedData[2],
                'outerScore': encryptedData[3],
                'bottomScore': encryptedData[6],
                'bottomShoot': encryptedData[7],
                'upperShoot': encryptedData[5],
                'climb1BallCollected': encryptedData[9],
                'climb2BallCollected': encryptedData[10],
                'climb3BallCollected': encryptedData[11],
                'climb4BallCollected': encryptedData[12],
                'climb5BallCollected': encryptedData[13],
                'trench1BallCollected': encryptedData[14],
                'trench2BallCollected': encryptedData[15],
                'trench3BallCollected': encryptedData[16],
                'trench4BallCollected': encryptedData[17],
                'trench5BallCollected': encryptedData[18],
                'trenchSteal1BallCollected': encryptedData[19],
                'trenchSteal2BallCollected': encryptedData[20],
                'autoLine': encryptedData[21],
                'upperData' : autoUpperTargetDataToData(encryptedData[38]),
              },
              'Teleop' : {
                'Sum' : {
                  'innerScore': encryptedData[22],
                  'outerScore': encryptedData[23],
                  'upperShoot' : encryptedData[24],
                  'bottomScore': encryptedData[25],
                  'bottomShoot' : encryptedData[26],
                  'trenchRotate': encryptedData[29],
                  'trenchStop': encryptedData[30],
                  'didDefense': encryptedData[31],
                  'fouls': encryptedData[27],
                  'preventedFouls': encryptedData[28],
                },
                'upperData' : teleopUpperTargetDataToData(encryptedData[37]),
              },
              'EndGame' : {
                'climbStatus': encryptedData[33],
                'climbLocation': encryptedData[34],
                'climbLocation': dataToSave.climbStatus=='Climbed successfully'
                    ? encryptedData[34]
                    : null,
                'whyDidntClimb': dataToSave.climbStatus=='Didnt tried'
                    ? encryptedData[35]
                    : null,
              },
              'climbRP': encryptedData[36],
              'ballsRP': encryptedData[32],
              'matchNumber': dataToSave.qualNumber,
//              'gameRP' :dataToSave.winningAlliance==dataToSave.allianceColor
//                  ? 2
//                  : dataToSave.winningAlliance=='תיקו'
//                  ? 1
//                  : 0
            },
          });
        }
      });
      Firestore.instance.collection('users').document(dataToSave.userId).collection('tournaments').document(dataToSave.tournament)
          .collection('gamesToScout').document(dataToSave.qualNumber).get().then((val) {
        if (val.data != null){
          Firestore.instance.collection('users').document(dataToSave.userId).collection('tournaments').document(dataToSave.tournament)
              .collection('gamesToScout').document(dataToSave.qualNumber).updateData({
            'saved': true,
          });
        }
      });
    });
  }

  List<Map<String, String>> teleopUpperTargetDataToData(List<dynamic> list) {
    List<Map<String, String>> listToReturn = [];
    list.forEach((element) {
      listToReturn.add({
        'innerScore': element[0],
        'outerScore': element[1],
        'shoot': element[2],
        'x': element[3],
        'y': element[4],
      });
    });
    return listToReturn;
  }

  List<Map<String, String>> autoUpperTargetDataToData(List<dynamic> list) {
    List<Map<String, String>> listToReturn = [];
    list.forEach((element) {
      listToReturn.add({
        'innerScore': element[0],
        'outerScore': element[1],
        'shoot': element[2],
      });
    });
    return listToReturn;
  }
}