import 'package:cloud_firestore/cloud_firestore.dart';

class Match {
  List<dynamic> blueAllianceKeys;
  List<dynamic> redAllianceKeys;

  Match({this.blueAllianceKeys, this.redAllianceKeys});

  factory Match.fromJson(Map<String, dynamic> json) {
//    print(json['alliances']['blue']['team_keys']);
//    print(json['alliances']['red']['team_keys']);

    return Match(
      blueAllianceKeys: json['alliances']['blue']['team_keys'],
      redAllianceKeys: json['alliances']['red']['team_keys'],
    );
  }
}


class Team {
  String key;
  String teamNumber;
  String teamName;

  Team({this.teamNumber, this.teamName, this.key});

  factory Team.fromJson(Map<String, dynamic> json) {
    print(json['key']);
    print(json['team_number']);
    return Team(
      key: json['key'],
      teamNumber: json['team_number'],
      teamName: json['nickname']
    );
  }
}