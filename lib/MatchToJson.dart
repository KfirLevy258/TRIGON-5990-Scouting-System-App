
class Match {
  List<String> blueAlliance;
  List<String> redAlliance;

  Match({this.blueAlliance, this.redAlliance});

  factory Match.fromJson(Map<String, dynamic> json, String district) {
    List<dynamic> blueAllianceKeys = json['alliances']['blue']['team_keys'];
    List<dynamic> redAllianceKeys = json['alliances']['red']['team_keys'];
    List<String> blueAlliance = [];
    List<String> redAlliance = [];
    for (int i=0; i<blueAllianceKeys.length; i++){
      blueAlliance.add(blueAllianceKeys[i].substring(3));
    }
    for (int i=0; i<redAllianceKeys.length; i++){
      redAlliance.add(redAllianceKeys[i].substring(3));
    }

    return Match(
      blueAlliance: blueAlliance,
      redAlliance: redAlliance,
    );
  }


}
