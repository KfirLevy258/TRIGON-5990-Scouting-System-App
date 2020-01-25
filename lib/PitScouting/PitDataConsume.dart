import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pit_scout/Model/PitDataModel.dart';
import 'package:pit_scout/PitScouting/PitDataEdit.dart';

class PitDataConsume extends StatelessWidget {
  final String teamName;
  final String teamNumber;
  final String tournament;
  final bool saved;
  final String userId;

  PitDataConsume({Key key, @required this.teamName, this.teamNumber, this.tournament, this.saved, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<PitDataModel>(context, listen: false).teamSelected(saved, teamName, tournament, teamNumber);

    return Container(
      child: Consumer<PitDataModel>(
        builder: (context, pitDataModel, child) {
          return PitDataEdit(
            teamName: this.teamName,
            teamNumber: this.teamNumber,
            tournament: this.tournament,
            saved: this.saved,
            userId: this.userId,
            pitInitialData: pitDataModel.pitScoutingData,
        );},
      ),
    );
  }
}
