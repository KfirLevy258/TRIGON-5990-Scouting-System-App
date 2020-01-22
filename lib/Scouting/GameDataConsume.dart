import 'package:flutter/material.dart';
import 'package:pit_scout/Scouting/ScoutingDataReview.dart';
import 'package:provider/provider.dart';
import 'package:pit_scout/Model/GameDataModel.dart';


class GameDataConsume extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<GameDataModel>(
        builder: (context, gameDataModel, child) {
          return ScoutingDataReview(gameData: gameDataModel.gameData,);
        },
      ),
    );
  }
}
