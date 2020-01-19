import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pit_scout/Model/pit_scouting_data_provider.dart';
import 'package:pit_scout/PitScouting/PitTeamDataInput.dart';

class PitScoutingData extends StatelessWidget {
  final String teamName;
  final String teamNumber;
  final String tournament;
  final bool saved;

  PitScoutingData({Key key, @required this.teamName, this.teamNumber, this.tournament, this.saved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PitScoutingDataProvider(this.saved, this.teamName, this.tournament, this.teamNumber),
      child: Container(
        child: Consumer<PitScoutingDataProvider>(
          builder: (context, pitScoutingDataProvider, child) => TeamDataPage(
            teamName: this.teamName,
            teamNumber: this.teamNumber,
            tournament: this.tournament,
            saved: this.saved,
            pitScoutingData: pitScoutingDataProvider.pitScoutingData,
          ),
        ),
      ),
    );
  }
}
